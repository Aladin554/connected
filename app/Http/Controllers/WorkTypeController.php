<?php

namespace App\Http\Controllers;

use App\Models\WorkType;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Storage;

class WorkTypeController extends Controller
{
    /**
     * Display a listing of work types.
     */
    public function index(): JsonResponse
    {
        $workTypes = WorkType::all()->map(function ($item) {
            $item->modal_image = $item->modal_image 
                ? url("storage/{$item->modal_image}") 
                : null;
            return $item;
        });

        return $this->successResponse($workTypes);
    }

    /**
     * Store a newly created work type.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $this->validateRequest($request);

        if ($request->hasFile('modal_image')) {
            $validated['modal_image'] = $this->storeImage($request->file('modal_image'));
        }

        $workType = WorkType::create($validated);

        // prepend full URL before returning
        if ($workType->modal_image) {
            $workType->modal_image = url("storage/{$workType->modal_image}");
        }

        return $this->successResponse($workType, 'Work type created successfully', 201);
    }

    /**
     * Display the specified work type.
     */
    public function show(int $id): JsonResponse
    {
        $workType = WorkType::find($id);

        if (!$workType) {
            return $this->errorResponse('Work type not found', 404);
        }

        if ($workType->modal_image) {
            $workType->modal_image = url("storage/{$workType->modal_image}");
        }

        return $this->successResponse($workType);
    }

    /**
     * Update the specified work type.
     */
    public function update(Request $request, int $id): JsonResponse
    {
        $workType = WorkType::find($id);

        if (!$workType) {
            return $this->errorResponse('Work type not found', 404);
        }

        $validated = $this->validateRequest($request, true);

        if ($request->hasFile('modal_image')) {
            $this->deleteOldImage($workType->modal_image);
            $validated['modal_image'] = $this->storeImage($request->file('modal_image'));
        }

        $workType->update($validated);

        // prepend full URL after update
        if ($workType->modal_image) {
            $workType->modal_image = url("storage/{$workType->modal_image}");
        }

        return $this->successResponse($workType, 'Work type updated successfully');
    }

    /**
     * Remove the specified work type.
     */
    public function destroy(int $id): JsonResponse
    {
        $workType = WorkType::find($id);

        if (!$workType) {
            return $this->errorResponse('Work type not found', 404);
        }

        $this->deleteOldImage($workType->modal_image);
        $workType->delete();

        return $this->successResponse(null, 'Work type deleted successfully');
    }

    /**
     * Validate request data.
     */
    private function validateRequest(Request $request, bool $isUpdate = false): array
    {
        $rules = [
            'title' => ($isUpdate ? 'sometimes|' : '') . 'required|string',
            'modal_title' => ($isUpdate ? 'sometimes|' : '') . 'required|string|max:255',
            'modal_image' => 'nullable|image|mimes:jpg,jpeg,png,webp|max:2048',
            'modal_description' => 'nullable|string',
        ];

        return $request->validate($rules);
    }

    /**
     * Store uploaded image in public storage.
     */
    private function storeImage($image): string
    {
        return $image->store('categories', 'public');
    }

    /**
     * Delete old image from storage.
     */
    private function deleteOldImage(?string $path): void
    {
        if ($path) {
            // remove only the relative path if it's a full URL
            $relativePath = str_replace(url('storage/') . '/', '', $path);
            if (Storage::disk('public')->exists($relativePath)) {
                Storage::disk('public')->delete($relativePath);
            }
        }
    }

    /**
     * Standard success response.
     */
    private function successResponse($data = null, string $message = 'Success', int $status = 200): JsonResponse
    {
        return response()->json([
            'status' => 'success',
            'message' => $message,
            'data' => $data,
        ], $status);
    }

    /**
     * Standard error response.
     */
    private function errorResponse(string $message, int $status = 400): JsonResponse
    {
        return response()->json([
            'status' => 'error',
            'message' => $message,
        ], $status);
    }
}
