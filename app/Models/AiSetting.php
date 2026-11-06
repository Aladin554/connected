<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AiSetting extends Model
{
    protected $fillable = [
        'api_key',
        'model',
        'reasoning_effort',
        'max_output_tokens',
        'timeout',
        'updated_by',
    ];

    protected $hidden = ['api_key'];

    protected $casts = [
        'api_key' => 'encrypted',
        'max_output_tokens' => 'integer',
        'timeout' => 'integer',
    ];
}
