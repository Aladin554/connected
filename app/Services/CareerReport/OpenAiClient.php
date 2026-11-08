<?php

namespace App\Services\CareerReport;

use Illuminate\Http\Client\ConnectionException;
use Illuminate\Support\Facades\Http;
use RuntimeException;

/** Calls the OpenAI Responses API and returns JSON matching the given schema. */
class OpenAiClient
{
    public function __construct(private readonly AiConfig $config)
    {
    }

    public function generate(string $instructions, string $input, array $schema): array
    {
        $settings = $this->config->values();
        if (!$settings['key']) {
            throw new RuntimeException('No AI API key is set. Add one in AI Settings.');
        }

        try {
            $response = Http::withToken($settings['key'])
                ->acceptJson()
                ->timeout($settings['timeout'])
                ->post(rtrim($settings['base_url'], '/') . '/responses', [
                    'model' => $settings['model'],
                    'instructions' => $instructions,
                    'input' => $input,
                    'reasoning' => ['effort' => $settings['reasoning_effort']],
                    'max_output_tokens' => $settings['max_output_tokens'],
                    // Student data should not be kept on OpenAI's side beyond the request.
                    'store' => false,
                    'text' => [
                        'format' => [
                            'type' => 'json_schema',
                            'name' => 'career_alignment_report',
                            'strict' => true,
                            'schema' => $schema,
                        ],
                    ],
                ]);
        } catch (ConnectionException $e) {
            throw new RuntimeException('Could not reach the AI service: ' . $e->getMessage(), 0, $e);
        }

        if ($response->failed()) {
            $message = $response->json('error.message') ?: 'HTTP ' . $response->status();
            throw new RuntimeException('The AI service returned an error: ' . $message);
        }

        if ($response->json('status') === 'incomplete') {
            $reason = $response->json('incomplete_details.reason') ?: 'unknown reason';
            throw new RuntimeException("The AI service stopped before finishing the report ({$reason}).");
        }

        return $this->parse($response->json('output') ?? []);
    }

    /** Confirms a key and model without spending tokens. */
    public function check(?string $key, string $model): array
    {
        if (!$key) {
            return ['ok' => false, 'message' => 'No API key is set.'];
        }

        try {
            $response = Http::withToken($key)
                ->acceptJson()
                ->timeout(30)
                ->get(rtrim($this->config->values()['base_url'], '/') . '/models');
        } catch (ConnectionException) {
            return ['ok' => false, 'message' => 'Could not reach the AI service. Check the server connection.'];
        }

        if ($response->failed()) {
            $reason = $response->json('error.message') ?: 'HTTP ' . $response->status();

            return ['ok' => false, 'message' => 'The AI service rejected the request: ' . $reason];
        }

        return collect($response->json('data'))->contains('id', $model)
            ? ['ok' => true, 'message' => "Connected. The key works and {$model} is available."]
            : ['ok' => false, 'message' => "The key works, but this account cannot use {$model}."];
    }

    private function parse(array $output): array
    {
        foreach ($output as $item) {
            if (($item['type'] ?? null) !== 'message') {
                continue;
            }

            foreach ($item['content'] ?? [] as $content) {
                if (($content['type'] ?? null) === 'refusal') {
                    throw new RuntimeException('The AI service refused the request: ' . ($content['refusal'] ?? ''));
                }

                if (($content['type'] ?? null) === 'output_text') {
                    $decoded = json_decode($content['text'] ?? '', true);
                    if (!is_array($decoded)) {
                        throw new RuntimeException('The AI service returned text that is not valid JSON.');
                    }

                    return $decoded;
                }
            }
        }

        throw new RuntimeException('The AI service returned no report text.');
    }
}
