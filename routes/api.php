<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\WorkTypeController;

// Public routes
Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);

// Protected routes (require Sanctum auth token)
Route::middleware('auth:sanctum')->group(function () {
    
    // Authenticated user info
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    // User resource routes
    Route::get('/users', [UserController::class, 'index']);
    Route::post('/users', [UserController::class, 'store']);
    Route::get('/users/{id}', [UserController::class, 'show']);
    Route::put('/users/{id}', [UserController::class, 'update']);
    Route::delete('/users/{id}', [UserController::class, 'destroy']);
    Route::get('/roles', [RoleController::class, 'index']);
    Route::get('/profile', [UserController::class, 'showProfile']);
    Route::put('/profile', [UserController::class, 'updateProfile']);

    //category
    Route::apiResource('categories', CategoryController::class);

    Route::apiResource('categories', WorkTypeController::class);
    // Logout
    Route::post('/logout', [AuthController::class, 'logout']);
});
