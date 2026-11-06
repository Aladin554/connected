<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class CareerReport extends Model
{
    public const STATUS_IDLE = 'idle';
    public const STATUS_GENERATING = 'generating';
    public const STATUS_DRAFT = 'draft';
    public const STATUS_APPROVED = 'approved';
    public const STATUS_FAILED = 'failed';

    protected $fillable = [
        'user_id',
        'status',
        'target_country',
        'education_level',
        'study_level',
        'report_date',
        'academic_background',
        'english_proficiency',
        'budget',
        'preferred_cities',
        'counsellor_notes',
        'include_common_departments',
        'include_future_outlook',
        'include_immigration',
        'snapshot',
        'content',
        'issues',
        'error_message',
        'model',
        'generated_by',
        'generated_at',
        'approved_by',
        'approved_at',
    ];

    protected $casts = [
        'report_date' => 'date:Y-m-d',
        'include_common_departments' => 'boolean',
        'include_future_outlook' => 'boolean',
        'include_immigration' => 'boolean',
        'snapshot' => 'array',
        'content' => 'array',
        'issues' => 'array',
        'generated_at' => 'datetime',
        'approved_at' => 'datetime',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function hasBlockingIssues(): bool
    {
        return collect($this->issues ?? [])->contains('severity', 'error');
    }
}
