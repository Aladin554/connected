<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ai_settings', function (Blueprint $table) {
            $table->id();
            // Stored encrypted with APP_KEY. Empty means the .env value is used.
            $table->text('api_key')->nullable();
            $table->string('model')->nullable();
            $table->string('reasoning_effort')->nullable();
            $table->unsignedInteger('max_output_tokens')->nullable();
            $table->unsignedInteger('timeout')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ai_settings');
    }
};
