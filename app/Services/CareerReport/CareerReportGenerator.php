<?php

namespace App\Services\CareerReport;

use App\Models\CareerReport;

class CareerReportGenerator
{
    public function __construct(
        private readonly AssessmentSnapshot $assessment,
        private readonly CareerReportPrompt $prompt,
        private readonly OpenAiClient $client,
        private readonly CareerReportValidator $validator,
        private readonly AiConfig $config,
    ) {
    }

    public function generate(CareerReport $report): void
    {
        $user = $report->user;
        $snapshot = $this->assessment->build($user);
        $selected = $this->assessment->selectedDepartments($user);

        $instructions = $this->prompt->instructions();
        $input = $this->prompt->input($report, $snapshot, $selected);
        $schema = $this->prompt->schema(
            array_unique(array_column($selected, 'department')),
            array_unique(array_column($selected, 'industry')),
        );

        $attempts = 1 + (int) config('career_report.repair_attempts');
        $content = [];
        $issues = [];

        for ($attempt = 1; $attempt <= $attempts; $attempt++) {
            $content = $this->client->generate($instructions, $input, $schema);
            $issues = $this->validator->validate($content, $report, $snapshot);

            if (!collect($issues)->contains('severity', 'error')) {
                break;
            }

            $input = $this->repairInput($input, $content, $issues);
        }

        $report->update([
            'status' => CareerReport::STATUS_DRAFT,
            'snapshot' => $snapshot,
            'content' => $content,
            'issues' => $issues,
            'error_message' => null,
            'model' => $this->config->values()['model'],
            'generated_at' => now(),
            'approved_by' => null,
            'approved_at' => null,
        ]);
    }

    private function repairInput(string $input, array $content, array $issues): string
    {
        $problems = collect($issues)->where('severity', 'error')->pluck('message')->implode("\n- ");
        $previous = json_encode($content, JSON_UNESCAPED_UNICODE);

        return "{$input}\n\nYour previous report failed these checks:\n- {$problems}\n\n"
            . "Previous report:\n{$previous}\n\nReturn the full corrected report.";
    }
}
