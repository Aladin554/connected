<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Industry extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'name',
        'modal_image',
        'modal_description',
        'final_details',
        'demo_status',
    ];

    // Relationship: an industry has many departments
    public function departments()
    {
        return $this->hasMany(Department::class, 'industry_id');
    }

    public function subDepartments()
    {
        return $this->hasMany(SubDepartment::class);
    }

}
