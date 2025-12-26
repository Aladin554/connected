<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CommonDepartment extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'details'];

    public function subDepartments()
    {
        return $this->hasMany(SubCommonDepartment::class, 'common_department_id');
    }

}
