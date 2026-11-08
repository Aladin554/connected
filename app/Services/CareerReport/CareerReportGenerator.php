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

        [$content] = $this->run(
            $report,
            $snapshot,
            $this->prompt->instructions(),
            $this->prompt->input($report, $snapshot, $selected),
            $this->schemaFor($selected),
        );

        $this->save($report, $snapshot, $content);
    }

    /**
     * Applies a counsellor's chat request to the current report. The system
     * data stays frozen, so only the AI-written sections can change.
     */
    public function revise(CareerReport $report, string $request): void
    {
        $snapshot = $report->snapshot ?? $this->assessment->build($report->user);
        $selected = $this->selectedFrom($snapshot);

        $input = $this->prompt->input($report, $snapshot, $selected) . "\n\n"
            // The controller has already added this request as the last chat message.
            . $this->prompt->revisionInput($report->content ?? [], array_slice($report->chat ?? [], 0, -1), $request);

        [$content, $reply] = $this->run(
            $report,
            $snapshot,
            $this->prompt->instructions() . "\n\n" . $this->prompt->revisionInstructions(),
            $input,
            $this->prompt->revisionSchema($this->schemaFor($selected)),
            revising: true,
        );

        $this->save($report, $snapshot, $content, $reply);
    }

    /** @return array{0: array, 1: string} the report content and the AI's reply */
    private function run(
        CareerReport $report,
        array $snapshot,
        string $instructions,
        string $input,
        array $schema,
        bool $revising = false,
    ): array {
        $attempts = 1 + (int) config('career_report.repair_attempts');
        $content = [];
        $reply = '';

        for ($attempt = 1; $attempt <= $attempts; $attempt++) {
            $result = $this->client->generate($instructions, $input, $schema);
            $content = $revising ? ($result['report'] ?? []) : $result;
            $reply = $revising ? (string) ($result['reply'] ?? '') : '';
            $issues = $this->validator->validate($content, $report, $snapshot);

            if (!collect($issues)->contains('severity', 'error')) {
                break;
            }

            $input = $this->repairInput($input, $content, $issues);
        }

        return [$content, $reply];
    }

    private function save(CareerReport $report, array $snapshot, array $content, ?string $reply = null): void
    {
        $chat = $report->chat ?? [];
        if ($reply !== null) {
            $chat[] = ['role' => 'assistant', 'text' => $reply ?: 'The report has been updated.', 'at' => now()->toIso8601String()];
        }

        $report->update([
            'status' => CareerReport::STATUS_DRAFT,
            'snapshot' => $snapshot,
            'content' => $content,
            'issues' => $this->validator->validate($content, $report, $snapshot),
            'chat' => $chat,
            'error_message' => null,
            'model' => $this->config->values()['model'],
            'generated_at' => now(),
            'approved_by' => null,
            'approved_at' => null,
        ]);
    }

    private function schemaFor(array $selected): array
    {
        return $this->prompt->schema(
            array_unique(array_column($selected, 'department')),
            array_unique(array_column($selected, 'industry')),
        );
    }

    private function selectedFrom(array $snapshot): array
    {
        $selected = [];
        foreach ($snapshot['industries'] ?? [] as $industry) {
            foreach ($industry['departments'] as $department) {
                $selected[] = ['industry' => $industry['name'], 'department' => $department];
            }
        }

        return $selected;
    }

    private function repairInput(string $input, array $content, array $issues): string
    {
        $problems = collect($issues)->where('severity', 'error')->pluck('message')->implode("\n- ");
        $previous = json_encode($content, JSON_UNESCAPED_UNICODE);

        return "{$input}\n\nYour previous report failed these checks:\n- {$problems}\n\n"
            . "Previous report:\n{$previous}\n\nReturn the full corrected report.";
    }
}
