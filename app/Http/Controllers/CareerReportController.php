<?php

namespace App\Http\Controllers;

use App\Jobs\GenerateCareerReport;
use App\Models\CareerReport;
use App\Models\User;
use App\Services\CareerReport\AiConfig;
use App\Services\CareerReport\AssessmentSnapshot;
use App\Services\CareerReport\CareerReportValidator;
use Dompdf\Dompdf;
use Dompdf\Options;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;
use Symfony\Component\HttpFoundation\Response;

class CareerReportController extends BaseApiController
{
    private const SUPERADMIN = 1;
    private const ADMIN = 2;
    private const STUDENT = 3;

    public function __construct(
        private readonly AssessmentSnapshot $assessment,
        private readonly AiConfig $aiConfig,
    ) {
    }

    public function show(int $userId): JsonResponse
    {
        $student = $this->student($userId);
        if ($student instanceof JsonResponse) {
            return $student;
        }

        return $this->successResponse($this->payload($student));
    }

    public function generate(Request $request, int $userId): JsonResponse
    {
        $student = $this->student($userId);
        if ($student instanceof JsonResponse) {
            return $student;
        }

        $inputs = $request->validate([
            'target_country' => 'required|string|max:100',
            'education_level' => ['required', 'string', Rule::in(config('career_report.education_levels'))],
            'study_level' => ['required', 'string', Rule::in(config('career_report.study_levels'))],
            'report_date' => 'required|date',
            'academic_background' => 'nullable|string|max:2000',
            'english_proficiency' => 'nullable|string|max:255',
            'budget' => 'nullable|string|max:255',
            'preferred_cities' => 'nullable|string|max:255',
            'counsellor_notes' => 'nullable|string|max:2000',
            'include_common_departments' => 'boolean',
            'include_future_outlook' => 'boolean',
            'include_immigration' => 'boolean',
        ]);

        $status = $this->assessment->status($student);
        if (!$status['complete']) {
            return response()->json([
                'status' => 'error',
                'message' => 'This student has not finished the assessment.',
                'missing' => $status['missing'],
            ], 422);
        }

        $report = CareerReport::firstOrCreate(['user_id' => $student->id]);
        // A job lost to a worker restart must not lock the student out for good.
        if ($report->status === CareerReport::STATUS_GENERATING && $report->updated_at->gt(now()->subMinutes(15))) {
            return $this->errorResponse('A report is already being generated for this student.', 409);
        }

        $report->update($inputs + [
            'status' => CareerReport::STATUS_GENERATING,
            'error_message' => null,
            'generated_by' => Auth::id(),
        ]);

        GenerateCareerReport::dispatch($report->id);

        return $this->successResponse($this->payload($student), 'Report generation started', 202);
    }

    public function update(Request $request, int $userId, CareerReportValidator $validator): JsonResponse
    {
        $student = $this->student($userId);
        if ($student instanceof JsonResponse) {
            return $student;
        }

        $report = CareerReport::where('user_id', $student->id)->first();
        if (!$report?->content || $report->status === CareerReport::STATUS_GENERATING) {
            return $this->errorResponse('There is no finished report to edit.', 409);
        }

        $data = $request->validate(['content' => 'required|array']);
        $content = array_intersect_key($data['content'], $report->content) + $report->content;

        // Any edit needs a fresh approval.
        $report->update([
            'content' => $content,
            'issues' => $validator->validate($content, $report, $report->snapshot ?? []),
            'status' => CareerReport::STATUS_DRAFT,
            'approved_by' => null,
            'approved_at' => null,
        ]);

        return $this->successResponse($this->payload($student), 'Report saved');
    }

    public function approve(int $userId): JsonResponse
    {
        $student = $this->student($userId);
        if ($student instanceof JsonResponse) {
            return $student;
        }

        $report = CareerReport::where('user_id', $student->id)->first();
        if (!$report || $report->status !== CareerReport::STATUS_DRAFT) {
            return $this->errorResponse('Only a draft report can be approved.', 409);
        }

        if ($report->hasBlockingIssues()) {
            return $this->errorResponse('Fix the listed errors before approving this report.', 422);
        }

        $report->update([
            'status' => CareerReport::STATUS_APPROVED,
            'approved_by' => Auth::id(),
            'approved_at' => now(),
        ]);

        return $this->successResponse($this->payload($student), 'Report approved');
    }

    public function pdf(int $userId): Response
    {
        $student = $this->student($userId);
        if ($student instanceof JsonResponse) {
            return $student;
        }

        $report = CareerReport::where('user_id', $student->id)->first();
        if ($report?->status !== CareerReport::STATUS_APPROVED) {
            return $this->errorResponse('Approve the report before downloading the PDF.', 409);
        }

        $dompdf = new Dompdf((new Options())->setIsRemoteEnabled(false)->setDefaultFont('Helvetica'));
        $dompdf->loadHtml(view('reports.career-alignment', ['report' => $report])->render());
        $dompdf->setPaper('letter');
        $dompdf->render();

        $name = Str::slug($report->snapshot['student_name'] ?? 'student');

        return response($dompdf->output(), 200, [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => "attachment; filename=\"career-alignment-report-{$name}.pdf\"",
        ]);
    }

    /** Superadmins can open any account; admins only student accounts. */
    private function student(int $userId): User|JsonResponse
    {
        $role = (int) Auth::user()->role_id;
        if (!in_array($role, [self::SUPERADMIN, self::ADMIN], true)) {
            return $this->errorResponse('Access denied', 403);
        }

        $student = User::find($userId);
        if (!$student) {
            return $this->errorResponse('User not found', 404);
        }

        if ($role === self::ADMIN && (int) $student->role_id !== self::STUDENT) {
            return $this->errorResponse('Access denied', 403);
        }

        return $student;
    }

    private function payload(User $student): array
    {
        $assessment = $this->assessment->status($student);
        $report = CareerReport::where('user_id', $student->id)->first();

        return [
            'student' => [
                'id' => $student->id,
                'name' => trim("{$student->first_name} {$student->last_name}"),
                'email' => $student->email,
            ],
            'assessment' => $assessment,
            'system_data' => $report?->snapshot ?? $this->assessment->build($student),
            'report' => $report,
            'options' => [
                'target_countries' => config('career_report.target_countries'),
                'education_levels' => config('career_report.education_levels'),
                'study_levels' => config('career_report.study_levels'),
                'match_levels' => config('career_report.match_levels'),
            ],
            'ai_configured' => $this->aiConfig->hasKey(),
        ];
    }
}
