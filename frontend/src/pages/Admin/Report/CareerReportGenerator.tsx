import { useCallback, useEffect, useRef, useState } from "react";
import type { CSSProperties, ReactNode } from "react";
import { Link, useParams } from "react-router-dom";
import { ArrowLeft, Circle, CircleCheck, Download, LoaderCircle, Send } from "lucide-react";
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

interface ReportContent {
  match_analysis: MatchRow[];
  overall_best_fit: BestFitRow[];
  cities: { city: string; key_advantages: string }[];
  key_employers: { category: string; employers: string[] }[];
  job_titles: { category: string; titles: string[] }[];
  final_recommendation_intro: string;
  recommended_programs: { program: string; leads_to_department: string; licensing_note: string | null }[];
  best_fit_program: { program: string; why: { heading: string; detail: string }[] };
  conclusion: string;
}

interface ChatMessage {
  role: "user" | "assistant";
  text: string;
  at: string;
  error?: boolean;
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
  chat: ChatMessage[] | null;
  error_message: string | null;
  model: string | null;
  generation_started_at: string | null;
  generated_at: string | null;
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
  introduction: string;
  report: Report | null;
  options: {
    target_countries: string[];
    education_levels: string[];
    study_levels: string[];
    match_levels: string[];
  };
  ai_configured: boolean;
  estimate_seconds: number;
}

const POLL_MS = 4000;

const fieldClass =
  "w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 px-3 py-2 rounded-lg text-sm text-gray-900 dark:text-gray-100 focus:outline-none focus:ring-2 focus:ring-blue-500";
const cardClass =
  "bg-white dark:bg-gray-800 p-6 rounded-2xl shadow-md border border-gray-200 dark:border-gray-700 space-y-4";
const headingClass = "text-xl font-semibold text-gray-900 dark:text-gray-100";
const sectionHeading = "text-base font-semibold text-gray-900 dark:text-gray-100";
const bodyText = "text-sm text-gray-700 dark:text-gray-300";
const tableClass = "min-w-full text-sm border border-gray-200 dark:border-gray-700";
const theadClass = "bg-gray-100 dark:bg-gray-900 text-gray-800 dark:text-gray-200";
const cellClass = "px-3 py-2 text-left align-top";
const rowClass = "border-t border-gray-200 dark:border-gray-700 text-gray-700 dark:text-gray-300";
const primaryButton =
  "px-5 py-2.5 rounded-lg bg-blue-600 text-white font-medium hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed transition";

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
  include_common_departments: true,
  include_future_outlook: true,
  include_immigration: true,
};

function inputsFrom(payload: Payload): Inputs {
  const report = payload.report;
  const pick = (value?: string | null) => value ?? "";
  const hasCommon = payload.system_data.common_departments.length > 0;

  // Options start switched on for a new report; a saved report keeps its own choices.
  return {
    ...emptyInputs,
    include_common_departments: hasCommon,
    ...(report?.target_country
      ? {
          target_country: pick(report.target_country),
          education_level: pick(report.education_level),
          study_level: pick(report.study_level) || "Undergraduate",
          academic_background: pick(report.academic_background),
          english_proficiency: pick(report.english_proficiency),
          budget: pick(report.budget),
          preferred_cities: pick(report.preferred_cities),
          counsellor_notes: pick(report.counsellor_notes),
          include_common_departments: hasCommon && !!report.include_common_departments,
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

function formatDuration(seconds: number): string {
  const safe = Math.max(0, Math.round(seconds));
  return `${Math.floor(safe / 60)}:${String(safe % 60).padStart(2, "0")}`;
}

function aboutMinutes(seconds: number): string {
  const minutes = Math.max(1, Math.round(seconds / 60));
  return `about ${minutes} minute${minutes === 1 ? "" : "s"}`;
}

function Field({
  label,
  required,
  optional,
  children,
}: {
  label: string;
  required?: boolean;
  optional?: boolean;
  children: ReactNode;
}) {
  return (
    <label className="block space-y-1">
      <span className="text-sm font-medium text-gray-700 dark:text-gray-300">
        {label}
        {required && <span className="text-red-500"> *</span>}
        {optional && <span className="font-normal text-gray-400 dark:text-gray-500"> (optional)</span>}
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

/** Paints a logo glyph in the element's background colour. */
function logoMask(src: string, width: number, height: number): CSSProperties {
  const image = `url(${src})`;
  return {
    width,
    height,
    WebkitMaskImage: image,
    maskImage: image,
    WebkitMaskSize: "100% 100%",
    maskSize: "100% 100%",
    WebkitMaskRepeat: "no-repeat",
    maskRepeat: "no-repeat",
  };
}

const BUILD_STEPS = [
  "Reading the assessment answers",
  "Scoring each department",
  "Finding cities and employers",
  "Choosing programs",
  "Checking the report",
];

const REVISE_STEPS = ["Reading your request", "Updating the report", "Checking the report"];

/**
 * Progress against the usual run time. The AI gives no real progress, so the
 * bar follows the clock: steady to 90% by the usual time, then a slow crawl
 * that never reaches 100% until the report actually arrives.
 */
function Progress({
  title,
  subtitle,
  steps,
  startedAt,
  estimate,
  now,
}: {
  title: string;
  subtitle: string;
  steps: string[];
  startedAt: string | null;
  estimate: number;
  now: number;
}) {
  const started = startedAt ? Date.parse(startedAt) : now;
  const elapsed = Math.max(0, (now - started) / 1000);
  const ratio = elapsed / Math.max(estimate, 1);
  const percent = ratio < 1 ? 90 * ratio : 90 + 9 * (1 - Math.exp(-(ratio - 1) * 2));
  const active = Math.min(steps.length - 1, Math.floor((percent / 90) * steps.length));
  const remaining = estimate - elapsed;
  const timeLeft =
    remaining <= 0
      ? "Almost done, finishing the last checks"
      : remaining < 60
        ? "Less than a minute left"
        : `About ${Math.ceil(remaining / 60)} min left`;

  return (
    <div className="w-full overflow-hidden rounded-2xl border border-blue-100 dark:border-blue-900/60 bg-gradient-to-br from-blue-50 via-white to-indigo-50 dark:from-blue-950/40 dark:via-gray-800 dark:to-indigo-950/40 p-5 space-y-5">
      <style>{`
        @keyframes cr-shimmer { from { transform: translateX(-100%); } to { transform: translateX(250%); } }
        @keyframes cr-glow { 0%, 100% { opacity: .45; transform: scale(.9); } 50% { opacity: .95; transform: scale(1.1); } }
        @keyframes cr-dot { 0%, 80%, 100% { opacity: .25; transform: translateY(0); } 40% { opacity: 1; transform: translateY(-3px); } }
        @keyframes cr-breathe { 0%, 100% { transform: scale(1); } 50% { transform: scale(1.06); } }
      `}</style>

      <div className="flex items-center justify-between gap-4">
        <div className="flex items-center gap-4">
          {/* Connected "C." brand tile with a glowing comet ring. */}
          <div className="relative h-16 w-16 shrink-0">
            <span
              className="absolute -inset-3 rounded-full bg-gradient-to-tr from-blue-500/50 to-violet-500/50 blur-xl"
              style={{ animation: "cr-glow 2.4s ease-in-out infinite" }}
            />
            <span
              className="absolute inset-0 rounded-full"
              style={{
                background:
                  "conic-gradient(from 0deg, rgba(59,130,246,0) 0deg, rgba(59,130,246,.9) 150deg, #8b5cf6 300deg, rgba(139,92,246,0) 360deg)",
                WebkitMask: "radial-gradient(farthest-side, transparent calc(100% - 3px), #000 calc(100% - 3px))",
                mask: "radial-gradient(farthest-side, transparent calc(100% - 3px), #000 calc(100% - 3px))",
                animation: "spin 1.3s linear infinite",
              }}
            />
            <div className="absolute inset-[6px] flex items-center justify-center rounded-full bg-gradient-to-br from-gray-800 to-black shadow-lg ring-1 ring-white/10">
              {/* The C and dot are cut from the Connected logo, coloured through a mask. */}
              <span className="flex items-end gap-[2px]" style={{ animation: "cr-breathe 2.4s ease-in-out infinite" }}>
                <span className="block bg-white" style={logoMask("/images/logo/connected-c.png", 22, 28)} />
                <span className="block bg-blue-400" style={logoMask("/images/logo/connected-dot.png", 6.5, 28)} />
              </span>
            </div>
          </div>
          <div>
            <p className="flex items-end gap-1.5 text-base font-semibold text-gray-900 dark:text-gray-100">
              {title}
              <span className="mb-1.5 inline-flex gap-1" aria-hidden="true">
                {[0, 1, 2].map((dot) => (
                  <span
                    key={dot}
                    className="h-1.5 w-1.5 rounded-full bg-gradient-to-r from-blue-500 to-violet-500"
                    style={{ animation: `cr-dot 1.2s ${dot * 0.18}s ease-in-out infinite` }}
                  />
                ))}
              </span>
            </p>
            <p className="text-xs text-gray-500 dark:text-gray-400">{subtitle}</p>
          </div>
        </div>
        <p className="text-2xl font-bold tabular-nums text-blue-600 dark:text-blue-400">{Math.floor(percent)}%</p>
      </div>

      <div className="relative h-3 w-full overflow-hidden rounded-full bg-blue-100 dark:bg-gray-700">
        <div
          className="relative h-full overflow-hidden rounded-full bg-gradient-to-r from-blue-500 via-indigo-500 to-violet-500 transition-[width] duration-1000 ease-out"
          style={{ width: `${percent}%` }}
        >
          <span
            className="absolute inset-y-0 w-1/3 bg-gradient-to-r from-transparent via-white/50 to-transparent"
            style={{ animation: "cr-shimmer 1.6s ease-in-out infinite" }}
          />
        </div>
      </div>

      <ol className="grid gap-2 sm:grid-cols-2">
        {steps.map((step, index) => {
          const done = index < active;
          const current = index === active;
          return (
            <li key={step} className="flex items-center gap-2 text-sm">
              {done ? (
                <CircleCheck size={18} className="shrink-0 text-green-600 dark:text-green-400" />
              ) : current ? (
                <LoaderCircle size={18} className="shrink-0 animate-spin text-blue-600 dark:text-blue-400" />
              ) : (
                <Circle size={18} className="shrink-0 text-gray-300 dark:text-gray-600" />
              )}
              <span
                className={
                  done
                    ? "text-gray-500 dark:text-gray-400"
                    : current
                      ? "font-medium text-gray-900 dark:text-gray-100"
                      : "text-gray-400 dark:text-gray-500"
                }
              >
                {step}
              </span>
            </li>
          );
        })}
      </ol>

      <div className="flex flex-wrap items-center justify-between gap-2 border-t border-blue-100 dark:border-gray-700 pt-3 text-xs text-gray-500 dark:text-gray-400">
        <span>
          <span className="font-medium tabular-nums text-gray-700 dark:text-gray-300">{formatDuration(elapsed)}</span>{" "}
          elapsed · {timeLeft}
        </span>
        <span>You can leave this page and come back.</span>
      </div>
    </div>
  );
}

export default function CareerReportGenerator() {
  const { id } = useParams<{ id: string }>();
  const [data, setData] = useState<Payload | null>(null);
  const [inputs, setInputs] = useState<Inputs>(emptyInputs);
  const [loading, setLoading] = useState(true);
  const [busy, setBusy] = useState(false);
  const [message, setMessage] = useState("");
  const [now, setNow] = useState(() => Date.now());
  const chatEnd = useRef<HTMLDivElement>(null);

  const report = data?.report ?? null;
  const status: Status = report?.status ?? "idle";
  const generating = status === "generating";
  const content = report?.content ?? null;
  const chat = report?.chat ?? [];
  // A chat change keeps the old report on screen; a new report replaces it.
  const revising = generating && !!content && chat.length > 0 && chat[chat.length - 1].role === "user";
  const building = generating && !revising;

  const apply = useCallback((payload: Payload) => setData(payload), []);

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

  useEffect(() => {
    if (!generating) return;
    const tick = setInterval(() => setNow(Date.now()), 1000);
    return () => clearInterval(tick);
  }, [generating]);

  useEffect(() => {
    chatEnd.current?.scrollIntoView({ behavior: "smooth", block: "nearest" });
  }, [chat.length]);

  const setInput = <K extends keyof Inputs>(key: K, value: Inputs[K]) =>
    setInputs((current) => ({ ...current, [key]: value }));

  const generate = async () => {
    if (content && !window.confirm("Generating again replaces the current report and its chat. Continue?")) {
      return;
    }

    setBusy(true);
    try {
      const res = await api.post(`/career-reports/${id}/generate`, inputs);
      setNow(Date.now());
      apply(res.data.data);
      toast.success("Report generation started.");
    } catch (error) {
      toast.error(errorMessage(error, "Could not start report generation."));
    } finally {
      setBusy(false);
    }
  };

  const sendChange = async () => {
    const text = message.trim();
    if (!text) return;

    setBusy(true);
    try {
      const res = await api.post(`/career-reports/${id}/revise`, { message: text });
      setNow(Date.now());
      apply(res.data.data);
      setMessage("");
    } catch (error) {
      toast.error(errorMessage(error, "Could not send this change."));
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

  const { assessment, system_data: system, options } = data;
  const errors = (report?.issues ?? []).filter((issue) => issue.severity === "error");
  // Report Date is set by the server on the day the report is generated.
  const canGenerate =
    assessment.complete &&
    data.ai_configured &&
    !generating &&
    !busy &&
    !!inputs.target_country.trim() &&
    !!inputs.study_level;
  const canDownload = !!content && !generating && !busy && errors.length === 0 && status !== "failed";
  const showReview = !!content && !building;
  const ranked = content ? [...content.overall_best_fit].sort((a, b) => a.rank - b.rank) : [];

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
          Connected AI is not set up yet. A superadmin can add the API key in AI Settings.
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

            {/* Hidden for now; remove once the report flow is final.
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
            */}

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

            {/* Report Date is now set automatically when the report is generated.
            <Field label="Report Date" required>
              <input
                type="date"
                value={inputs.report_date}
                onChange={(e) => setInput("report_date", e.target.value)}
                className={fieldClass}
              />
            </Field>
            */}

            {/* Hidden for now; remove once the report flow is final.
            <Field label="English Proficiency">
              <input
                value={inputs.english_proficiency}
                onChange={(e) => setInput("english_proficiency", e.target.value)}
                placeholder="IELTS 6.5"
                className={fieldClass}
              />
            </Field>
            */}

            <Field label="Budget per Year">
              <input
                value={inputs.budget}
                onChange={(e) => setInput("budget", e.target.value)}
                placeholder="BDT 22-25 lacs"
                className={fieldClass}
              />
            </Field>

            <Field label="Preferred Cities" optional>
              <input
                value={inputs.preferred_cities}
                onChange={(e) => setInput("preferred_cities", e.target.value)}
                placeholder="e.g. London, Manchester"
                className={fieldClass}
              />
            </Field>
          </div>

          {/* Hidden for now; remove once the report flow is final.
          <Field label="Academic Background">
            <textarea
              rows={3}
              value={inputs.academic_background}
              onChange={(e) => setInput("academic_background", e.target.value)}
              placeholder="Subjects studied, results, gaps in study"
              className={fieldClass}
            />
          </Field>
          */}

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
            {/* Only offered when the student picked common departments. */}
            {system.common_departments.length > 0 && (
              <Toggle
                label="Show Common Departments"
                hint={system.common_departments.join(", ")}
                checked={inputs.include_common_departments}
                onChange={(value) => setInput("include_common_departments", value)}
              />
            )}
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

          <div className="pt-2 space-y-3">
            {building ? (
              <Progress
                title="Generating the report"
                subtitle="Connected is preparing a report from this student's answers."
                steps={BUILD_STEPS}
                startedAt={report?.generation_started_at ?? null}
                estimate={data.estimate_seconds}
                now={now}
              />
            ) : (
              <div className="flex flex-wrap items-center gap-3">
                <button type="button" onClick={generate} disabled={!canGenerate} className={primaryButton}>
                  {content ? "Generate Again" : "Generate Report"}
                </button>
                <span className="text-sm text-gray-600 dark:text-gray-400">
                  Takes {aboutMinutes(data.estimate_seconds)}.
                </span>
              </div>
            )}
          </div>

          {status === "failed" && (
            <p className="text-sm text-red-600 dark:text-red-400">
              Generation failed: {report?.error_message}
            </p>
          )}
        </section>
      )}

      {showReview && content && (
        <>
          {errors.length > 0 && (
            <div className="p-5 rounded-2xl border border-red-300 bg-red-50 dark:bg-red-900/20 dark:border-red-700">
              <p className="font-semibold text-red-700 dark:text-red-400">
                Fix these before downloading. Ask for the change in the chat below.
              </p>
              <ul className="list-disc list-inside text-sm text-red-700 dark:text-red-400">
                {errors.map((issue) => (
                  <li key={issue.message}>{issue.message}</li>
                ))}
              </ul>
            </div>
          )}

          <section className={`${cardClass} relative`}>
            <div className="flex flex-wrap items-center justify-between gap-3">
              <h2 className={headingClass}>Review</h2>
              <button
                type="button"
                onClick={downloadPdf}
                disabled={!canDownload}
                className={`${primaryButton} inline-flex items-center gap-2`}
              >
                <Download size={18} /> Download PDF
              </button>
            </div>

            <div className={revising ? "opacity-50 pointer-events-none space-y-6" : "space-y-6"}>
              <div className="space-y-2">
                <h3 className={sectionHeading}>1. Introduction</h3>
                <p className={`${bodyText} leading-relaxed`}>{data.introduction}</p>
              </div>

              <div className="space-y-2">
                <h3 className={sectionHeading}>2. Industries and Departments of Interest</h3>
                {system.industries.map((industry) => (
                  <div key={industry.name}>
                    <p className="text-sm font-semibold text-gray-900 dark:text-gray-100">{industry.name}</p>
                    <ul className={`list-disc list-inside ml-3 ${bodyText}`}>
                      {industry.departments.map((department) => (
                        <li key={department}>{department}</li>
                      ))}
                    </ul>
                  </div>
                ))}
                {report?.include_common_departments && system.common_departments.length > 0 && (
                  <div>
                    <p className="text-sm font-semibold text-gray-900 dark:text-gray-100">Common Departments</p>
                    <ul className={`list-disc list-inside ml-3 ${bodyText}`}>
                      {system.common_departments.map((department) => (
                        <li key={department}>{department}</li>
                      ))}
                    </ul>
                  </div>
                )}
              </div>

              <div className="space-y-2">
                <h3 className={sectionHeading}>3. Personality Highlights</h3>
                <div className="overflow-x-auto">
                  <table className={tableClass}>
                    <thead className={theadClass}>
                      <tr>
                        <th className={cellClass}>Area</th>
                        <th className={cellClass}>Your Preference</th>
                      </tr>
                    </thead>
                    <tbody>
                      {system.personality.map((row) => (
                        <tr key={row.area} className={rowClass}>
                          <td className={cellClass}>{row.area}</td>
                          <td className={cellClass}>{row.preference}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>

              <div className="space-y-2">
                <h3 className={sectionHeading}>4. Industry &amp; Department Match Analysis</h3>
                <div className="overflow-x-auto">
                  <table className={tableClass}>
                    <thead className={theadClass}>
                      <tr>
                        <th className={cellClass}>Industry</th>
                        <th className={cellClass}>Department</th>
                        <th className={cellClass}>Match Level</th>
                        <th className={cellClass}>Comments</th>
                      </tr>
                    </thead>
                    <tbody>
                      {content.match_analysis.map((row) => (
                        <tr key={row.department} className={rowClass}>
                          <td className={cellClass}>{row.industry}</td>
                          <td className={cellClass}>{row.department}</td>
                          <td className={`${cellClass} whitespace-nowrap`}>{row.match_level}</td>
                          <td className={cellClass}>{row.comments}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>

              <div className="space-y-2">
                <h3 className={sectionHeading}>5. Overall Best Fit</h3>
                <div className="overflow-x-auto">
                  <table className={tableClass}>
                    <thead className={theadClass}>
                      <tr>
                        <th className={cellClass}>Rank</th>
                        <th className={cellClass}>Industry</th>
                        <th className={cellClass}>Department</th>
                        <th className={cellClass}>Reason</th>
                      </tr>
                    </thead>
                    <tbody>
                      {ranked.map((row) => (
                        <tr key={row.department} className={rowClass}>
                          <td className={`${cellClass} text-center`}>{row.rank}</td>
                          <td className={cellClass}>{row.industry}</td>
                          <td className={cellClass}>{row.department}</td>
                          <td className={cellClass}>{row.reason}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>

              <div className="space-y-2">
                <h3 className={sectionHeading}>6. {report?.target_country} Cities with Most Opportunities</h3>
                <div className="overflow-x-auto">
                  <table className={tableClass}>
                    <thead className={theadClass}>
                      <tr>
                        <th className={cellClass}>City</th>
                        <th className={cellClass}>Key Advantages</th>
                      </tr>
                    </thead>
                    <tbody>
                      {content.cities.map((row) => (
                        <tr key={row.city} className={rowClass}>
                          <td className={cellClass}>{row.city}</td>
                          <td className={cellClass}>{row.key_advantages}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>

              <div className="space-y-2">
                <h3 className={sectionHeading}>7. Key Employers</h3>
                {content.key_employers.map((group) => (
                  <div key={group.category}>
                    <p className="text-sm font-semibold text-gray-900 dark:text-gray-100">{group.category}</p>
                    <ul className={`list-disc list-inside ml-3 ${bodyText}`}>
                      {group.employers.map((employer) => (
                        <li key={employer}>{employer}</li>
                      ))}
                    </ul>
                  </div>
                ))}
              </div>

              <div className="space-y-2">
                <h3 className={sectionHeading}>8. Shortlisted Job Titles</h3>
                {content.job_titles.map((group) => (
                  <div key={group.category}>
                    <p className="text-sm font-semibold text-gray-900 dark:text-gray-100">{group.category}</p>
                    <ul className={`list-disc list-inside ml-3 ${bodyText}`}>
                      {group.titles.map((title) => (
                        <li key={title}>{title}</li>
                      ))}
                    </ul>
                  </div>
                ))}
              </div>

              <div className="space-y-2">
                <h3 className={sectionHeading}>9. Final Recommendation</h3>
                <p className={bodyText}>{content.final_recommendation_intro}</p>
                <ul className={`list-disc list-inside ml-3 ${bodyText} space-y-1`}>
                  {content.recommended_programs.map((program) => (
                    <li key={program.program}>
                      <span className="font-semibold">{program.program}</span>
                      {program.licensing_note && (
                        <span className="block ml-5 text-xs text-gray-500 dark:text-gray-400">
                          {program.licensing_note}
                        </span>
                      )}
                    </li>
                  ))}
                </ul>
              </div>

              <div className="space-y-2">
                <h3 className={sectionHeading}>10. Best Fit Program and Why</h3>
                <p className={bodyText}>
                  <span className="font-semibold">Recommended Program:</span>{" "}
                  <span className="font-semibold bg-yellow-300 text-gray-900 px-1 rounded-sm">
                    {content.best_fit_program.program}
                  </span>
                </p>
                <ul className={`list-disc list-inside ml-3 ${bodyText} space-y-1`}>
                  {content.best_fit_program.why.map((reason) => (
                    <li key={reason.heading}>
                      <span className="font-semibold">{reason.heading}:</span> {reason.detail}
                    </li>
                  ))}
                </ul>
              </div>

              <div className="space-y-2">
                <h3 className={sectionHeading}>11. Conclusion</h3>
                {content.conclusion.split(/\n\s*\n/).map((paragraph) => (
                  <p key={paragraph} className={`${bodyText} leading-relaxed`}>
                    {paragraph}
                  </p>
                ))}
              </div>
            </div>
          </section>

          <section className={cardClass}>
            <div>
              <h2 className={headingClass}>Ask for Changes</h2>
              <p className="text-sm text-gray-500 dark:text-gray-400">
                Tell the AI what to change in plain words. The report above updates when it is done.
              </p>
            </div>

            {chat.length > 0 && (
              <div className="max-h-80 overflow-y-auto space-y-3 pr-1">
                {chat.map((entry, index) => (
                  <div key={index} className={entry.role === "user" ? "flex justify-end" : "flex justify-start"}>
                    <div
                      className={`max-w-[85%] px-4 py-2 rounded-2xl text-sm whitespace-pre-wrap ${
                        entry.role === "user"
                          ? "bg-blue-600 text-white"
                          : entry.error
                            ? "bg-red-50 text-red-800 dark:bg-red-900/30 dark:text-red-200"
                            : "bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-100"
                      }`}
                    >
                      {entry.text}
                    </div>
                  </div>
                ))}
                <div ref={chatEnd} />
              </div>
            )}

            {revising ? (
              <Progress
                title="Updating the report"
                subtitle="Connected is making the change you asked for."
                steps={REVISE_STEPS}
                startedAt={report?.generation_started_at ?? null}
                estimate={data.estimate_seconds}
                now={now}
              />
            ) : (
              <div className="flex gap-2 items-end">
                <textarea
                  rows={2}
                  value={message}
                  onChange={(e) => setMessage(e.target.value)}
                  onKeyDown={(e) => {
                    if (e.key === "Enter" && !e.shiftKey) {
                      e.preventDefault();
                      if (!busy) sendChange();
                    }
                  }}
                  maxLength={2000}
                  placeholder='For example: "Change Cybersecurity to High" or "Make the conclusion shorter"'
                  aria-label="Change request"
                  className={fieldClass}
                />
                <button
                  type="button"
                  onClick={sendChange}
                  disabled={busy || !message.trim() || !data.ai_configured}
                  aria-label="Send change request"
                  className={`${primaryButton} inline-flex items-center gap-2`}
                >
                  <Send size={16} /> Send
                </button>
              </div>
            )}
          </section>
        </>
      )}
    </div>
  );
}
