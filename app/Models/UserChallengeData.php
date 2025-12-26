<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserChallengeData extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'industry_id',
        'department_id',
        'common_department_id',
        'sub_department_ids',
    ];

    protected $casts = [
        'sub_department_ids' => 'array',
        'common_department_id' => 'array',
    ];

    public function user() {
        return $this->belongsTo(User::class);
    }

    public function industry() {
        return $this->belongsTo(Industry::class);
    }

    public function department() {
        return $this->belongsTo(Department::class);
    }

    public function commonDepartment() {
        return $this->belongsTo(CommonDepartment::class, 'common_department_id');
    }
}
