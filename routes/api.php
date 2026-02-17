<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AdminAllowedIpController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CommonDepartmentController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\DepartmentController;
use App\Http\Controllers\IndustryController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\SubCommonDepartmentController;
use App\Http\Controllers\SubDepartmentController;
use App\Http\Controllers\UserChallengeController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UserQuestionnaireAnswerController;
use App\Http\Middleware\CheckReportStatus;

// ==================================================================
// 1. PUBLIC ROUTES – No auth, no IP restriction
// ==================================================================
Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/reset-password', [AuthController::class, 'resetPassword']);

// ==================================================================
// 2. AUTHENTICATED ROUTES – Require login + report status check
// ==================================================================
Route::middleware(['auth:sanctum', CheckReportStatus::class])->group(function () {

    // Current logged-in user
    Route::get('/user', fn(Request $request) => $request->user());

    // ==================================================================
    // NORMAL USER ROUTES – Accessible to ALL logged-in users
    // ==================================================================
    Route::get('/profile', [UserController::class, 'showProfile']);
    Route::put('/profile', [UserController::class, 'updateProfile']);
    Route::get('/dashboard-counts', [DashboardController::class, 'index']);
    Route::post('/user-selections', [UserChallengeController::class, 'store']);
    Route::post('/initial-industry', [UserChallengeController::class, 'storeIndustry']);
    Route::post('/save-departments-and-sub-departments', [UserChallengeController::class, 'storeDepartmentsAndSubDepartments']);
    Route::get('/user-industries-with-departments', [UserChallengeController::class, 'getUserIndustriesWithDepartments']);
    Route::get('/user-saved-departments', [UserChallengeController::class, 'getDepartmentsAndSubDepartments']);
    Route::get('/user-challenge-data', [UserChallengeController::class, 'getUserChallengeData']);
    Route::post('/save-departments', [UserChallengeController::class, 'saveSelectedDepartments']);
    Route::post('/save-common-departments', [UserChallengeController::class, 'storeCommonDepartment']);
    Route::get('/user-dashboard-data', [UserChallengeController::class, 'getUserDashboardData']);
    Route::get('/user-related-departments', [UserChallengeController::class, 'getUserRelatedDepartments']);
    Route::get('/user-challenges', [UserChallengeController::class, 'getSelected']);
    Route::get('/reports/me', [ReportController::class, 'showSelf']);
    Route::apiResource('reports', ReportController::class)->except(['index', 'show']);
    Route::put('reports/reset-notification/{id}', [ReportController::class, 'resetNotification']);
    Route::post('question-answers/submit', [UserQuestionnaireAnswerController::class, 'storeUserAnswers']);
    Route::apiResource('question-answers', UserQuestionnaireAnswerController::class);
    Route::get('/user-submitted-answers', [UserQuestionnaireAnswerController::class, 'getUserAnswers']);

    // Logout
    Route::post('/logout', [AuthController::class, 'logout']);
});

// ==================================================================
// 3. ADMIN-ONLY ROUTES – Require login + IP whitelisting
// These are the dangerous ones: user management, roles, industries, departments, etc.
// ==================================================================
Route::middleware(['auth:sanctum', CheckReportStatus::class, 'admin.ip'])->group(function () {

    // User Management (list, create, update, delete users)
    Route::get('/users', [UserController::class, 'index']);
    Route::post('/users', [UserController::class, 'store']);
    Route::get('/users/{id}', [UserController::class, 'show']);
    Route::put('/users/{id}', [UserController::class, 'update']);
    Route::delete('/users/{id}', [UserController::class, 'destroy']);
    Route::patch('/users/{id}/toggle-data-range', [UserController::class, 'toggleDataRange']);
    Route::patch('/users/{id}/toggle-permission', [UserController::class, 'togglePermission']);
    Route::patch('/users/{user}/toggle-panel-status', [UserController::class, 'togglePanelStatus']);
    Route::post('/video-status', [UserController::class, 'updateVideoStatus']);


    // Roles
    Route::get('/roles', [RoleController::class, 'index']);

    // Industries
    Route::apiResource('industry', IndustryController::class);
    Route::put('/industry/{id}/status', [IndustryController::class, 'updateStatus']);

    // Departments & Sub-departments
    Route::apiResource('common-departments', CommonDepartmentController::class);
    Route::apiResource('departments', DepartmentController::class);
    Route::apiResource('sub-departments', SubDepartmentController::class);
    Route::apiResource('admin-allowed-ips', AdminAllowedIpController::class);
    Route::get('common-departments-with-sub', [CommonDepartmentController::class, 'withSubDepartments']);

    // Reports (admin view all)
    Route::get('/reports', [ReportController::class, 'index']);
    Route::get('/reports/{id}', [ReportController::class, 'show']);
    Route::get('/show-ip', fn (Request $request) => $request->ip());

});
Route::get('/show-ip', function (Request $request) {
    return response()->json([
        'your_ip' => $request->ip(),
        'remote_addr' => $_SERVER['REMOTE_ADDR'] ?? null,
        'x_forwarded_for' => $request->header('X-Forwarded-For'),
        'cf_connecting_ip' => $request->header('CF-Connecting-IP'),
    ]);
});
