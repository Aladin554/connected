<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SubDepartment extends Model
{
    use HasFactory;

    protected $fillable = [
        'industry_id',
        'department_id',
        'name',
        'details',
    ];

    public function industry()
    {
        return $this->belongsTo(Industry::class);
    }

    public function department()
    {
        return $this->belongsTo(Department::class);
    }
}
