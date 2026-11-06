<?php

namespace App\Services\CareerReport;

use App\Models\AiSetting;

/**
 * The AI settings in force: values saved in the admin panel, or .env where the
 * panel has none. Read on every use, so a change applies to the next report
 * without restarting the queue worker.
 */
class AiConfig
{
    public function values(): array
    {
        $saved = AiSetting::first();
        $panelKey = $saved?->api_key;
        $envKey = config('services.openai.key');

        return [
            'key' => $panelKey ?: $envKey,
            'key_source' => $panelKey ? 'panel' : ($envKey ? 'env' : null),
            'base_url' => config('services.openai.base_url'),
            'model' => $saved?->model ?: config('services.openai.model'),
            'reasoning_effort' => $saved?->reasoning_effort ?: config('services.openai.reasoning_effort'),
            'max_output_tokens' => $saved?->max_output_tokens ?: (int) config('services.openai.max_output_tokens'),
            'timeout' => $saved?->timeout ?: (int) config('services.openai.timeout'),
        ];
    }

    public function hasKey(): bool
    {
        return (bool) $this->values()['key'];
    }
}
