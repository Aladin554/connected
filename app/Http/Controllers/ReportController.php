<?php

namespace App\Http\Controllers;

use App\Models\CommonDepartment;
use App\Models\Department;
use App\Models\Industry;
use App\Models\SubDepartment;
use App\Models\User;
use App\Models\UserChallengeData;
use App\Models\UserSubmittedAnswer;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;

class ReportController extends Controller
{
    /**
     * List all users with their roles.
     * Admins can only see normal users.
     */
    public function index(): JsonResponse
    {
        $auth = Auth::user();

        // Only admin and superadmin can access
        if (!in_array($auth->role->id, [1, 2])) {
            return response()->json([], 403);
        }

        $usersQuery = User::with('role');

        if ($auth->role->id === 1 && 2) { // Admin
            // Only show normal users
            $usersQuery->where('role_id', 3); // Assuming 3 = user
        }

        $users = $usersQuery->get();

        return response()->json($users);
    }

    /**
     * Show a single user with challenge data and related industries.
     * Admins can only access normal users.
     */
    public function show(int $id): JsonResponse
{
    $auth = Auth::user();
    $user = User::with('role')->find($id);

    if (!$user) {
        return response()->json([
            'success' => false,
            'message' => 'User not found'
        ], 404);
    }

    // Admin cannot view superadmin or other admins
    if ($auth->role->id === 2 && $user->role_id !== 3) {
        return response()->json([
            'success' => false,
            'message' => 'Access denied'
        ], 403);
    }

    // Fetch Challenge Data
    $userChallenges = UserChallengeData::where('user_id', $user->id)->get();

    // Fetch Submitted Answers
    $submittedAnswers = UserSubmittedAnswer::with('question')
        ->where('user_id', $user->id)
        ->get();

    // Redirect if no data
    if ($userChallenges->isEmpty() && $submittedAnswers->isEmpty()) {
        return response()->json([
            'success' => false,
            'redirect' => true,
            'message' => 'No career or questionnaire data found. Redirect to introduction.',
        ]);
    }

    // Build Industries → Departments → Sub-Departments
    $industriesData = [];
    $industryIds = $userChallenges->pluck('industry_id')->unique();

    foreach ($industryIds as $industryId) {
        $industry = Industry::find($industryId);
        if (!$industry) continue;

        $departmentsData = [];

        $challengesForIndustry = $userChallenges->where('industry_id', $industryId);

        foreach ($challengesForIndustry as $challenge) {
            $department = Department::find($challenge->department_id);
            if (!$department) continue;

            $subDepartments = [];
            if ($challenge->sub_department_ids) {
                $subs = SubDepartment::whereIn('id', $challenge->sub_department_ids)->get();
                $subDepartments = $subs->toArray();
            }

            $departmentsData[] = [
                'id' => $department->id,
                'name' => $department->name,
                'sub_departments' => $subDepartments,
            ];
        }

        // Remove duplicate departments
        $departmentsData = collect($departmentsData)->unique('id')->values()->toArray();

        $industriesData[] = [
            'id' => $industry->id,
            'industry' => $industry->name,
            'departments' => $departmentsData,
        ];
    }

    // Common Departments (flattened)
    $commonDepartmentIds = $userChallenges->pluck('common_department_id')->flatten()->unique();
    $commonDepartments = CommonDepartment::whereIn('id', $commonDepartmentIds)->get();

    // Format submitted answers
    $formattedAnswers = $submittedAnswers->map(function ($item) {
        return [
            'id' => $item->id,
            'selected_option' => $item->selected_option,
            'question' => [
                'id' => $item->question->id ?? null,
                'title' => $item->question->title ?? 'N/A',
            ],
        ];
    });

    return response()->json([
        'success' => true,
        'data' => [
            'user' => [
                'id' => $user->id,
                'first_name' => $user->first_name,
                'last_name' => $user->last_name,
                'email' => $user->email,
                'role' => $user->role->name ?? null,
            ],
            'industries' => $industriesData,
            'common_departments' => $commonDepartments,
            'submitted_answers' => $formattedAnswers,
        ],
    ]);
}




    /**
     * Update the authenticated user's report status and notification.
     */
    public function update(Request $request): JsonResponse
    {
        $request->validate([
            'report_notification' => 'required|boolean',
        ]);

        $user = $request->user();
        if ($user->report_status < 3) {
            $user->report_status += 1;
        }
        $user->report_notification = $request->report_notification;
        $user->save();
        return response()->json(['message' => 'Report status updated']);
    }


    /**
     * Reset notification for a specific user.
     */
    public function resetNotification(int $id): JsonResponse
    {
        $user = User::find($id);
        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        $user->report_notification = 0;
        $user->save();

        return response()->json(['message' => 'Notification reset']);
    }

    public function showSelf(): JsonResponse
{
    $auth = Auth::user();
    $user = User::with('role')->find($auth->id);

    if (!$user) {
        return response()->json(['message' => 'User not found'], 404);
    }

    // Admin cannot view superadmin or other admins
    if ($auth->role->id === 2 && $user->role_id !== 3) {
        return response()->json(['message' => 'Access denied'], 403);
    }

    $responseData = $user->toArray();

    // Load all challenge data for the user
    $userChallengeDataAll = UserChallengeData::with('industry.departments')
        ->where('user_id', $user->id)
        ->get();

    if ($userChallengeDataAll->isNotEmpty()) {
        $responseData['challenge_data'] = $userChallengeDataAll->first();

        // Collect selected department names
        $selectedDeptNames = [];
        foreach ($userChallengeDataAll as $challenge) {
            if ($challenge->industry) {
                $deptIds = is_array($challenge->department_ids)
                    ? $challenge->department_ids
                    : json_decode($challenge->department_ids, true);

                $matchedNames = $challenge->industry->departments
                    ->whereIn('id', $deptIds)
                    ->pluck('name')
                    ->toArray();

                $selectedDeptNames = array_merge($selectedDeptNames, $matchedNames);
            }
        }

        $selectedDeptNames = array_unique($selectedDeptNames);

        // Related industries with matching departments
        $selectedIndustryIds = $userChallengeDataAll->pluck('industry_id');

        $relatedIndustries = Industry::whereHas('departments', function ($query) use ($selectedDeptNames) {
            $query->whereIn('name', $selectedDeptNames);
        })
            ->with(['departments' => function ($query) use ($selectedDeptNames) {
                $query->whereIn('name', $selectedDeptNames);
            }])
            ->whereNotIn('id', $selectedIndustryIds)
            ->get();

        $responseData['related_industries'] = $relatedIndustries;
    }

    // Include submitted answers
    $submittedAnswers = UserSubmittedAnswer::with('question')
        ->where('user_id', $user->id)
        ->get();

    if ($submittedAnswers->isNotEmpty()) {
        $responseData['submitted_answers'] = $submittedAnswers;
    }

    return response()->json($responseData);
}

}
