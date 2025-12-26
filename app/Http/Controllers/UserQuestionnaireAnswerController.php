<?php

namespace App\Http\Controllers;

use App\Models\UserQuestionnaireAnswer;
use App\Models\UserSubmittedAnswer;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;

class UserQuestionnaireAnswerController extends BaseApiController
{
    /**
     * Display all questionnaire answers (questions).
     */
    public function index(): JsonResponse
    {
        $answers = UserQuestionnaireAnswer::all();
        return $this->successResponse($answers);
    }

    /**
     * Store a new questionnaire question.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $this->validateRequest($request);
        $validated['user_id'] = Auth::id();

        $answer = UserQuestionnaireAnswer::create($validated);

        return $this->successResponse($answer, 'Questionnaire question created successfully', 201);
    }

    /**
     * Display a specific questionnaire question.
     */
    public function show(int $id): JsonResponse
    {
        $answer = UserQuestionnaireAnswer::where('user_id', Auth::id())->find($id);

        if (!$answer) {
            return $this->errorResponse('Questionnaire question not found', 404);
        }

        return $this->successResponse($answer);
    }

    /**
     * Update a specific questionnaire question.
     */
    public function update(Request $request, int $id): JsonResponse
    {
        $answer = UserQuestionnaireAnswer::where('user_id', Auth::id())->find($id);

        if (!$answer) {
            return $this->errorResponse('Questionnaire question not found', 404);
        }

        $validated = $this->validateRequest($request, true);
        $answer->update($validated);

        return $this->successResponse($answer, 'Questionnaire question updated successfully');
    }

    /**
     * Delete a specific questionnaire question.
     */
    public function destroy(int $id): JsonResponse
    {
        $answer = UserQuestionnaireAnswer::where('user_id', Auth::id())->find($id);

        if (!$answer) {
            return $this->errorResponse('Questionnaire question not found', 404);
        }

        $answer->delete();

        return $this->successResponse(null, 'Questionnaire question deleted successfully');
    }

    /**
     * Save user-submitted answers (authenticated user).
     */
    public function storeUserAnswers(Request $request): JsonResponse
    {
        $request->validate([
            'answers' => 'required|array',
            'answers.*.question_id' => 'required|exists:user_questionnaire_answers,id',
            'answers.*.selected_option' => 'required|string|max:255',
        ]);

        $userId = Auth::id();

        foreach ($request->answers as $answer) {
            UserSubmittedAnswer::updateOrCreate(
                [
                    'user_id' => $userId,
                    'question_id' => $answer['question_id'],
                ],
                ['selected_option' => $answer['selected_option']]
            );
        }

        return $this->successResponse(['message' => 'Answers saved successfully']);
    }

    /**
     * Validate request data for questions.
     */
    private function validateRequest(Request $request, bool $isUpdate = false): array
    {
        $rules = [
            'title' => ($isUpdate ? 'sometimes|' : '') . 'required|string|max:255',
            'details' => 'nullable|string',
            'first_option' => 'nullable|string|max:255',
            'second_option' => 'nullable|string|max:255',
        ];

        return $request->validate($rules);
    }

    public function getUserAnswers(): JsonResponse
    {
        $answers = UserSubmittedAnswer::where('user_id', Auth::id())
            ->with('question')
            ->get()
            ->map(function ($item) {
                return [
                    'question_id' => $item->question_id,
                    'selected_option' => $item->selected_option,
                ];
            });

        return $this->successResponse($answers);
    }
}
