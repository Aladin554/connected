<?php

namespace App\Http\Controllers;

use App\Models\Role;
use Illuminate\Http\Request;

class RoleController extends Controller
{
    // Return all roles
    public function index()
    {
        $roles = Role::all();
        return response()->json($roles);
    }
}
