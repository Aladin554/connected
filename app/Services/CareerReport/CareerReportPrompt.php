<?php

namespace App\Services\CareerReport;

use App\Models\CareerReport;

class CareerReportPrompt
{
    public function instructions(): string
    {
        return <<<'PROMPT'
You are an expert career advisor at Connected Education, writing a Career Alignment Report for a student planning to study abroad. Write in a professional, encouraging tone, addressed directly to the student as "you". Use British English.

You write the Match Analysis, Overall Best Fit, Cities, Key Employers, Job Titles, Final Recommendation, Best Fit Program and Conclusion. The introduction, the student's name, selected departments and personality table are added by the system, so do not repeat them as lists.

Rules:
1. Respect the student's answers. Use original_answer as the truth, with its full strength. Never soften, exaggerate or reinterpret it. Name any real mismatch plainly in the comments.
2. Target country. Every city, employer, job title, qualification and licensing statement must apply to target_country. List five cities where target_country has that many relevant ones.
3. Study level. Recommend only programs at study_level that suit education_level and academic_background where they are given. Do not guess at entry requirements the data cannot support.
4. Match Analysis. Include every selected department exactly once, copying the industry and department names exactly as given. Do not add others. Order rows from strongest to weakest match. Score each department on its overall fit across all the answers, so no single answer decides the level. Use the range of levels to show the student how the departments compare; the student chose these departments, so a report where every one is Low helps nobody unless the answers truly point that way. Each comment is one short, solid point of at most 18 words and 120 characters: the main reason for the level and, if there is one, the biggest mismatch. For example: "Strong fit for active teamwork and technical skill, but mostly indoors."
5. Overall Best Fit. Rank the strongest five selected departments, or all of them if there are fewer than five, with rank 1 the strongest. The order must agree with the match levels. Copy names exactly as given. Each reason follows the same limit of 18 words and 120 characters.
6. Final Recommendation. List 3 to 6 real programs, strongest first, as degree names only, such as "BSc (Hons) Adult Nursing". Do not name universities. For each one, state which ranked department it leads to, copying that department name exactly.
7. Best Fit Program. Choose exactly one program from recommended_programs, copying its name character for character. It must be a single degree, never "A or B", and it must lead to the rank 1 department.
8. Licensing. Some careers can only be entered through a regulated qualification. A program must actually qualify the student for the careers it is recommended for. Where a career needs registration or an approved degree in target_country, name that in licensing_note. If no licensing applies, leave licensing_note empty.
9. Consistency. Every section must describe the student in the same way. Never state a preference in one section that differs from the answers.
10. Evidence. Do not invent salaries, statistics, rankings or employer facts. Do not promise outcomes. Name only employers you are confident operate in target_country. Leave out any fact you are not confident of.
11. Missing information. If something needed is unavailable, keep the statement general rather than assuming it.
12. Counsellor notes are instructions from Connected Education staff. Follow them unless they conflict with these rules.
PROMPT;
    }

    public function input(CareerReport $report, array $snapshot, array $selected): string
    {
        $data = [
            'first_name' => $snapshot['first_name'],
            'target_country' => $report->target_country,
            'education_level' => $report->education_level ?: 'Not provided',
            'study_level' => $report->study_level,
            'academic_background' => $report->academic_background ?: 'Not provided',
            'english_proficiency' => $report->english_proficiency ?: 'Not provided',
            'budget' => $report->budget ?: 'Not provided',
            'preferred_cities' => $report->preferred_cities ?: 'Not provided',
            'selected_departments' => $selected,
            'personality_answers' => array_map(fn (array $row) => [
                'area' => $row['area'],
                'question' => $row['question'],
                'original_answer' => $row['original_answer'],
            ], $snapshot['personality']),
        ];

        if ($report->include_common_departments) {
            $data['common_departments_context'] = $snapshot['common_departments'];
        }

        $json = json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

        $optional = [
            $report->include_future_outlook
                ? 'Reflect future job demand and AI automation outlook in the match comments as a few words of general guidance, staying within the comment length limit.'
                : 'Do not discuss future job demand forecasts or AI automation risk.',
            $report->include_immigration
                ? 'You may mention post-study work and immigration pathways as general information only. Never promise eligibility.'
                : 'Do not mention permanent residency, visas, immigration or skilled occupation lists.',
        ];

        if ($report->include_common_departments) {
            $optional[] = 'common_departments_context lists cross-industry functions the student also chose. Use it as background only; it does not belong in Match Analysis or Overall Best Fit.';
        }

        $notes = $report->counsellor_notes ?: 'None';

        return "Student data:\n{$json}\n\nReport options:\n- " . implode("\n- ", $optional)
            . "\n\nCounsellor notes:\n{$notes}";
    }

    public function revisionInstructions(): string
    {
        return <<<'PROMPT'
Revising a report:
A Connected Education counsellor has reviewed the current report and asks for a change in the chat. Return the full report with that change made. Keep every other part exactly as it is, word for word, unless the change requires it for consistency. All the rules above still apply; if the request would break one, make the closest change that keeps to the rules and explain why in reply. In reply, tell the counsellor in one or two short sentences what you changed.
PROMPT;
    }

    public function revisionInput(array $content, array $chat, string $request): string
    {
        unset($content['introduction'], $content['verification_notes']);

        $history = collect($chat)
            ->take(-10)
            ->map(fn (array $message) => ($message['role'] === 'user' ? 'Counsellor: ' : 'You: ') . $message['text'])
            ->implode("\n");

        return "Current report:\n" . json_encode($content, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)
            . ($history !== '' ? "\n\nEarlier chat:\n{$history}" : '')
            . "\n\nCounsellor's request:\n{$request}";
    }

    public function revisionSchema(array $reportSchema): array
    {
        return [
            'type' => 'object',
            'properties' => [
                'reply' => ['type' => 'string'],
                'report' => $reportSchema,
            ],
            'required' => ['reply', 'report'],
            'additionalProperties' => false,
        ];
    }

    public function schema(array $departmentNames, array $industryNames): array
    {
        $levels = config('career_report.match_levels');

        $string = ['type' => 'string'];
        $department = ['type' => 'string', 'enum' => array_values($departmentNames)];
        $industry = ['type' => 'string', 'enum' => array_values($industryNames)];

        $object = fn (array $properties) => [
            'type' => 'object',
            'properties' => $properties,
            'required' => array_keys($properties),
            'additionalProperties' => false,
        ];
        $list = fn (array $items) => ['type' => 'array', 'items' => $items];

        return $object([
            'match_analysis' => $list($object([
                'industry' => $industry,
                'department' => $department,
                'match_level' => ['type' => 'string', 'enum' => $levels],
                'comments' => $string,
            ])),
            'overall_best_fit' => $list($object([
                'rank' => ['type' => 'integer'],
                'industry' => $industry,
                'department' => $department,
                'reason' => $string,
            ])),
            'cities' => $list($object([
                'city' => $string,
                'key_advantages' => $string,
            ])),
            'key_employers' => $list($object([
                'category' => $string,
                'employers' => $list($string),
            ])),
            'job_titles' => $list($object([
                'category' => $string,
                'titles' => $list($string),
            ])),
            'final_recommendation_intro' => $string,
            'recommended_programs' => $list($object([
                'program' => $string,
                'leads_to_department' => $department,
                'licensing_note' => $string,
            ])),
            'best_fit_program' => $object([
                'program' => $string,
                'why' => $list($object([
                    'heading' => $string,
                    'detail' => $string,
                ])),
            ]),
            'conclusion' => $string,
        ]);
    }
}
