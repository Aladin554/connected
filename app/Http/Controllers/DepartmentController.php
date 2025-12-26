<?php

namespace App\Http\Controllers;

use App\Http\Controllers\BaseApiController;
use App\Models\Department;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class DepartmentController extends BaseApiController
{
    /**
     * Display a listing of Departments.
     */
    public function index(): JsonResponse
    {
        $departments = Department::with('industry')->get();

        if ($departments->isEmpty()) {
            return $this->errorResponse('No departments found', 404);
        }

        return $this->successResponse($departments);
    }

    /**
     * Store a newly created Department.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $this->validateRequest($request);

        $department = Department::create($validated);

        return $this->successResponse(
            $department->load('industry'),
            'Department created successfully',
            201
        );
    }

    /**
     * Display the specified Department.
     */
    public function show(int $id): JsonResponse
    {
        $department = Department::with('industry')->find($id);

        if (!$department) {
            return $this->errorResponse('Department not found', 404);
        }

        return $this->successResponse($department);
    }

    /**
     * Update the specified Department.
     */
    public function update(Request $request, int $id): JsonResponse
    {
        $department = Department::find($id);

        if (!$department) {
            return $this->errorResponse('Department not found', 404);
        }

        $validated = $this->validateRequest($request, true);
        $department->update($validated);

        return $this->successResponse(
            $department->load('industry'),
            'Department updated successfully'
        );
    }

    /**
     * Remove the specified Department.
     */
    public function destroy(int $id): JsonResponse
    {
        $department = Department::find($id);

        if (!$department) {
            return $this->errorResponse('Department not found', 404);
        }

        $department->delete();

        return $this->successResponse(null, 'Department deleted successfully');
    }

    /**
     * Validate request data.
     */
    private function validateRequest(Request $request, bool $isUpdate = false): array
    {
        return $request->validate([
            'industry_id' => ($isUpdate ? 'sometimes|' : 'required|') .
                'integer|exists:industries,id',

            'name' => ($isUpdate ? 'sometimes|' : 'required|') .
                'string|max:255',

            'details' => 'nullable|string',
        ]);
    }
}
