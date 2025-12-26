<?php

namespace App\Http\Controllers;

use App\Http\Controllers\BaseApiController;
use App\Models\Industry;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Storage;

class IndustryController extends BaseApiController
{
    /**
     * Display a listing of Industries.
     */
    public function index(): JsonResponse
    {
        $industries = Industry::all()->map(function ($item) {
            $item->modal_image = $item->modal_image
                ? url("storage/{$item->modal_image}")
                : null;
            return $item;
        });

        return $this->successResponse($industries);
    }

    /**
     * Store a newly created Industry.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $this->validateRequest($request);

        if ($request->hasFile('modal_image')) {
            $validated['modal_image'] = $this->storeImage($request->file('modal_image'));
        }

        $industry = Industry::create($validated);

        if ($industry->modal_image) {
            $industry->modal_image = url("storage/{$industry->modal_image}");
        }

        return $this->successResponse($industry, 'Industry created successfully', 201);
    }

    /**
     * Display the specified Industry.
     */
    public function show(int $id): JsonResponse
    {
        $industry = Industry::find($id);

        if (!$industry) {
            return $this->errorResponse('Industry not found', 404);
        }

        if ($industry->modal_image) {
            $industry->modal_image = url("storage/{$industry->modal_image}");
        }

        return $this->successResponse($industry);
    }

    /**
     * Update the specified Industry.
     */
    public function update(Request $request, int $id): JsonResponse
    {
        $industry = Industry::find($id);

        if (!$industry) {
            return $this->errorResponse('Industry not found', 404);
        }

        $validated = $this->validateRequest($request, true);

        if ($request->hasFile('modal_image')) {
            $this->deleteOldImage($industry->modal_image);
            $validated['modal_image'] = $this->storeImage($request->file('modal_image'));
        }

        $industry->update($validated);

        if ($industry->modal_image) {
            $industry->modal_image = url("storage/{$industry->modal_image}");
        }

        return $this->successResponse($industry, 'Industry updated successfully');
    }

    /**
     * Update demo_status (Active/Inactive)
     */
    public function updateStatus(Request $request, int $id): JsonResponse
    {
        $industry = Industry::find($id);

        if (!$industry) {
            return $this->errorResponse('Industry not found', 404);
        }

        $request->validate([
            'demo_status' => 'required|boolean',
        ]);

        $industry->demo_status = $request->demo_status;
        $industry->save();

        return $this->successResponse($industry, 'Status updated successfully');
    }

    /**
     * Remove the specified Industry.
     */
    public function destroy(int $id): JsonResponse
    {
        $industry = Industry::find($id);

        if (!$industry) {
            return $this->errorResponse('Industry not found', 404);
        }

        $this->deleteOldImage($industry->modal_image);
        $industry->delete();

        return $this->successResponse(null, 'Industry deleted successfully');
    }

    /**
     * Validate request data.
     */
    private function validateRequest(Request $request, bool $isUpdate = false): array
    {
        $rules = [
            'title' => ($isUpdate ? 'sometimes|' : '') . 'required|string',
            'name' => ($isUpdate ? 'sometimes|' : '') . 'required|string|max:255',
            'modal_image' => 'nullable|image|mimes:jpg,jpeg,png,webp|max:2048',
            'modal_description' => 'nullable|string',
            'final_details' => 'nullable|string', // NEW FIELD
            'demo_status' => ($isUpdate ? 'sometimes|' : '') . 'boolean', // optional during update
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
            $relativePath = str_replace(url('storage/') . '/', '', $path);
            if (Storage::disk('public')->exists($relativePath)) {
                Storage::disk('public')->delete($relativePath);
            }
        }
    }
}
