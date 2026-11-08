<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('career_reports', function (Blueprint $table) {
            // When the current AI run began; finished runs give the time estimate.
            $table->timestamp('generation_started_at')->nullable()->after('generated_by');
            // Counsellor change requests and the AI's replies for the current report.
            $table->json('chat')->nullable()->after('issues');
        });
    }

    public function down(): void
    {
        Schema::table('career_reports', function (Blueprint $table) {
            $table->dropColumn(['generation_started_at', 'chat']);
        });
    }
};
