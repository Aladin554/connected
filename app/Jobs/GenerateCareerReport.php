<?php

namespace App\Jobs;

use App\Models\CareerReport;
use App\Services\CareerReport\CareerReportGenerator;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;
use Throwable;

class GenerateCareerReport implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    // A retry would spend another paid AI call, so the counsellor retries by hand.
    public int $tries = 1;

    // Room for the first attempt plus one repair attempt.
    public int $timeout = 600;

    /** @param string|null $request a counsellor's chat request; null builds a new report */
    public function __construct(public int $reportId, public ?string $request = null)
    {
    }

    public function handle(CareerReportGenerator $generator): void
    {
        $report = CareerReport::findOrFail($this->reportId);

        $this->request === null
            ? $generator->generate($report)
            : $generator->revise($report, $this->request);
    }

    public function failed(?Throwable $exception): void
    {
        $message = $exception?->getMessage() ?: 'Report generation failed.';

        Log::error('Career report generation failed', [
            'report_id' => $this->reportId,
            'revision' => $this->request !== null,
            'error' => $message,
        ]);

        $report = CareerReport::find($this->reportId);
        if (!$report) {
            return;
        }

        // A failed chat change keeps the report as it was and says so in the chat.
        if ($this->request !== null && $report->content) {
            $chat = $report->chat ?? [];
            $chat[] = ['role' => 'assistant', 'text' => "Sorry, that change could not be made: {$message}", 'at' => now()->toIso8601String(), 'error' => true];
            $report->update(['status' => CareerReport::STATUS_DRAFT, 'chat' => $chat]);

            return;
        }

        $report->update([
            'status' => CareerReport::STATUS_FAILED,
            'error_message' => $message,
        ]);
    }
}
