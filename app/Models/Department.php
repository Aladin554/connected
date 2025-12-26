<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Department extends Model
{
    use HasFactory;

    protected $fillable = [
        'industry_id',
        'name',
        'details',
    ];

    protected $casts = [
        'industry_id' => 'integer',
    ];
    
    public function commonDepartment() 
    {
        return $this->belongsTo(CommonDepartment::class);
    }

    public function subDepartments()
    {
        return $this->hasMany(SubDepartment::class);
    }
    public function industry()
    {
        return $this->belongsTo(Industry::class);
    }
    
}
