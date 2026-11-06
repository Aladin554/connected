import { useCallback, useEffect, useState } from "react";
import type { ReactNode } from "react";
import { Link, useParams } from "react-router-dom";
import { ArrowLeft, Download, Plus, Trash2 } from "lucide-react";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import api from "../../../api/axios";

type Status = "idle" | "generating" | "draft" | "approved" | "failed";

interface Issue {
  severity: "error" | "warning";
  message: string;
}

interface MatchRow {
  industry: string;
  department: string;
  match_level: string;
  comments: string;
}

interface BestFitRow {
  rank: number;
  industry: string;
  department: string;
  reason: string;
}

interface City {
  city: string;
  key_advantages: string;
}

interface EmployerGroup {
  category: string;
  employers: string[];
}

interface JobGroup {
  category: string;
  titles: string[];
}

interface Program {
  program: string;
  leads_to_department: string;
  licensing_note: string | null;
}

interface Reason {
  heading: string;
  detail: string;
}

interface ReportContent {
  introduction: string;
  match_analysis: MatchRow[];
  overall_best_fit: BestFitRow[];
  cities: City[];
  key_employers: EmployerGroup[];
  job_titles: JobGroup[];
  final_recommendation_intro: string;
  recommended_programs: Program[];
  best_fit_program: { program: string; why: Reason[] };
  conclusion: string;
  verification_notes: string[];
}

interface Inputs {
  target_country: string;
  education_level: string;
  study_level: string;
  report_date: string;
  academic_background: string;
  english_proficiency: string;
  budget: string;
  preferred_cities: string;
  counsellor_notes: string;
  include_common_departments: boolean;
  include_future_outlook: boolean;
  include_immigration: boolean;
}

interface Report extends Partial<Inputs> {
  status: Status;
  content: ReportContent | null;
  issues: Issue[] | null;
  error_message: string | null;
  model: string | null;
  generated_at: string | null;
  approved_at: string | null;
}

interface PersonalityRow {
  area: string;
  preference: string;
  original_answer: string;
}

interface Payload {
  student: { id: number; name: string; email: string };
  assessment: {
    complete: boolean;
    missing: string[];
    answered: number;
    total_questions: number;
    departments: number;
    submitted_at: string | null;
  };
  system_data: {
    industries: { name: string; departments: string[] }[];
    common_departments: string[];
    personality: PersonalityRow[];
  };
  report: Report | null;
  options: {
    target_countries: string[];
    education_levels: string[];
    study_levels: string[];
    match_levels: string[];
  };
  ai_configured: boolean;
}

const POLL_MS = 4000;

const fieldClass =
  "w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 px-3 py-2 rounded-lg text-sm text-gray-900 dark:text-gray-100 focus:outline-none focus:ring-2 focus:ring-blue-500";
const cardClass =
  "bg-white dark:bg-gray-800 p-6 rounded-2xl shadow-md border border-gray-200 dark:border-gray-700 space-y-4";
const headingClass = "text-xl font-semibold text-gray-900 dark:text-gray-100";
const primaryButton =
  "px-5 py-2.5 rounded-lg bg-blue-600 text-white font-medium hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed transition";
const secondaryButton =
  "px-5 py-2.5 rounded-lg border border-gray-300 dark:border-gray-600 text-gray-800 dark:text-gray-200 font-medium hover:bg-gray-50 dark:hover:bg-gray-700 disabled:opacity-50 disabled:cursor-not-allowed transition";

const emptyInputs: Inputs = {
  target_country: "",
  education_level: "",
  study_level: "Undergraduate",
  report_date: new Date().toISOString().slice(0, 10),
  academic_background: "",
  english_proficiency: "",
  budget: "",
  preferred_cities: "",
  counsellor_notes: "",
  include_common_departments: false,
  include_future_outlook: false,
  include_immigration: false,
};

function inputsFrom(payload: Payload): Inputs {
  const report = payload.report;
  const pick = (value?: string | null) => value ?? "";

  return {
    ...emptyInputs,
    report_date: payload.assessment.submitted_at ?? emptyInputs.report_date,
    ...(report?.target_country
      ? {
          target_country: pick(report.target_country),
          education_level: pick(report.education_level),
          study_level: pick(report.study_level) || "Undergraduate",
          report_date: pick(report.report_date) || emptyInputs.report_date,
          academic_background: pick(report.academic_background),
          english_proficiency: pick(report.english_proficiency),
          budget: pick(report.budget),
          preferred_cities: pick(report.preferred_cities),
          counsellor_notes: pick(report.counsellor_notes),
          include_common_departments: !!report.include_common_departments,
          include_future_outlook: !!report.include_future_outlook,
          include_immigration: !!report.include_immigration,
        }
      : {}),
  };
}

function errorMessage(error: unknown, fallback: string): string {
  const data = (error as { response?: { data?: { message?: string } } }).response?.data;
  return data?.message ?? fallback;
}

function Field({ label, required, children }: { label: string; required?: boolean; children: ReactNode }) {
  return (
    <label className="block space-y-1">
      <span className="text-sm font-medium text-gray-700 dark:text-gray-300">
        {label}
        {required && <span className="text-red-500"> *</span>}
      </span>
      {children}
    </label>
  );
}

function Toggle({
  label,
  hint,
  checked,
  onChange,
}: {
  label: string;
  hint: string;
  checked: boolean;
  onChange: (value: boolean) => void;
}) {
  return (
    <label className="flex items-start gap-3 cursor-pointer">
      <input
        type="checkbox"
        checked={checked}
        onChange={(e) => onChange(e.target.checked)}
        className="mt-1 w-4 h-4 rounded border-gray-300 text-blue-600 focus:ring-blue-500"
      />
      <span>
        <span className="block text-sm font-medium text-gray-800 dark:text-gray-200">{label}</span>
        <span className="block text-xs text-gray-500 dark:text-gray-400">{hint}</span>
      </span>
    </label>
  );
}

function AddRow({ onClick, label }: { onClick: () => void; label: string }) {
  return (
    <button
      type="button"
      onClick={onClick}
      className="inline-flex items-center gap-1 text-sm text-blue-600 hover:underline"
    >
      <Plus size={16} /> {label}
    </button>
  );
}

function RemoveRow({ onClick, label }: { onClick: () => void; label: string }) {
  return (
    <button
      type="button"
      onClick={onClick}
      aria-label={label}
      className="p-2 text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded"
    >
      <Trash2 size={16} />
    </button>
  );
}

export default function CareerReportGenerator() {
  const { id } = useParams<{ id: string }>();
  const [data, setData] = useState<Payload | null>(null);
  const [inputs, setInputs] = useState<Inputs>(emptyInputs);
  const [content, setContent] = useState<ReportContent | null>(null);
  const [dirty, setDirty] = useState(false);
  const [loading, setLoading] = useState(true);
  const [busy, setBusy] = useState(false);

  const status: Status = data?.report?.status ?? "idle";
  const generating = status === "generating";

  const apply = useCallback((payload: Payload) => {
    setData(payload);
    setContent(payload.report?.content ?? null);
    setDirty(false);
  }, []);

  useEffect(() => {
    api
      .get(`/career-reports/${id}`)
      .then((res) => {
        const payload: Payload = res.data.data;
        apply(payload);
        setInputs(inputsFrom(payload));
      })
      .catch((error) => toast.error(errorMessage(error, "Failed to load this student.")))
      .finally(() => setLoading(false));
  }, [id, apply]);

  useEffect(() => {
    if (!generating) return;

    const timer = setTimeout(async () => {
      try {
        const res = await api.get(`/career-reports/${id}`);
        apply(res.data.data);
      } catch {
        setData((current) => (current ? { ...current } : current));
      }
    }, POLL_MS);

    return () => clearTimeout(timer);
  }, [generating, data, id, apply]);

  const setInput = <K extends keyof Inputs>(key: K, value: Inputs[K]) =>
    setInputs((current) => ({ ...current, [key]: value }));

  const edit = (change: (current: ReportContent) => ReportContent) => {
    setContent((current) => (current ? change(current) : current));
    setDirty(true);
  };

  const editRow = <K extends keyof ReportContent>(
    key: K,
    index: number,
    patch: Partial<ReportContent[K] extends (infer R)[] ? R : never>
  ) =>
    edit((current) => ({
      ...current,
      [key]: (current[key] as unknown[]).map((row, i) =>
        i === index ? { ...(row as object), ...patch } : row
      ),
    }));

  const addRow = <K extends keyof ReportContent>(
    key: K,
    row: ReportContent[K] extends (infer R)[] ? R : never
  ) => edit((current) => ({ ...current, [key]: [...(current[key] as unknown[]), row] }));

  const removeRow = <K extends keyof ReportContent>(key: K, index: number) =>
    edit((current) => ({
      ...current,
      [key]: (current[key] as unknown[]).filter((_, i) => i !== index),
    }));

  const editReason = (index: number, patch: Partial<Reason>) =>
    edit((current) => ({
      ...current,
      best_fit_program: {
        ...current.best_fit_program,
        why: current.best_fit_program.why.map((row, i) => (i === index ? { ...row, ...patch } : row)),
      },
    }));

  const generate = async () => {
    if (content && !window.confirm("Generating again replaces the current report and any edits. Continue?")) {
      return;
    }

    setBusy(true);
    try {
      const res = await api.post(`/career-reports/${id}/generate`, inputs);
      apply(res.data.data);
      toast.success("Report generation started.");
    } catch (error) {
      toast.error(errorMessage(error, "Could not start report generation."));
    } finally {
      setBusy(false);
    }
  };

  const cleanedContent = (current: ReportContent): ReportContent => ({
    ...current,
    key_employers: current.key_employers.map((group) => ({
      ...group,
      employers: group.employers.map((name) => name.trim()).filter(Boolean),
    })),
    job_titles: current.job_titles.map((group) => ({
      ...group,
      titles: group.titles.map((title) => title.trim()).filter(Boolean),
    })),
  });

  const saveContent = async () => {
    if (!content) return null;
    const res = await api.put(`/career-reports/${id}`, { content: cleanedContent(content) });
    const payload: Payload = res.data.data;
    apply(payload);
    return payload;
  };

  const save = async () => {
    setBusy(true);
    try {
      await saveContent();
      toast.success("Report saved.");
    } catch (error) {
      toast.error(errorMessage(error, "Could not save the report."));
    } finally {
      setBusy(false);
    }
  };

  const approve = async () => {
    setBusy(true);
    try {
      if (dirty) await saveContent();
      const res = await api.post(`/career-reports/${id}/approve`);
      apply(res.data.data);
      toast.success("Report approved.");
    } catch (error) {
      toast.error(errorMessage(error, "Could not approve the report."));
    } finally {
      setBusy(false);
    }
  };

  const downloadPdf = async () => {
    setBusy(true);
    try {
      const res = await api.get(`/career-reports/${id}/pdf`, { responseType: "blob" });
      const url = URL.createObjectURL(res.data);
      const link = document.createElement("a");
      link.href = url;
      link.download = `Career Alignment Report - ${data?.student.name}.pdf`;
      link.click();
      URL.revokeObjectURL(url);
    } catch {
      toast.error("Could not download the PDF.");
    } finally {
      setBusy(false);
    }
  };

  if (loading) {
    return <div className="p-6 text-center text-gray-700 dark:text-gray-200">Loading...</div>;
  }

  if (!data) {
    return (
      <div className="p-6 text-center text-red-500">
        <ToastContainer />
        Student not found.
      </div>
    );
  }

  const { assessment, system_data: system, options, report } = data;
  const issues = report?.issues ?? [];
  const errors = issues.filter((issue) => issue.severity === "error");
  const warnings = issues.filter((issue) => issue.severity === "warning");
  const canGenerate =
    assessment.complete &&
    data.ai_configured &&
    !generating &&
    !busy &&
    !!inputs.target_country.trim() &&
    !!inputs.education_level &&
    !!inputs.study_level &&
    !!inputs.report_date;
  const selectedDepartments = system.industries.flatMap((industry) => industry.departments);

  return (
    <div className="p-5 lg:p-8 max-w-[1000px] mx-auto space-y-6">
      <ToastContainer />

      <Link
        to={`/dashboard/reports/${id}`}
        className="inline-flex items-center text-blue-600 hover:underline"
      >
        <ArrowLeft size={18} className="mr-2" /> Back to User Report
      </Link>

      <div>
        <h1 className="text-3xl font-bold text-gray-900 dark:text-gray-100">Career Alignment Report</h1>
        <p className="text-gray-600 dark:text-gray-400 mt-1">
          {data.student.name} · {data.student.email}
        </p>
      </div>

      {!assessment.complete && (
        <div className="p-5 rounded-2xl border border-amber-300 bg-amber-50 dark:bg-amber-900/20 dark:border-amber-700">
          <p className="font-semibold text-amber-900 dark:text-amber-200">
            This student has not finished the assessment, so a report cannot be generated yet.
          </p>
          <ul className="list-disc list-inside mt-2 text-sm text-amber-900 dark:text-amber-200">
            {assessment.missing.map((item) => (
              <li key={item}>{item}</li>
            ))}
          </ul>
        </div>
      )}

      {assessment.complete && !data.ai_configured && (
        <div className="p-5 rounded-2xl border border-red-300 bg-red-50 dark:bg-red-900/20 dark:border-red-700 text-red-800 dark:text-red-200">
          ChatGPT is not connected. A superadmin can add the API key in AI Settings.
        </div>
      )}

      {assessment.complete && (
        <section className={cardClass}>
          <h2 className={headingClass}>Report Inputs</h2>

          <div className="grid sm:grid-cols-2 gap-4">
            <Field label="Target Country" required>
              <input
                list="career-report-countries"
                value={inputs.target_country}
                onChange={(e) => setInput("target_country", e.target.value)}
                className={fieldClass}
              />
              <datalist id="career-report-countries">
                {options.target_countries.map((country) => (
                  <option key={country} value={country} />
                ))}
              </datalist>
            </Field>

            <Field label="Current Education Level" required>
              <select
                value={inputs.education_level}
                onChange={(e) => setInput("education_level", e.target.value)}
                className={fieldClass}
              >
                <option value="">Select</option>
                {options.education_levels.map((level) => (
                  <option key={level}>{level}</option>
                ))}
              </select>
            </Field>

            <Field label="Program Level to Recommend" required>
              <select
                value={inputs.study_level}
                onChange={(e) => setInput("study_level", e.target.value)}
                className={fieldClass}
              >
                {options.study_levels.map((level) => (
                  <option key={level}>{level}</option>
                ))}
              </select>
            </Field>

            <Field label="Report Date" required>
              <input
                type="date"
                value={inputs.report_date}
                onChange={(e) => setInput("report_date", e.target.value)}
                className={fieldClass}
              />
            </Field>

            <Field label="English Proficiency">
              <input
                value={inputs.english_proficiency}
                onChange={(e) => setInput("english_proficiency", e.target.value)}
                placeholder="IELTS 6.5"
                className={fieldClass}
              />
            </Field>

            <Field label="Budget per Year">
              <input
                value={inputs.budget}
                onChange={(e) => setInput("budget", e.target.value)}
                placeholder="BDT 22-25 lacs"
                className={fieldClass}
              />
            </Field>
          </div>

          <Field label="Preferred Cities">
            <input
              value={inputs.preferred_cities}
              onChange={(e) => setInput("preferred_cities", e.target.value)}
              className={fieldClass}
            />
          </Field>

          <Field label="Academic Background">
            <textarea
              rows={3}
              value={inputs.academic_background}
              onChange={(e) => setInput("academic_background", e.target.value)}
              placeholder="Subjects studied, results, gaps in study"
              className={fieldClass}
            />
          </Field>

          <Field label="Counsellor Notes">
            <textarea
              rows={3}
              value={inputs.counsellor_notes}
              onChange={(e) => setInput("counsellor_notes", e.target.value)}
              placeholder="Anything the report should take into account"
              className={fieldClass}
            />
          </Field>

          <div className="grid sm:grid-cols-3 gap-4 pt-2">
            <Toggle
              label="Show Common Departments"
              hint={
                system.common_departments.length > 0
                  ? system.common_departments.join(", ")
                  : "This student selected none"
              }
              checked={inputs.include_common_departments}
              onChange={(value) => setInput("include_common_departments", value)}
            />
            <Toggle
              label="Include future job outlook"
              hint="Job demand and AI automation notes"
              checked={inputs.include_future_outlook}
              onChange={(value) => setInput("include_future_outlook", value)}
            />
            <Toggle
              label="Include PR and immigration notes"
              hint="General information only; check before sending"
              checked={inputs.include_immigration}
              onChange={(value) => setInput("include_immigration", value)}
            />
          </div>

          <div className="flex flex-wrap items-center gap-3 pt-2">
            <button type="button" onClick={generate} disabled={!canGenerate} className={primaryButton}>
              {generating ? "Generating..." : content ? "Generate Again" : "Generate Report"}
            </button>
            {generating && (
              <span className="text-sm text-gray-600 dark:text-gray-400">
                This usually takes a few minutes. You can leave this page and come back.
              </span>
            )}
          </div>

          {status === "failed" && (
            <p className="text-sm text-red-600 dark:text-red-400">
              Generation failed: {report?.error_message}
            </p>
          )}
        </section>
      )}

      <section className={cardClass}>
        <h2 className={headingClass}>From the System</h2>
        <p className="text-sm text-gray-500 dark:text-gray-400">
          These sections are printed as they are. The AI cannot change them.
        </p>

        {system.industries.map((industry) => (
          <div key={industry.name}>
            <p className="font-semibold text-gray-900 dark:text-gray-100">{industry.name}</p>
            <ul className="list-disc list-inside ml-3 text-sm text-gray-700 dark:text-gray-300">
              {industry.departments.map((department) => (
                <li key={department}>{department}</li>
              ))}
            </ul>
          </div>
        ))}

        <div className="overflow-x-auto">
          <table className="min-w-full text-sm border border-gray-200 dark:border-gray-700">
            <thead className="bg-gray-100 dark:bg-gray-900 text-gray-800 dark:text-gray-200">
              <tr>
                <th className="px-3 py-2 text-left">Area</th>
                <th className="px-3 py-2 text-left">Printed in report</th>
                <th className="px-3 py-2 text-left">Student's answer</th>
              </tr>
            </thead>
            <tbody>
              {system.personality.map((row) => (
                <tr key={row.area} className="border-t border-gray-200 dark:border-gray-700 text-gray-700 dark:text-gray-300">
                  <td className="px-3 py-2">{row.area}</td>
                  <td className="px-3 py-2">{row.preference}</td>
                  <td className="px-3 py-2">{row.original_answer}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </section>

      {content && !generating && (
        <>
          <section className={cardClass}>
            <div className="flex flex-wrap items-center justify-between gap-2">
              <h2 className={headingClass}>Review</h2>
              <span
                className={`px-3 py-1 rounded-full text-sm font-semibold ${
                  status === "approved" ? "bg-green-100 text-green-800" : "bg-yellow-100 text-yellow-800"
                }`}
              >
                {status === "approved" ? "Approved" : "Draft, needs approval"}
              </span>
            </div>

            {errors.length > 0 && (
              <div>
                <p className="font-semibold text-red-700 dark:text-red-400">Must be fixed before approval</p>
                <ul className="list-disc list-inside text-sm text-red-700 dark:text-red-400">
                  {errors.map((issue) => (
                    <li key={issue.message}>{issue.message}</li>
                  ))}
                </ul>
              </div>
            )}

            {warnings.length > 0 && (
              <div>
                <p className="font-semibold text-amber-700 dark:text-amber-400">Warnings</p>
                <ul className="list-disc list-inside text-sm text-amber-700 dark:text-amber-400">
                  {warnings.map((issue) => (
                    <li key={issue.message}>{issue.message}</li>
                  ))}
                </ul>
              </div>
            )}

            {content.verification_notes.length > 0 && (
              <div>
                <p className="font-semibold text-gray-900 dark:text-gray-100">
                  Check these before approving (not printed)
                </p>
                <ul className="list-disc list-inside text-sm text-gray-700 dark:text-gray-300">
                  {content.verification_notes.map((note) => (
                    <li key={note}>{note}</li>
                  ))}
                </ul>
              </div>
            )}

            {issues.length === 0 && content.verification_notes.length === 0 && (
              <p className="text-sm text-gray-600 dark:text-gray-400">No problems were found.</p>
            )}
          </section>

          <section className={cardClass}>
            <h2 className={headingClass}>1. Introduction</h2>
            <textarea
              rows={5}
              value={content.introduction}
              onChange={(e) => edit((c) => ({ ...c, introduction: e.target.value }))}
              className={fieldClass}
            />
          </section>

          <section className={cardClass}>
            <h2 className={headingClass}>4. Industry &amp; Department Match Analysis</h2>
            {content.match_analysis.map((row, index) => (
              <div key={row.department} className="grid sm:grid-cols-[1fr_170px] gap-3 pb-3 border-b border-gray-200 dark:border-gray-700">
                <div>
                  <p className="font-medium text-gray-900 dark:text-gray-100">{row.department}</p>
                  <p className="text-xs text-gray-500 dark:text-gray-400">{row.industry}</p>
                </div>
                <select
                  aria-label={`Match level for ${row.department}`}
                  value={row.match_level}
                  onChange={(e) => editRow("match_analysis", index, { match_level: e.target.value })}
                  className={fieldClass}
                >
                  {options.match_levels.map((level) => (
                    <option key={level}>{level}</option>
                  ))}
                </select>
                <textarea
                  rows={2}
                  aria-label={`Comments for ${row.department}`}
                  value={row.comments}
                  onChange={(e) => editRow("match_analysis", index, { comments: e.target.value })}
                  className={`${fieldClass} sm:col-span-2`}
                />
              </div>
            ))}
          </section>

          <section className={cardClass}>
            <h2 className={headingClass}>5. Overall Best Fit</h2>
            {content.overall_best_fit.map((row, index) => (
              <div key={row.department} className="grid grid-cols-[70px_1fr] gap-3 pb-3 border-b border-gray-200 dark:border-gray-700">
                <input
                  type="number"
                  min={1}
                  aria-label={`Rank for ${row.department}`}
                  value={row.rank}
                  onChange={(e) => editRow("overall_best_fit", index, { rank: Number(e.target.value) })}
                  className={fieldClass}
                />
                <div className="space-y-2">
                  <p className="font-medium text-gray-900 dark:text-gray-100">{row.department}</p>
                  <textarea
                    rows={2}
                    aria-label={`Reason for ${row.department}`}
                    value={row.reason}
                    onChange={(e) => editRow("overall_best_fit", index, { reason: e.target.value })}
                    className={fieldClass}
                  />
                </div>
              </div>
            ))}
          </section>

          <section className={cardClass}>
            <h2 className={headingClass}>6. Cities with Most Opportunities</h2>
            {content.cities.map((row, index) => (
              <div key={index} className="grid sm:grid-cols-[200px_1fr_auto] gap-2 items-start">
                <input
                  aria-label="City"
                  value={row.city}
                  onChange={(e) => editRow("cities", index, { city: e.target.value })}
                  className={fieldClass}
                />
                <input
                  aria-label="Key advantages"
                  value={row.key_advantages}
                  onChange={(e) => editRow("cities", index, { key_advantages: e.target.value })}
                  className={fieldClass}
                />
                <RemoveRow onClick={() => removeRow("cities", index)} label="Remove city" />
              </div>
            ))}
            <AddRow onClick={() => addRow("cities", { city: "", key_advantages: "" })} label="Add city" />
          </section>

          <section className={cardClass}>
            <h2 className={headingClass}>7. Key Employers</h2>
            {content.key_employers.map((group, index) => (
              <div key={index} className="space-y-2 pb-3 border-b border-gray-200 dark:border-gray-700">
                <div className="flex gap-2">
                  <input
                    aria-label="Employer category"
                    value={group.category}
                    onChange={(e) => editRow("key_employers", index, { category: e.target.value })}
                    className={fieldClass}
                  />
                  <RemoveRow onClick={() => removeRow("key_employers", index)} label="Remove category" />
                </div>
                <textarea
                  rows={Math.max(3, group.employers.length)}
                  aria-label="Employers, one per line"
                  value={group.employers.join("\n")}
                  onChange={(e) => editRow("key_employers", index, { employers: e.target.value.split("\n") })}
                  className={fieldClass}
                />
              </div>
            ))}
            <AddRow onClick={() => addRow("key_employers", { category: "", employers: [] })} label="Add category" />
          </section>

          <section className={cardClass}>
            <h2 className={headingClass}>8. Shortlisted Job Titles</h2>
            {content.job_titles.map((group, index) => (
              <div key={index} className="space-y-2 pb-3 border-b border-gray-200 dark:border-gray-700">
                <div className="flex gap-2">
                  <input
                    aria-label="Job category"
                    value={group.category}
                    onChange={(e) => editRow("job_titles", index, { category: e.target.value })}
                    className={fieldClass}
                  />
                  <RemoveRow onClick={() => removeRow("job_titles", index)} label="Remove category" />
                </div>
                <textarea
                  rows={Math.max(3, group.titles.length)}
                  aria-label="Job titles, one per line"
                  value={group.titles.join("\n")}
                  onChange={(e) => editRow("job_titles", index, { titles: e.target.value.split("\n") })}
                  className={fieldClass}
                />
              </div>
            ))}
            <AddRow onClick={() => addRow("job_titles", { category: "", titles: [] })} label="Add category" />
          </section>

          <section className={cardClass}>
            <h2 className={headingClass}>9. Final Recommendation</h2>
            <textarea
              rows={2}
              aria-label="Final recommendation introduction"
              value={content.final_recommendation_intro}
              onChange={(e) => edit((c) => ({ ...c, final_recommendation_intro: e.target.value }))}
              className={fieldClass}
            />
            {content.recommended_programs.map((row, index) => (
              <div key={index} className="space-y-2 pb-3 border-b border-gray-200 dark:border-gray-700">
                <div className="flex gap-2">
                  <input
                    aria-label="Program name"
                    value={row.program}
                    onChange={(e) => editRow("recommended_programs", index, { program: e.target.value })}
                    className={fieldClass}
                  />
                  <RemoveRow onClick={() => removeRow("recommended_programs", index)} label="Remove program" />
                </div>
                <Field label="Leads to department">
                  <select
                    value={row.leads_to_department}
                    onChange={(e) =>
                      editRow("recommended_programs", index, { leads_to_department: e.target.value })
                    }
                    className={fieldClass}
                  >
                    <option value="">Select</option>
                    {selectedDepartments.map((department) => (
                      <option key={department}>{department}</option>
                    ))}
                  </select>
                </Field>
                <Field label="Licensing note">
                  <input
                    value={row.licensing_note ?? ""}
                    onChange={(e) =>
                      editRow("recommended_programs", index, { licensing_note: e.target.value })
                    }
                    className={fieldClass}
                  />
                </Field>
              </div>
            ))}
            <AddRow
              onClick={() =>
                addRow("recommended_programs", { program: "", leads_to_department: "", licensing_note: "" })
              }
              label="Add program"
            />
          </section>

          <section className={cardClass}>
            <h2 className={headingClass}>10. Best Fit Program and Why</h2>
            <Field label="Best Fit Program">
              <select
                value={content.best_fit_program.program}
                onChange={(e) =>
                  edit((c) => ({
                    ...c,
                    best_fit_program: { ...c.best_fit_program, program: e.target.value },
                  }))
                }
                className={fieldClass}
              >
                <option value="">Select</option>
                {content.recommended_programs.map((row) => (
                  <option key={row.program}>{row.program}</option>
                ))}
              </select>
            </Field>
            {content.best_fit_program.why.map((row, index) => (
              <div key={index} className="space-y-2 pb-3 border-b border-gray-200 dark:border-gray-700">
                <div className="flex gap-2">
                  <input
                    aria-label="Reason heading"
                    value={row.heading}
                    onChange={(e) => editReason(index, { heading: e.target.value })}
                    className={fieldClass}
                  />
                  <RemoveRow
                    onClick={() =>
                      edit((c) => ({
                        ...c,
                        best_fit_program: {
                          ...c.best_fit_program,
                          why: c.best_fit_program.why.filter((_, i) => i !== index),
                        },
                      }))
                    }
                    label="Remove reason"
                  />
                </div>
                <textarea
                  rows={2}
                  aria-label="Reason detail"
                  value={row.detail}
                  onChange={(e) => editReason(index, { detail: e.target.value })}
                  className={fieldClass}
                />
              </div>
            ))}
            <AddRow
              onClick={() =>
                edit((c) => ({
                  ...c,
                  best_fit_program: {
                    ...c.best_fit_program,
                    why: [...c.best_fit_program.why, { heading: "", detail: "" }],
                  },
                }))
              }
              label="Add reason"
            />
          </section>

          <section className={cardClass}>
            <h2 className={headingClass}>11. Conclusion</h2>
            <textarea
              rows={5}
              value={content.conclusion}
              onChange={(e) => edit((c) => ({ ...c, conclusion: e.target.value }))}
              className={fieldClass}
            />
          </section>

          <div className="sticky bottom-0 flex flex-wrap gap-3 p-4 rounded-2xl border border-gray-200 dark:border-gray-700 bg-white/95 dark:bg-gray-800/95 shadow-lg">
            <button type="button" onClick={save} disabled={busy || !dirty} className={secondaryButton}>
              Save Changes
            </button>
            <button
              type="button"
              onClick={approve}
              disabled={busy || (status === "approved" && !dirty) || (!dirty && errors.length > 0)}
              className={primaryButton}
            >
              Approve Report
            </button>
            <button
              type="button"
              onClick={downloadPdf}
              disabled={busy || status !== "approved" || dirty}
              className={`${secondaryButton} inline-flex items-center gap-2`}
            >
              <Download size={18} /> Download PDF
            </button>
          </div>
        </>
      )}
    </div>
  );
}
