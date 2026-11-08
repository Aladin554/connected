<?php

namespace Tests\Feature;

use App\Http\Middleware\RestrictAdminIp;
use App\Jobs\GenerateCareerReport;
use App\Models\CareerReport;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\Client\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Queue;
use Laravel\Sanctum\Sanctum;
use RuntimeException;
use Tests\TestCase;

class CareerReportTest extends TestCase
{
    use RefreshDatabase;

    private const OPENAI_URL = 'api.openai.com/*';

    private array $questionIds = [];

    protected function setUp(): void
    {
        parent::setUp();

        $this->withoutMiddleware(RestrictAdminIp::class);
        config(['services.openai.key' => 'test-key', 'services.openai.model' => 'test-model']);

        $owner = $this->makeUser(1, 'owner@example.com');
        foreach ($this->questions() as [$title, $first, $second]) {
            $this->questionIds[] = DB::table('user_questionnaire_answers')->insertGetId([
                'user_id' => $owner->id,
                'title' => $title,
                'details' => "<p>{$title}?</p>",
                'first_option' => $first,
                'second_option' => $second,
            ]);
        }

        DB::table('industries')->insert([
            'id' => 1,
            'title' => 'Improve health?',
            'name' => 'Healthcare and Medicine Industry',
        ]);
        DB::table('departments')->insert(['id' => 8, 'industry_id' => 1, 'name' => 'Patient Care Services']);
        DB::table('sub_departments')->insert([
            ['id' => 7, 'industry_id' => 1, 'department_id' => 8, 'name' => 'Nursing'],
            ['id' => 10, 'industry_id' => 1, 'department_id' => 8, 'name' => 'Surgical Services'],
        ]);
        DB::table('common_departments')->insert(['id' => 4, 'name' => 'Customer Service']);
    }

    public function test_students_cannot_use_the_report_generator(): void
    {
        $student = $this->completedStudent();
        Sanctum::actingAs($student);

        $this->getJson("/api/career-reports/{$student->id}")->assertForbidden();
        $this->postJson("/api/career-reports/{$student->id}/generate", $this->inputs())->assertForbidden();
    }

    public function test_admin_can_open_students_only_but_superadmin_can_open_any_account(): void
    {
        $otherAdmin = $this->makeUser(2, 'other-admin@example.com');
        $student = $this->completedStudent();

        Sanctum::actingAs($this->makeUser(2, 'admin@example.com'));
        $this->getJson("/api/career-reports/{$student->id}")->assertOk();
        $this->getJson("/api/career-reports/{$otherAdmin->id}")->assertForbidden();

        Sanctum::actingAs($this->makeUser(1, 'super@example.com'));
        $this->getJson("/api/career-reports/{$otherAdmin->id}")->assertOk();
    }

    public function test_report_cannot_start_until_every_assessment_step_is_done(): void
    {
        Queue::fake();
        Sanctum::actingAs($this->makeUser(2, 'admin@example.com'));

        $noAnswers = $this->makeUser(3, 'no-answers@example.com');
        $this->selectDepartments($noAnswers);
        $this->postJson("/api/career-reports/{$noAnswers->id}/generate", $this->inputs())
            ->assertStatus(422)
            ->assertJsonPath('missing.0', 'The student has answered 0 of 15 personality questions.');

        $noDepartments = $this->makeUser(3, 'no-departments@example.com');
        $this->answerAll($noDepartments);
        $this->getJson("/api/career-reports/{$noDepartments->id}")
            ->assertOk()
            ->assertJsonPath('data.assessment.complete', false);
        $this->postJson("/api/career-reports/{$noDepartments->id}/generate", $this->inputs())->assertStatus(422);

        Queue::assertNothingPushed();
    }

    public function test_repeat_answer_rows_count_once_and_the_latest_answer_is_used(): void
    {
        $student = $this->completedStudent();
        $outdoor = $this->questionIds[8];
        DB::table('user_submitted_answers')->insert([
            'user_id' => $student->id,
            'question_id' => $outdoor,
            'selected_option' => 'No, I prefer being confined to an office environment with a predictable day',
        ]);

        Sanctum::actingAs($this->makeUser(2, 'admin@example.com'));
        $response = $this->getJson("/api/career-reports/{$student->id}")->assertOk();

        $response->assertJsonPath('data.assessment.answered', 15);
        $response->assertJsonPath('data.assessment.complete', true);
        $this->assertSame(
            'Prefers an office environment with a predictable day',
            collect($response->json('data.system_data.personality'))->firstWhere('area', 'Outdoor Work')['preference'],
        );
    }

    public function test_required_inputs_are_enforced_and_saved(): void
    {
        Queue::fake();
        $student = $this->completedStudent();
        Sanctum::actingAs($this->makeUser(2, 'admin@example.com'));

        $this->postJson("/api/career-reports/{$student->id}/generate", [])
            ->assertStatus(422)
            ->assertJsonValidationErrors(['target_country', 'study_level'])
            ->assertJsonMissingValidationErrors(['education_level', 'report_date']);

        $this->postJson("/api/career-reports/{$student->id}/generate", [
            'target_country' => 'United Kingdom',
            'study_level' => 'Undergraduate',
            'report_date' => '2020-01-01',
        ])->assertStatus(202);

        Queue::assertPushed(GenerateCareerReport::class);
        $report = CareerReport::where('user_id', $student->id)->first();
        $this->assertSame(CareerReport::STATUS_GENERATING, $report->status);
        $this->assertSame('United Kingdom', $report->target_country);
        $this->assertNull($report->education_level);
        // The report date is set by the server, whatever the browser sends.
        $this->assertSame(today()->toDateString(), $report->report_date->toDateString());
    }

    public function test_a_second_generate_is_blocked_unless_the_first_job_was_lost(): void
    {
        Queue::fake();
        $student = $this->completedStudent();
        Sanctum::actingAs($this->makeUser(2, 'admin@example.com'));

        $this->postJson("/api/career-reports/{$student->id}/generate", $this->inputs())->assertStatus(202);
        $this->postJson("/api/career-reports/{$student->id}/generate", $this->inputs())->assertStatus(409);

        DB::table('career_reports')->update(['updated_at' => now()->subMinutes(20)]);
        $this->postJson("/api/career-reports/{$student->id}/generate", $this->inputs())->assertStatus(202);
    }

    public function test_generated_draft_uses_fixed_labels_and_sends_original_answers_to_openai(): void
    {
        Http::fake([self::OPENAI_URL => $this->openAiResponse($this->validContent())]);
        $report = $this->generateFor($this->completedStudent());

        $this->assertSame(CareerReport::STATUS_DRAFT, $report->status);
        $this->assertSame([], $report->issues);
        $this->assertSame('test-model', $report->model);
        $this->assertArrayNotHasKey('introduction', $report->content);

        $personality = collect($report->snapshot['personality']);
        $this->assertSame(
            'Feels very anxious leading people',
            $personality->firstWhere('area', 'Leadership & Influence')['preference'],
        );
        $this->assertSame('Work-Life Balance', $personality[2]['area']);

        Http::assertSent(function (Request $request) {
            $body = $request->data();

            return $body['store'] === false
                && $body['model'] === 'test-model'
                && $body['text']['format']['type'] === 'json_schema'
                && $body['text']['format']['strict'] === true
                && str_contains($body['input'], 'I love being outdoors all the time')
                && str_contains($body['input'], 'United Kingdom')
                && !array_key_exists('introduction', $body['text']['format']['schema']['properties'])
                && !array_key_exists('verification_notes', $body['text']['format']['schema']['properties'])
                && !str_contains($body['input'], 'student@example.com');
        });
    }

    public function test_a_failed_check_is_sent_back_for_one_repair(): void
    {
        $bad = $this->validContent();
        $bad['best_fit_program']['program'] = 'BSc (Hons) Biomedical Science';

        Http::fake([
            self::OPENAI_URL => Http::sequence()
                ->push($this->openAiBody($bad))
                ->push($this->openAiBody($this->validContent())),
        ]);

        $report = $this->generateFor($this->completedStudent());

        Http::assertSentCount(2);
        $this->assertSame([], $report->issues);
        Http::assertSent(fn (Request $request) => str_contains(
            $request->data()['input'],
            'Best Fit Program "BSc (Hons) Biomedical Science" is not in the Final Recommendation list.',
        ));
    }

    public function test_a_report_that_still_fails_cannot_be_approved(): void
    {
        $bad = $this->validContent();
        $bad['best_fit_program']['program'] = 'BSc (Hons) Biomedical Science';
        Http::fake([self::OPENAI_URL => $this->openAiResponse($bad)]);

        $student = $this->completedStudent();
        $report = $this->generateFor($student);

        $this->assertTrue($report->hasBlockingIssues());
        Http::assertSentCount(2);

        Sanctum::actingAs($this->makeUser(2, 'admin@example.com'));
        $this->postJson("/api/career-reports/{$student->id}/approve")->assertStatus(422);
        $this->getJson("/api/career-reports/{$student->id}/pdf")->assertStatus(422);
    }

    /** @dataProvider invalidReports */
    public function test_validator_catches_report_problems(callable $break, string $expected): void
    {
        $content = $this->validContent();
        $break($content);
        Http::fake([self::OPENAI_URL => $this->openAiResponse($content)]);

        $report = $this->generateFor($this->completedStudent());

        $messages = collect($report->issues)->where('severity', 'error')->pluck('message')->implode(' | ');
        $this->assertStringContainsString($expected, $messages);
    }

    public static function invalidReports(): array
    {
        return [
            'missing department' => [
                function (array &$c) { array_pop($c['match_analysis']); },
                'Match Analysis is missing the selected department "Nursing"',
            ],
            'department not selected' => [
                function (array &$c) { $c['match_analysis'][0]['department'] = 'Lab Management'; },
                'includes "Lab Management", which the student did not select',
            ],
            'two degrees in best fit' => [
                function (array &$c) {
                    $c['best_fit_program']['program'] = 'BSc Nursing or BSc Operating Department Practice';
                },
                'must be one degree',
            ],
            'best fit leads elsewhere' => [
                function (array &$c) {
                    $c['best_fit_program']['program'] = 'BSc Nursing (Adult)';
                },
                'does not lead to the rank 1 department',
            ],
            'rank order contradicts match levels' => [
                function (array &$c) {
                    $c['match_analysis'][0]['match_level'] = 'Low';
                    $c['match_analysis'][1]['match_level'] = 'Very High';
                },
                'below a department with a weaker match level',
            ],
            'match comment too long' => [
                function (array &$c) { $c['match_analysis'][0]['comments'] = str_repeat('Long comment. ', 12); },
                'Match Analysis comment for "Surgical Services" has',
            ],
            'best fit reason too long' => [
                function (array &$c) { $c['overall_best_fit'][1]['reason'] = str_repeat('Long reason. ', 12); },
                'Overall Best Fit reason for "Nursing" has',
            ],
            'rank gap' => [
                function (array &$c) { $c['overall_best_fit'][1]['rank'] = 3; },
                'ranks must run 1, 2, 3',
            ],
            'immigration while switched off' => [
                function (array &$c) { $c['conclusion'] .= ' You may qualify for permanent residency.'; },
                'mentions PR, visas or immigration',
            ],
        ];
    }

    public function test_immigration_text_is_allowed_when_the_option_is_on(): void
    {
        $content = $this->validContent();
        $content['conclusion'] .= ' Visa rules change, so check them with your counsellor.';
        Http::fake([self::OPENAI_URL => $this->openAiResponse($content)]);

        $report = $this->generateFor($this->completedStudent(), ['include_immigration' => true]);

        $this->assertFalse($report->hasBlockingIssues());
        Http::assertSent(fn (Request $request) => !str_contains(
            $request->data()['input'],
            'Do not mention permanent residency',
        ));
    }

    public function test_openai_failures_are_recorded_for_the_counsellor(): void
    {
        Http::fake([self::OPENAI_URL => Http::response(['error' => ['message' => 'Invalid API key']], 401)]);
        $student = $this->completedStudent();
        $report = CareerReport::create($this->inputs() + [
            'user_id' => $student->id,
            'status' => CareerReport::STATUS_GENERATING,
        ]);

        $job = new GenerateCareerReport($report->id);
        try {
            app()->call([$job, 'handle']);
            $this->fail('The job should have thrown.');
        } catch (RuntimeException $e) {
            $job->failed($e);
        }

        $report->refresh();
        $this->assertSame(CareerReport::STATUS_FAILED, $report->status);
        $this->assertStringContainsString('Invalid API key', $report->error_message);
    }

    public function test_refusals_and_cut_off_responses_are_not_treated_as_reports(): void
    {
        $student = $this->completedStudent();
        $report = CareerReport::create($this->inputs() + ['user_id' => $student->id]);
        $job = new GenerateCareerReport($report->id);

        Http::fake([self::OPENAI_URL => Http::sequence()
            ->push(['status' => 'incomplete', 'incomplete_details' => ['reason' => 'max_output_tokens'], 'output' => []])
            ->push(['status' => 'completed', 'output' => [[
                'type' => 'message',
                'content' => [['type' => 'refusal', 'refusal' => 'Cannot help']],
            ]]]),
        ]);

        foreach (['max_output_tokens', 'Cannot help'] as $expected) {
            try {
                app()->call([$job, 'handle']);
                $this->fail('The job should have thrown.');
            } catch (RuntimeException $e) {
                $this->assertStringContainsString($expected, $e->getMessage());
            }
        }

        $this->assertNull($report->refresh()->content);
    }

    public function test_a_finished_report_can_be_downloaded_without_approval(): void
    {
        Http::fake([self::OPENAI_URL => $this->openAiResponse($this->validContent())]);
        $student = $this->completedStudent();
        $this->generateFor($student);

        Sanctum::actingAs($this->makeUser(2, 'admin@example.com'));

        $this->getJson("/api/career-reports/{$student->id}")
            ->assertJsonPath('data.introduction', CareerReport::introductionFor('Test'))
            ->assertJsonPath('data.estimate_seconds', 180);
        $this->assertStringStartsWith('Dear Test, thank you for sharing', CareerReport::introductionFor('Test'));

        $pdf = $this->get("/api/career-reports/{$student->id}/pdf");
        $pdf->assertOk();
        $pdf->assertHeader('Content-Type', 'application/pdf');
        $this->assertStringStartsWith('%PDF', $pdf->getContent());
    }

    public function test_a_chat_request_revises_the_report_and_keeps_the_conversation(): void
    {
        $revised = $this->validContent();
        $revised['conclusion'] = 'A shorter conclusion for the United Kingdom.';
        Http::fake([
            self::OPENAI_URL => Http::sequence()
                ->push($this->openAiBody($this->validContent()))
                ->push($this->openAiBody(['reply' => 'I shortened the conclusion.', 'report' => $revised])),
        ]);
        $student = $this->completedStudent();
        $this->generateFor($student);

        Queue::fake();
        Sanctum::actingAs($this->makeUser(2, 'admin@example.com'));
        $this->postJson("/api/career-reports/{$student->id}/revise", ['message' => 'Make the conclusion shorter'])
            ->assertStatus(202)
            ->assertJsonPath('data.report.status', 'generating')
            ->assertJsonPath('data.report.chat.0.text', 'Make the conclusion shorter');
        $this->postJson("/api/career-reports/{$student->id}/revise", ['message' => 'Again'])->assertStatus(409);

        Queue::assertPushed(GenerateCareerReport::class, fn ($job) => $job->request === 'Make the conclusion shorter');

        $report = CareerReport::where('user_id', $student->id)->first();
        app()->call([new GenerateCareerReport($report->id, 'Make the conclusion shorter'), 'handle']);
        $report->refresh();

        $this->assertSame(CareerReport::STATUS_DRAFT, $report->status);
        $this->assertSame('A shorter conclusion for the United Kingdom.', $report->content['conclusion']);
        $this->assertSame(['user', 'assistant'], array_column($report->chat, 'role'));
        $this->assertSame('I shortened the conclusion.', $report->chat[1]['text']);
        $this->assertNotNull($report->generation_started_at);

        Http::assertSent(fn (Request $request) => str_contains($request->data()['input'], 'Make the conclusion shorter')
            && str_contains($request->data()['input'], 'Current report:')
            && $request->data()['text']['format']['schema']['required'] === ['reply', 'report']);
    }

    public function test_a_failed_chat_request_keeps_the_report_and_says_so(): void
    {
        Http::fake([self::OPENAI_URL => $this->openAiResponse($this->validContent())]);
        $student = $this->completedStudent();
        $report = $this->generateFor($student);
        $report->update(['status' => CareerReport::STATUS_GENERATING, 'chat' => [['role' => 'user', 'text' => 'Change it', 'at' => now()->toIso8601String()]]]);

        (new GenerateCareerReport($report->id, 'Change it'))->failed(new \RuntimeException('OpenAI returned an error: busy'));
        $report->refresh();

        $this->assertSame(CareerReport::STATUS_DRAFT, $report->status);
        $this->assertSame($this->validContent()['conclusion'], $report->content['conclusion']);
        $this->assertTrue($report->chat[1]['error']);
        $this->assertStringContainsString('busy', $report->chat[1]['text']);
    }

    public function test_an_edit_that_breaks_the_report_blocks_approval(): void
    {
        Http::fake([self::OPENAI_URL => $this->openAiResponse($this->validContent())]);
        $student = $this->completedStudent();
        $this->generateFor($student);

        Sanctum::actingAs($this->makeUser(2, 'admin@example.com'));

        $content = $this->validContent();
        $content['best_fit_program']['program'] = 'Something Else';
        $this->putJson("/api/career-reports/{$student->id}", ['content' => $content])->assertOk();

        $this->postJson("/api/career-reports/{$student->id}/approve")->assertStatus(422);
    }

    private function generateFor(User $student, array $inputs = []): CareerReport
    {
        $report = CareerReport::create($inputs + $this->inputs() + [
            'user_id' => $student->id,
            'status' => CareerReport::STATUS_GENERATING,
        ]);

        app()->call([new GenerateCareerReport($report->id), 'handle']);

        return $report->refresh();
    }

    private function inputs(): array
    {
        return [
            'target_country' => 'United Kingdom',
            'education_level' => 'HSC / A Level',
            'study_level' => 'Undergraduate',
        ];
    }

    private function makeUser(int $role, string $email): User
    {
        $id = DB::table('users')->insertGetId([
            'first_name' => 'Test',
            'last_name' => 'Student',
            'email' => $email,
            'role_id' => $role,
            'password' => 'not-used',
        ]);

        return User::find($id);
    }

    private function completedStudent(): User
    {
        $student = $this->makeUser(3, 'student@example.com');
        $this->selectDepartments($student);
        $this->answerAll($student);

        return $student;
    }

    private function selectDepartments(User $student): void
    {
        DB::table('user_challenge_data')->insert([
            'user_id' => $student->id,
            'industry_id' => 1,
            'department_id' => 8,
            'common_department_id' => '[4]',
            'sub_department_ids' => '[10,7]',
        ]);
    }

    private function answerAll(User $student): void
    {
        foreach ($this->questionIds as $index => $questionId) {
            $question = $this->questions()[$index];
            DB::table('user_submitted_answers')->insert([
                'user_id' => $student->id,
                'question_id' => $questionId,
                // Leadership (index 10) and Conflict (14) use the second option, as in the sample.
                'selected_option' => in_array($index, [6, 10, 14], true) ? $question[2] : $question[1],
            ]);
        }
    }

    private function openAiResponse(array $content)
    {
        return Http::response($this->openAiBody($content));
    }

    private function openAiBody(array $content): array
    {
        return [
            'status' => 'completed',
            'output' => [
                ['type' => 'reasoning', 'summary' => []],
                [
                    'type' => 'message',
                    'content' => [['type' => 'output_text', 'text' => json_encode($content)]],
                ],
            ],
        ];
    }

    private function validContent(): array
    {
        $industry = 'Healthcare and Medicine Industry';

        return [
            'match_analysis' => [
                ['industry' => $industry, 'department' => 'Surgical Services', 'match_level' => 'High', 'comments' => 'Technical teamwork.'],
                ['industry' => $industry, 'department' => 'Nursing', 'match_level' => 'Moderate', 'comments' => 'Active, people-focused work.'],
            ],
            'overall_best_fit' => [
                ['rank' => 1, 'industry' => $industry, 'department' => 'Surgical Services', 'reason' => 'Technical teamwork.'],
                ['rank' => 2, 'industry' => $industry, 'department' => 'Nursing', 'reason' => 'Active work.'],
            ],
            'cities' => [
                ['city' => 'London', 'key_advantages' => 'Large hospital network'],
                ['city' => 'Manchester', 'key_advantages' => 'Strong NHS hospitals'],
                ['city' => 'Birmingham', 'key_advantages' => 'Major healthcare institutions'],
            ],
            'key_employers' => [['category' => 'Healthcare', 'employers' => ['NHS']]],
            'job_titles' => [['category' => 'Clinical', 'titles' => ['Operating Department Practitioner']]],
            'final_recommendation_intro' => 'We recommend these undergraduate programs in the United Kingdom.',
            'recommended_programs' => [
                ['program' => 'BSc Operating Department Practice', 'leads_to_department' => 'Surgical Services', 'licensing_note' => 'Needs an approved course.'],
                ['program' => 'BSc Nursing (Adult)', 'leads_to_department' => 'Nursing', 'licensing_note' => ''],
            ],
            'best_fit_program' => [
                'program' => 'BSc Operating Department Practice',
                'why' => [['heading' => 'Technical work', 'detail' => 'It suits specialised, hands-on work.']],
            ],
            'conclusion' => 'You are well placed for study in the United Kingdom.',
        ];
    }

    private function questions(): array
    {
        return [
            ['High Salary Importance', 'Yes, I am highly money motivated.', 'No, I will still be happy with an average income if I am happy.'],
            ['Job Security', 'Yes, I prefer a stable and predictable career path', 'No, I like taking risks and prefer rapid career advancement'],
            ['Work Life Balance', 'Yes, I enjoy working all the time', 'No, I would like to get back home after working hours with a balanced life'],
            ['Travel Willingness', "Yes, I don't mind being away from family time to time", 'No, I prefer always staying close to my family'],
            ['Teamwork Preference', 'Yes, I love being around people and working together', 'No, I prefer to work alone independently'],
            ['Social Interactivity', 'Yes, I love talking to lots of strangers and speaking publicly', "No, I don't enjoy lots of public interaction"],
            ['Work Environment Pressure', 'Yes, I enjoy high pressure work environments', 'No, I prefer a balanced work pressure environment'],
            ['Physical Activity', 'Yes, I like moving around a lot during my work and being in the field', 'No, I like a job that involves less physical activity'],
            ['Outdoor Work', "Yes, I love being outdoors all the time and don't like being confined to an office", 'No, I prefer being confined to an office environment with a predictable day'],
            ['Recognition', 'Yes, I love being recognized publicly', 'No, I prefer being appreciated privately'],
            ['Leadership and Influence', 'Yes, I love leading people and influence them', 'No, I feel very anxious leading people'],
            ['Ambition & Competitiveness', 'Yes, I like to compete and achieve top positions in my job', 'No, I prefer a work environment where everyone is treated equally and collaboration is emphasized over competition'],
            ['Decision-Making', 'Yes, I enjoy making significant decisions that impact my team, company or industry', 'No, I prefer following established guidelines from an expert'],
            ['Technical vs Non- Technical', 'Yes, I enjoy technical role requiring specialized skills in one area.', 'No, I prefer non-technical roles requiring broad skills sets.'],
            ['Conflict Resolution', 'Yes, I enjoy conflict resolution and negotiation which may involve tense discussions', "No, I prefer roles with minimal conflict where I won't be faced with negative opinions of people about me"],
        ];
    }
}
