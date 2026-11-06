<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('career_reports', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->unique()->constrained()->onDelete('cascade');

            // idle -> generating -> draft -> approved, or failed
            $table->string('status')->default('idle');

            // Counsellor inputs
            $table->string('target_country')->nullable();
            $table->string('education_level')->nullable();
            $table->string('study_level')->nullable();
            $table->date('report_date')->nullable();
            $table->text('academic_background')->nullable();
            $table->string('english_proficiency')->nullable();
            $table->string('budget')->nullable();
            $table->string('preferred_cities')->nullable();
            $table->text('counsellor_notes')->nullable();
            $table->boolean('include_common_departments')->default(false);
            $table->boolean('include_future_outlook')->default(false);
            $table->boolean('include_immigration')->default(false);

            // System data frozen at generation time, the AI's sections, and the checks
            $table->json('snapshot')->nullable();
            $table->json('content')->nullable();
            $table->json('issues')->nullable();
            $table->text('error_message')->nullable();

            $table->string('model')->nullable();
            $table->unsignedBigInteger('generated_by')->nullable();
            $table->timestamp('generated_at')->nullable();
            $table->unsignedBigInteger('approved_by')->nullable();
            $table->timestamp('approved_at')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('career_reports');
    }
};
