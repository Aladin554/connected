<?php

namespace Tests\Feature;

use App\Http\Middleware\RestrictAdminIp;
use App\Models\AiSetting;
use App\Models\User;
use App\Services\CareerReport\OpenAiClient;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\Client\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class AiSettingsTest extends TestCase
{
    use RefreshDatabase;

    private const KEY = 'sk-panel-secret-key-1234';

    protected function setUp(): void
    {
        parent::setUp();

        $this->withoutMiddleware(RestrictAdminIp::class);
        config([
            'services.openai.key' => 'sk-env-key-9999',
            'services.openai.model' => 'env-model',
            'services.openai.reasoning_effort' => 'medium',
        ]);
    }

    public function test_only_superadmins_can_use_ai_settings(): void
    {
        foreach ([2, 3] as $role) {
            Sanctum::actingAs($this->makeUser($role));
            $this->getJson('/api/ai-settings')->assertForbidden();
            $this->putJson('/api/ai-settings', $this->payload())->assertForbidden();
            $this->postJson('/api/ai-settings/test')->assertForbidden();
        }
    }

    public function test_env_values_are_used_until_the_panel_saves_settings(): void
    {
        Sanctum::actingAs($this->makeUser(1));

        $this->getJson('/api/ai-settings')
            ->assertOk()
            ->assertJsonPath('data.model', 'env-model')
            ->assertJsonPath('data.key.source', 'env')
            ->assertJsonPath('data.key.masked', 'sk-...9999');
    }

    public function test_the_key_is_encrypted_and_never_returned(): void
    {
        Sanctum::actingAs($this->makeUser(1));

        $response = $this->putJson('/api/ai-settings', $this->payload(['api_key' => self::KEY]))->assertOk();

        $response->assertJsonPath('data.key.source', 'panel');
        $response->assertJsonPath('data.key.masked', 'sk-...1234');
        $this->assertStringNotContainsString(self::KEY, $response->getContent());

        $stored = DB::table('ai_settings')->value('api_key');
        $this->assertNotSame(self::KEY, $stored);
        $this->assertStringNotContainsString(self::KEY, $stored);
        $this->assertSame(self::KEY, AiSetting::first()->api_key);
    }

    public function test_a_blank_key_keeps_the_saved_key_and_clearing_returns_to_env(): void
    {
        Sanctum::actingAs($this->makeUser(1));

        $this->putJson('/api/ai-settings', $this->payload(['api_key' => self::KEY]))->assertOk();
        $this->putJson('/api/ai-settings', $this->payload(['api_key' => '']))
            ->assertOk()
            ->assertJsonPath('data.key.source', 'panel');

        $this->putJson('/api/ai-settings', $this->payload(['clear_api_key' => true]))
            ->assertOk()
            ->assertJsonPath('data.key.source', 'env');
    }

    public function test_invalid_settings_are_rejected(): void
    {
        Sanctum::actingAs($this->makeUser(1));

        $this->putJson('/api/ai-settings', $this->payload(['reasoning_effort' => 'extreme']))
            ->assertStatus(422)
            ->assertJsonValidationErrors('reasoning_effort');
        $this->putJson('/api/ai-settings', $this->payload(['timeout' => 900]))
            ->assertStatus(422)
            ->assertJsonValidationErrors('timeout');
        $this->putJson('/api/ai-settings', $this->payload(['model' => 'bad model!']))
            ->assertStatus(422)
            ->assertJsonValidationErrors('model');
        $this->putJson('/api/ai-settings', $this->payload(['model' => 'gpt-6-astra', 'reasoning_effort' => 'none']))
            ->assertStatus(422);
    }

    public function test_saved_settings_are_what_openai_receives(): void
    {
        Sanctum::actingAs($this->makeUser(1));
        $this->putJson('/api/ai-settings', $this->payload(['api_key' => self::KEY]))->assertOk();

        Http::fake(['api.openai.com/*' => Http::response([
            'status' => 'completed',
            'output' => [['type' => 'message', 'content' => [['type' => 'output_text', 'text' => '{"ok":true}']]]],
        ])]);

        app(OpenAiClient::class)->generate('instructions', 'input', ['type' => 'object']);

        Http::assertSent(fn (Request $request) => $request->hasHeader('Authorization', 'Bearer ' . self::KEY)
            && $request->data()['model'] === 'gpt-6.1-sol'
            && $request->data()['reasoning']['effort'] === 'high'
            && $request->data()['max_output_tokens'] === 20000);
    }

    public function test_connection_check_reports_key_and_model_problems(): void
    {
        Sanctum::actingAs($this->makeUser(1));

        Http::fake(['api.openai.com/*' => Http::sequence()
            ->push(['data' => [['id' => 'gpt-6-astra']]])
            ->push(['data' => [['id' => 'gpt-6-astra']]])
            ->push(['error' => ['message' => 'Incorrect API key provided']], 401),
        ]);

        $this->postJson('/api/ai-settings/test', ['model' => 'gpt-6-astra'])
            ->assertOk()->assertJsonPath('data.ok', true);
        $this->postJson('/api/ai-settings/test', ['model' => 'gpt-missing'])
            ->assertOk()->assertJsonPath('data.ok', false);
        $this->postJson('/api/ai-settings/test', ['api_key' => 'sk-wrong', 'model' => 'gpt-6-astra'])
            ->assertOk()
            ->assertJsonPath('data.ok', false)
            ->assertJsonPath('data.message', 'OpenAI rejected the request: Incorrect API key provided');
    }

    private function payload(array $overrides = []): array
    {
        return $overrides + [
            'model' => 'gpt-6.1-sol',
            'reasoning_effort' => 'high',
            'max_output_tokens' => 20000,
            'timeout' => 200,
        ];
    }

    private function makeUser(int $role): User
    {
        $id = DB::table('users')->insertGetId([
            'first_name' => 'Test',
            'last_name' => 'User',
            'email' => "user{$role}-" . uniqid() . '@example.com',
            'role_id' => $role,
            'password' => 'not-used',
        ]);

        return User::find($id);
    }
}
