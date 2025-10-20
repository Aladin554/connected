<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Storage;

class CategoryController extends Controller
{
    /**
     * Display a listing of categories.
     */
    public function index(): JsonResponse
    {
        $categories = Category::all();

        return $this->successResponse($categories);
    }

    /**
     * Store a newly created category in storage.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $this->validateRequest($request);

        if ($request->hasFile('modal_image')) {
            $validated['modal_image'] = $this->storeImage($request->file('modal_image'));
        }

        $category = Category::create($validated);

        return $this->successResponse($category, 'Category created successfully', 201);
    }

    /**
     * Display the specified category.
     */
    public function show(int $id): JsonResponse
    {
        $category = Category::find($id);

        if (!$category) {
            return $this->errorResponse('Category not found', 404);
        }

        return $this->successResponse($category);
    }

    /**
     * Update the specified category in storage.
     */
    public function update(Request $request, int $id): JsonResponse
    {
        $category = Category::find($id);

        if (!$category) {
            return $this->errorResponse('Category not found', 404);
        }

        $validated = $this->validateRequest($request, true);

        if ($request->hasFile('modal_image')) {
            $this->deleteOldImage($category->modal_image);
            $validated['modal_image'] = $this->storeImage($request->file('modal_image'));
        }

        $category->update($validated);

        return $this->successResponse($category, 'Category updated successfully');
    }

    /**
     * Remove the specified category from storage.
     */
    public function destroy(int $id): JsonResponse
    {
        $category = Category::find($id);

        if (!$category) {
            return $this->errorResponse('Category not found', 404);
        }

        $this->deleteOldImage($category->modal_image);
        $category->delete();

        return $this->successResponse(null, 'Category deleted successfully');
    }

    /**
     * Validate request data.
     */
    private function validateRequest(Request $request, bool $isUpdate = false): array
    {
        $rules = [
            'title' => ($isUpdate ? 'sometimes|' : '') . 'required|string|max:255',
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
        if ($path && Storage::disk('public')->exists($path)) {
            Storage::disk('public')->delete($path);
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
