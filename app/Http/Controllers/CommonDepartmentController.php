<?php

namespace App\Http\Controllers;

use App\Models\CommonDepartment;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class CommonDepartmentController extends Controller
{
    public function index(): JsonResponse
{
    return response()->json([
        'data' => CommonDepartment::all()
    ]);
}


    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'name'    => 'required|string|max:255',
            'details' => 'nullable|string',
        ]);

        $department = CommonDepartment::create($request->only(['name', 'details']));

        return response()->json([
            'message' => 'CommonDepartment created successfully',
            'data'    => $department
        ], 201);
    }

    public function show($id): JsonResponse
    {
        $department = CommonDepartment::find($id);

        if (!$department) {
            return response()->json(['message' => 'Not found'], 404);
        }

        return response()->json($department);
    }

    public function update(Request $request, $id): JsonResponse
    {
        $department = CommonDepartment::find($id);

        if (!$department) {
            return response()->json(['message' => 'Not found'], 404);
        }

        $request->validate([
            'name'    => 'sometimes|string|max:255',
            'details' => 'nullable|string',
        ]);

        $department->update($request->only(['name', 'details']));

        return response()->json([
            'message' => 'CommonDepartment updated successfully',
            'data'    => $department
        ]);
    }

    public function destroy($id): JsonResponse
    {
        $department = CommonDepartment::find($id);

        if (!$department) {
            return response()->json(['message' => 'Not found'], 404);
        }

        $department->delete();

        return response()->json(['message' => 'Deleted successfully']);
    }

    public function withSubDepartments()
{
    $departments = CommonDepartment::with('subDepartments')->get()->map(function($dept) {
        return [
            'id' => $dept->id,
            'name' => $dept->name,
            'details' => $dept->details,
            'sub_departments' => $dept->subDepartments->map(function($sub) {
                return [
                    'id' => $sub->id,
                    'name' => $sub->name,
                    'details' => $sub->details,
                ];
            }),
        ];
    });

    return response()->json(['data' => $departments]);
}
}
