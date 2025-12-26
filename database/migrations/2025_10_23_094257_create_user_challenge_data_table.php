<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('user_challenge_data', function (Blueprint $table) {
            $table->id();

            // User and industry (required)
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->foreignId('industry_id')->constrained()->onDelete('cascade');

            // Single selection, nullable initially
            $table->foreignId('department_id')->nullable()->constrained()->onDelete('cascade');
            $table->json('common_department_id')->nullable();

            // Multiple selections stored as JSON
            $table->json('sub_department_ids')->nullable();

            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('user_challenge_data');
    }
};
