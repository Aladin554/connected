<?php

// app/Models/User.php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Laravel\Sanctum\HasApiTokens; // ✅ Add this

class User extends Authenticatable
{
    use HasApiTokens, HasFactory; // ✅ Include HasApiTokens

    protected $fillable = [
        'firstName',
        'lastName',
        'email',
        'password',
        'role_id',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    // ✅ Relationship
    public function role()
    {
        return $this->belongsTo(Role::class);
    }
}
