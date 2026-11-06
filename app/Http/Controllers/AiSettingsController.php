<?php

namespace App\Http\Controllers;

use App\Models\AiSetting;
use App\Services\CareerReport\AiConfig;
use App\Services\CareerReport\OpenAiClient;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;

/** The API key is a company secret, so this page is for superadmins only. */
class AiSettingsController extends BaseApiController
{
    private const SUPERADMIN = 1;

    public function __construct(private readonly AiConfig $config)
    {
    }

    public function show(): JsonResponse
    {
        if ($denied = $this->denied()) {
            return $denied;
        }

        return $this->successResponse($this->payload());
    }

    public function update(Request $request): JsonResponse
    {
        if ($denied = $this->denied()) {
            return $denied;
        }

        $data = $request->validate([
            'api_key' => 'nullable|string|max:500',
            'clear_api_key' => 'boolean',
            'model' => ['required', 'string', 'max:100', 'regex:/^[A-Za-z0-9._:-]+$/'],
            'reasoning_effort' => ['required', 'string', Rule::in(config('career_report.ai_efforts'))],
            'max_output_tokens' => 'required|integer|min:8000|max:128000',
            'timeout' => 'required|integer|min:30|max:280',
        ]);

        $known = collect(config('career_report.ai_models'))->firstWhere('id', $data['model']);
        if ($data['reasoning_effort'] === 'none' && $known && !$known['supports_none']) {
            return response()->json([
                'status' => 'error',
                'message' => "{$known['label']} does not support the \"none\" reasoning level.",
            ], 422);
        }

        $settings = AiSetting::first() ?? new AiSetting();
        $settings->fill([
            'model' => $data['model'],
            'reasoning_effort' => $data['reasoning_effort'],
            'max_output_tokens' => $data['max_output_tokens'],
            'timeout' => $data['timeout'],
            'updated_by' => Auth::id(),
        ]);

        if ($request->boolean('clear_api_key')) {
            $settings->api_key = null;
        } elseif (!empty($data['api_key'])) {
            $settings->api_key = $data['api_key'];
        }

        $settings->save();

        return $this->successResponse($this->payload(), 'AI settings saved');
    }

    public function test(Request $request, OpenAiClient $client): JsonResponse
    {
        if ($denied = $this->denied()) {
            return $denied;
        }

        $data = $request->validate([
            'api_key' => 'nullable|string|max:500',
            'model' => 'nullable|string|max:100',
        ]);

        $current = $this->config->values();

        return $this->successResponse($client->check(
            ($data['api_key'] ?? null) ?: $current['key'],
            ($data['model'] ?? null) ?: $current['model'],
        ));
    }

    private function denied(): ?JsonResponse
    {
        return (int) Auth::user()->role_id === self::SUPERADMIN
            ? null
            : $this->errorResponse('Access denied', 403);
    }

    private function payload(): array
    {
        $values = $this->config->values();
        $key = (string) $values['key'];

        return [
            'model' => $values['model'],
            'reasoning_effort' => $values['reasoning_effort'],
            'max_output_tokens' => $values['max_output_tokens'],
            'timeout' => $values['timeout'],
            'key' => [
                'set' => $key !== '',
                'source' => $values['key_source'],
                'masked' => $key !== '' ? substr($key, 0, 3) . '...' . substr($key, -4) : null,
            ],
            'updated_at' => AiSetting::first()?->updated_at,
            'options' => [
                'models' => config('career_report.ai_models'),
                'efforts' => config('career_report.ai_efforts'),
            ],
        ];
    }
}
