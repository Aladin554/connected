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

    public function __construct(public int $reportId)
    {
    }

    public function handle(CareerReportGenerator $generator): void
    {
        $generator->generate(CareerReport::findOrFail($this->reportId));
    }

    public function failed(?Throwable $exception): void
    {
        Log::error('Career report generation failed', [
            'report_id' => $this->reportId,
            'error' => $exception?->getMessage(),
        ]);

        CareerReport::whereKey($this->reportId)->update([
            'status' => CareerReport::STATUS_FAILED,
            'error_message' => $exception?->getMessage() ?: 'Report generation failed.',
        ]);
    }
}
