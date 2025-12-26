<?php

namespace App\Http\Controllers;

use App\Http\Controllers\BaseApiController;
use App\Models\SubDepartment;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class SubDepartmentController extends BaseApiController
{
    /**
     * Display a listing of Sub Departments.
     */
    public function index(): JsonResponse
    {
        $subDepartments = SubDepartment::with(['industry', 'department'])->get();

        if ($subDepartments->isEmpty()) {
            return $this->errorResponse('No sub-departments found', 404);
        }

        return $this->successResponse($subDepartments);
    }

    /**
     * Store a newly created Sub Department.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $this->validateRequest($request);

        $subDepartment = SubDepartment::create($validated);

        return $this->successResponse($subDepartment, 'Sub-department created successfully', 201);
    }

    /**
     * Display the specified Sub Department.
     */
    public function show(int $id): JsonResponse
    {
        $subDepartment = SubDepartment::with(['industry', 'department'])->find($id);

        if (!$subDepartment) {
            return $this->errorResponse('Sub-department not found', 404);
        }

        return $this->successResponse($subDepartment);
    }

    /**
     * Update the specified Sub Department.
     */
    public function update(Request $request, int $id): JsonResponse
    {
        $subDepartment = SubDepartment::find($id);

        if (!$subDepartment) {
            return $this->errorResponse('Sub-department not found', 404);
        }

        $validated = $this->validateRequest($request, true);
        $subDepartment->update($validated);

        return $this->successResponse($subDepartment, 'Sub-department updated successfully');
    }

    /**
     * Remove the specified Sub Department.
     */
    public function destroy(int $id): JsonResponse
    {
        $subDepartment = SubDepartment::find($id);

        if (!$subDepartment) {
            return $this->errorResponse('Sub-department not found', 404);
        }

        $subDepartment->delete();

        return $this->successResponse(null, 'Sub-department deleted successfully');
    }

    /**
     * Validate request data.
     */
    private function validateRequest(Request $request, bool $isUpdate = false): array
    {
        $rules = [
            'industry_id' => ($isUpdate ? 'sometimes|' : '') . 'required|exists:industries,id',
            'department_id' => ($isUpdate ? 'sometimes|' : '') . 'required|exists:departments,id',
            'name' => ($isUpdate ? 'sometimes|' : '') . 'required|string|max:255',
            'details' => 'nullable|string',
        ];

        return $request->validate($rules);
    }
}
