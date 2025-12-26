<?php

namespace App\Http\Controllers;

use App\Models\CommonDepartment;
use App\Models\Department;
use App\Models\Industry;
use App\Models\SubDepartment;
use App\Models\User;
use App\Models\UserChallengeData;
use App\Models\UserSubmittedAnswer;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class UserChallengeController extends Controller
{
    /**
     * Store or update user's selected industries
     */
    public function storeIndustry(Request $request)
    {

        $userId = Auth::id();
        $selectedIds = $request->selected_ids;

        // Remove previous selections for this user
        UserChallengeData::where('user_id', $userId)->delete();

        $insertData = [];
        foreach ($selectedIds as $industryId) {
            $insertData[] = [
                'user_id' => $userId,
                'industry_id' => $industryId,
                'created_at' => now(),
                'updated_at' => now(),
            ];
        }

        UserChallengeData::insert($insertData);

        return response()->json([
            'message' => 'Industry selections saved successfully',
            'data' => $insertData,
        ]);
    }

    /**
     * Store or update selected department for a user
     */
    public function storeDepartment(Request $request)
    {
        $request->validate([
            'department_id' => 'required|integer|exists:departments,id',
        ]);

        $userChallenge = UserChallengeData::where('user_id', Auth::id())->first();

        if (!$userChallenge) {
            return response()->json([
                'message' => 'No industry selection found for this user',
            ], 404);
        }

        $userChallenge->update([
            'department_id' => $request->department_id,
        ]);

        return response()->json([
            'message' => 'Department saved successfully',
            'data' => $userChallenge,
        ]);
    }

    /**
     * Store or update selected common department for a user
     */
    public function storeCommonDepartment(Request $request)
{

    $userId = Auth::id();

    // Check if user has any challenge data
    $userChallengeExists = UserChallengeData::where('user_id', $userId)->exists();

    if (!$userChallengeExists) {
        return response()->json([
            'message' => 'No challenge data found for this user',
        ], 404);
    }

    // Update all rows for this user
    UserChallengeData::where('user_id', $userId)
        ->update(['common_department_id' => json_encode($request->common_department_id)]);

    return response()->json([
        'message' => 'Common departments saved successfully for all user rows',
    ]);
}




    /**
     * Store or update selected sub-departments (array)
     */
    public function storeDepartmentsAndSubDepartments(Request $request)
{
    $departments = $request->input('departments', []);

    // Validate input
    $validator = Validator::make(
        ['departments' => $departments],
        [
            'departments' => 'required|array|min:1',
            'departments.*.department_id' => 'required|integer|exists:departments,id',
            'departments.*.sub_department_ids' => 'required|array|min:1',
            'departments.*.sub_department_ids.*' => 'integer|exists:sub_departments,id',
        ]
    );

    if ($validator->fails()) {
        return response()->json([
            'message' => 'Validation failed',
            'errors' => $validator->errors()
        ], 422);
    }

    $userId = Auth::id();

    // Delete previous selections for this user
    UserChallengeData::where('user_id', $userId)->delete();

    $insertData = [];

    // Prepare new rows
    foreach ($departments as $dept) {
        $insertData[] = [
            'user_id' => $userId,
            'industry_id' => $dept['industry_id'] ?? null,
            'department_id' => $dept['department_id'],
            'sub_department_ids' => json_encode($dept['sub_department_ids']),
            'created_at' => now(),
            'updated_at' => now(),
        ];
    }

    // Insert all new rows
    UserChallengeData::insert($insertData);

    return response()->json([
        'message' => 'Departments and sub-departments saved successfully',
        'data' => UserChallengeData::where('user_id', $userId)->get(),
    ]);
}


    /**
     * Get all user-selected challenge data
     */
    public function getUserChallengeData(): JsonResponse
    {
        $data = UserChallengeData::where('user_id', Auth::id())->first();

        if (!$data) {
            return response()->json([
                'message' => 'No data found for this user',
                'data' => null,
            ], 404);
        }

        return response()->json([
            'message' => 'User challenge data retrieved successfully',
            'data' => $data,
        ]);
    }

    public function getUserIndustriesWithDepartments()
{
    $user = auth()->user(); // Get logged-in user

    // Fetch all industry_ids for this user from user_challenge_data
    $userChallengeRows = UserChallengeData::where('user_id', $user->id)->get();
    $industryIds = $userChallengeRows->pluck('industry_id')->unique();

    $result = [];

    foreach ($industryIds as $industryId) {
        // Fetch all sub-departments for this industry
        $subDepartments = SubDepartment::where('industry_id', $industryId)->get();

        // Group sub-departments by department_id
        $departments = $subDepartments->groupBy('department_id')->map(function ($subs, $depId) {
            // Fetch department details
            $department = Department::find($depId);

            return [
                'id' => $depId,
                'name' => $department ? $department->name : "Department $depId",
                'details' => $department ? $department->details : null,
                'sub_departments' => $subs->values(), // reset keys
            ];
        })->values();

        // Fetch industry name if needed
        $industry = Industry::find($industryId);

        $result[] = [
            'id' => $industryId,
            'name' => $industry ? $industry->name : "Industry $industryId",
            'departments' => $departments,
        ];
    }

    return response()->json([
        'success' => true,
        'data' => $result,
    ]);
}

public function getUserRelatedDepartments()
    {
        $userId = Auth::id();

        // Get all challenge data for user
        $userChallenges = UserChallengeData::where('user_id', $userId)->get();

        if ($userChallenges->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'No data found for this user',
            ]);
        }

        // Unique industry IDs
        $industryIds = $userChallenges->pluck('industry_id')->unique();

        $industriesData = [];

        foreach ($industryIds as $industryId) {
            $industry = Industry::find($industryId);
            if (!$industry) continue;

            // Collect all sub-departments for this industry across user's selections
            $subDepartments = [];
            foreach ($userChallenges->where('industry_id', $industryId) as $challenge) {
                if ($challenge->sub_department_ids) {
                    $subs = SubDepartment::whereIn('id', $challenge->sub_department_ids)->get();
                    $subDepartments = array_merge($subDepartments, $subs->toArray());
                }
            }

            // Remove duplicate sub-departments by ID
            $subDepartments = collect($subDepartments)
                ->unique('id')
                ->values()
                ->toArray();

            $industriesData[] = [
                'id' => $industry->id,
                'industry' => $industry->name,
                'sub_departments' => $subDepartments,
            ];
        }

        // Get unique common departments selected by the user
        $commonDepartmentIds = $userChallenges->pluck('common_department_id')->flatten()->unique();
        $commonDepartments = CommonDepartment::whereIn('id', $commonDepartmentIds)->get();

        return response()->json([
            'success' => true,
            'data' => [
                'industries' => $industriesData,
                'common_departments' => $commonDepartments,
            ],
        ]);
    }

    /**
     * Get the submitted questionnaire answers for the authenticated user.
     */
    public function getUserSubmittedAnswers()
    {
        $userId = Auth::id();

        // Fetch submitted answers with their related question
        $submittedAnswers = UserSubmittedAnswer::with('question')
            ->where('user_id', $userId)
            ->get();

        if ($submittedAnswers->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'No submitted answers found for this user',
            ]);
        }

        $formattedAnswers = $submittedAnswers->map(function ($item) {
            return [
                'id' => $item->id,
                'selected_option' => $item->selected_option,
                'question' => [
                    'id' => $item->question->id ?? null,
                    'title' => $item->question->title ?? 'N/A',
                    'details' => $item->question->details ?? null,
                ],
            ];
        });

        return response()->json([
            'success' => true,
            'data' => $formattedAnswers,
        ]);
    }

    public function getUserDashboardData()
    {
        $userId = Auth::id();

        // Fetch Challenge Data
        $userChallenges = UserChallengeData::where('user_id', $userId)->get();

        // Fetch Submitted Answers
        $submittedAnswers = UserSubmittedAnswer::with('question')
            ->where('user_id', $userId)
            ->get();

        // Check if both are empty -> redirect signal
        if ($userChallenges->isEmpty() && $submittedAnswers->isEmpty()) {
            return response()->json([
                'success' => false,
                'redirect' => true,
                'message' => 'No career or questionnaire data found. Redirect to introduction.',
            ]);
        }

        // Industries data
        $industryIds = $userChallenges->pluck('industry_id')->unique();
        $industriesData = [];

        foreach ($industryIds as $industryId) {
            $industry = Industry::find($industryId);
            if (!$industry) continue;

            $subDepartments = [];
            foreach ($userChallenges->where('industry_id', $industryId) as $challenge) {
                if ($challenge->sub_department_ids) {
                    $subs = SubDepartment::whereIn('id', $challenge->sub_department_ids)->get();
                    $subDepartments = array_merge($subDepartments, $subs->toArray());
                }
            }

            $subDepartments = collect($subDepartments)->unique('id')->values()->toArray();

            $industriesData[] = [
                'id' => $industry->id,
                'industry' => $industry->name,
                'sub_departments' => $subDepartments,
            ];
        }

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
                    'details' => $item->question->details ?? null,
                ],
            ];
        });

        return response()->json([
            'success' => true,
            'data' => [
                'industries' => $industriesData,
                'common_departments' => $commonDepartments,
                'submitted_answers' => $formattedAnswers,
            ],
        ]);
    }

    public function getSelected(Request $request)
    {
        $user = $request->user();

        // ✅ Fetch all challenge rows for the user
        $challenges = UserChallengeData::with('industry')
            ->where('user_id', $user->id)
            ->get();

        // ✅ Transform response for frontend
        $data = $challenges->map(function ($row) {
            return [
                'id' => $row->industry->id,
                'name' => $row->industry->name,
                'industry' => $row->industry->title,
                'modal_description' => $row->industry->modal_description,
                'final_details' => $row->industry->final_details,
                'modal_image' => $row->industry->modal_image
                    ? url('storage/' . $row->industry->modal_image)
                    : null,
            ];
        });

        return response()->json([
            'status' => 'success',
            'data' => $data
        ]);
    }

}
