<?php

namespace App\Services\CareerReport;

use App\Models\CommonDepartment;
use App\Models\Department;
use App\Models\Industry;
use App\Models\SubDepartment;
use App\Models\User;
use App\Models\UserChallengeData;
use App\Models\UserQuestionnaireAnswer;
use App\Models\UserSubmittedAnswer;

/**
 * Reads a student's assessment and builds everything in the report that comes
 * from the system rather than the AI (name, Section 2, Section 3).
 */
class AssessmentSnapshot
{
    /** @return array{complete: bool, missing: string[], answered: int, total_questions: int, departments: int, submitted_at: ?string} */
    public function status(User $user): array
    {
        $totalQuestions = UserQuestionnaireAnswer::count();
        $answers = UserSubmittedAnswer::where('user_id', $user->id)->get();
        // Some older accounts hold repeat rows, so count questions, not rows.
        $answered = $answers->pluck('question_id')->unique()->count();
        $departments = count($this->selectedDepartments($user));

        $missing = [];
        if ($departments === 0) {
            $missing[] = 'The student has not selected any industry departments yet.';
        }
        if ($totalQuestions === 0 || $answered < $totalQuestions) {
            $missing[] = "The student has answered {$answered} of {$totalQuestions} personality questions.";
        }

        return [
            'complete' => $missing === [],
            'missing' => $missing,
            'answered' => $answered,
            'total_questions' => $totalQuestions,
            'departments' => $departments,
            'submitted_at' => $answers->max('created_at')?->toDateString(),
        ];
    }

    public function build(User $user): array
    {
        return [
            'student_name' => trim("{$user->first_name} {$user->last_name}"),
            'first_name' => $this->firstName($user),
            'industries' => $this->industries($user),
            'common_departments' => $this->commonDepartments($user),
            'personality' => $this->personality($user),
        ];
    }

    /** Each entry: industry name + department name, as the student chose them. */
    public function selectedDepartments(User $user): array
    {
        $selected = [];
        foreach ($this->industries($user) as $industry) {
            foreach ($industry['departments'] as $department) {
                $selected[] = ['industry' => $industry['name'], 'department' => $department];
            }
        }

        return $selected;
    }

    private function firstName(User $user): string
    {
        // "MD.Karim" and "MD Karim" should both greet the student by their own name.
        $name = str_replace('.', ' ', (string) $user->first_name);
        $parts = preg_split('/\s+/', trim($name)) ?: [];
        $skip = ['md', 'mohammad', 'mohammed', 'muhammad'];
        foreach ($parts as $part) {
            if (!in_array(strtolower($part), $skip, true)) {
                return $part;
            }
        }

        return trim((string) $user->first_name);
    }

    private function industries(User $user): array
    {
        $rows = UserChallengeData::where('user_id', $user->id)->orderBy('id')->get();
        $industryNames = Industry::whereIn('id', $rows->pluck('industry_id'))->pluck('name', 'id');
        $subNames = SubDepartment::whereIn('id', $rows->pluck('sub_department_ids')->flatten()->filter())
            ->pluck('name', 'id');

        $industries = [];
        foreach ($rows as $row) {
            $name = $industryNames[$row->industry_id] ?? null;
            if ($name === null) {
                continue;
            }

            foreach ((array) $row->sub_department_ids as $subId) {
                if (!isset($subNames[$subId])) {
                    continue;
                }
                $industries[$row->industry_id]['name'] = $name;
                $industries[$row->industry_id]['departments'][] = $subNames[$subId];
            }
        }

        return array_map(function (array $industry) {
            $industry['departments'] = array_values(array_unique($industry['departments']));

            return $industry;
        }, array_values($industries));
    }

    private function commonDepartments(User $user): array
    {
        $ids = UserChallengeData::where('user_id', $user->id)
            ->pluck('common_department_id')
            ->flatten()
            ->filter()
            ->unique();

        return CommonDepartment::whereIn('id', $ids)->orderBy('id')->pluck('name')->all();
    }

    private function personality(User $user): array
    {
        // Ordered by id, so the latest answer wins where a question has repeat rows.
        $answers = UserSubmittedAnswer::with('question')
            ->where('user_id', $user->id)
            ->orderBy('id')
            ->get()
            ->keyBy('question_id')
            ->sortKeys();

        $labels = config('career_report.personality_labels');
        $rows = [];

        foreach ($answers as $answer) {
            $question = $answer->question;
            if (!$question) {
                continue;
            }

            $key = preg_replace('/[^a-z0-9]/', '', strtolower($question->title));
            $config = $labels[$key] ?? null;
            $choice = match ($answer->selected_option) {
                $question->first_option => 'first',
                $question->second_option => 'second',
                default => null,
            };

            $rows[] = [
                'area' => $config['area'] ?? $question->title,
                'preference' => ($config && $choice) ? $config[$choice] : $answer->selected_option,
                'question' => strip_tags((string) $question->details),
                'original_answer' => $answer->selected_option,
            ];
        }

        return $rows;
    }
}
