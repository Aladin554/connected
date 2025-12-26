<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserQuestionnaireAnswer extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'title',
        'details',
        'first_option',
        'second_option',
    ];

    // If each answer belongs to a user
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
