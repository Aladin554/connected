import { useEffect, useState } from "react";
import type { ReactNode } from "react";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import api from "../../../api/axios";

interface ModelOption {
  id: string;
  label: string;
  input_price: number;
  output_price: number;
  supports_none: boolean;
}

interface Settings {
  model: string;
  reasoning_effort: string;
  max_output_tokens: number;
  timeout: number;
  key: { set: boolean; source: "panel" | "env" | null; masked: string | null };
  updated_at: string | null;
  options: { models: ModelOption[]; efforts: string[] };
}

// Measured on one test report, so the cost shown is a guide only.
const REPORT_INPUT_TOKENS = 2047;
const REPORT_OUTPUT_TOKENS = 3400;

const EFFORT_HINTS: Record<string, string> = {
  none: "Fastest and cheapest, with no extra reasoning.",
  low: "Faster and cheaper, with lighter analysis.",
  medium: "Recommended balance of quality, time and cost.",
  high: "More careful analysis, but slower and costs more.",
  xhigh: "Very careful analysis, with much more time and cost.",
  max: "Deepest analysis, and the slowest and most expensive level.",
};

const CUSTOM_MODEL = "__custom__";

const fieldClass =
  "w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 px-3 py-2 rounded-lg text-sm text-gray-900 dark:text-gray-100 focus:outline-none focus:ring-2 focus:ring-blue-500";
const primaryButton =
  "px-5 py-2.5 rounded-lg bg-blue-600 text-white font-medium hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed transition";
const secondaryButton =
  "px-5 py-2.5 rounded-lg border border-gray-300 dark:border-gray-600 text-gray-800 dark:text-gray-200 font-medium hover:bg-gray-50 dark:hover:bg-gray-700 disabled:opacity-50 disabled:cursor-not-allowed transition";

function errorMessage(error: unknown, fallback: string): string {
  const data = (error as { response?: { data?: { message?: string } } }).response?.data;
  return data?.message ?? fallback;
}

function Field({ label, hint, children }: { label: string; hint?: string; children: ReactNode }) {
  return (
    <label className="block space-y-1">
      <span className="text-sm font-medium text-gray-700 dark:text-gray-300">{label}</span>
      {children}
      {hint && <span className="block text-xs text-gray-500 dark:text-gray-400">{hint}</span>}
    </label>
  );
}

export default function AiSettings() {
  const [settings, setSettings] = useState<Settings | null>(null);
  const [model, setModel] = useState("");
  const [customModel, setCustomModel] = useState(false);
  const [effort, setEffort] = useState("medium");
  const [maxTokens, setMaxTokens] = useState(32000);
  const [timeout, setTimeoutSeconds] = useState(280);
  const [apiKey, setApiKey] = useState("");
  const [loading, setLoading] = useState(true);
  const [busy, setBusy] = useState(false);
  const [check, setCheck] = useState<{ ok: boolean; message: string } | null>(null);

  const apply = (data: Settings) => {
    setSettings(data);
    setModel(data.model);
    setCustomModel(!data.options.models.some((option) => option.id === data.model));
    setEffort(data.reasoning_effort);
    setMaxTokens(data.max_output_tokens);
    setTimeoutSeconds(data.timeout);
    setApiKey("");
  };

  useEffect(() => {
    api
      .get("/ai-settings")
      .then((res) => apply(res.data.data))
      .catch((error) => toast.error(errorMessage(error, "Failed to load AI settings.")))
      .finally(() => setLoading(false));
  }, []);

  const save = async (clearKey = false) => {
    setBusy(true);
    setCheck(null);
    try {
      const res = await api.put("/ai-settings", {
        api_key: apiKey || null,
        clear_api_key: clearKey,
        model,
        reasoning_effort: effort,
        max_output_tokens: maxTokens,
        timeout,
      });
      apply(res.data.data);
      toast.success(clearKey ? "Saved key removed." : "AI settings saved.");
    } catch (error) {
      toast.error(errorMessage(error, "Could not save AI settings."));
    } finally {
      setBusy(false);
    }
  };

  const testConnection = async () => {
    setBusy(true);
    setCheck(null);
    try {
      const res = await api.post("/ai-settings/test", { api_key: apiKey || null, model });
      setCheck(res.data.data);
    } catch (error) {
      setCheck({ ok: false, message: errorMessage(error, "Could not test the connection.") });
    } finally {
      setBusy(false);
    }
  };

  if (loading) {
    return <div className="p-6 text-center text-gray-700 dark:text-gray-200">Loading...</div>;
  }

  if (!settings) {
    return (
      <div className="p-6 text-center text-red-500">
        <ToastContainer />
        AI settings could not be loaded.
      </div>
    );
  }

  const selected = settings.options.models.find((option) => option.id === model);
  const efforts = settings.options.efforts.filter(
    (level) => level !== "none" || !selected || selected.supports_none
  );
  const estimate = selected
    ? (REPORT_INPUT_TOKENS * selected.input_price + REPORT_OUTPUT_TOKENS * selected.output_price) / 1_000_000
    : null;
  const keySource =
    settings.key.source === "panel"
      ? "Saved in AI Settings"
      : settings.key.source === "env"
      ? "Using the server's .env file"
      : "No key set";

  return (
    <div className="p-5 lg:p-8 max-w-[760px] mx-auto space-y-6">
      <ToastContainer />

      <div>
        <h1 className="text-3xl font-bold text-gray-900 dark:text-gray-100">AI Settings</h1>
        <p className="text-gray-600 dark:text-gray-400 mt-1">
          These settings control how ChatGPT writes Career Alignment Reports. Changes apply to the next report.
        </p>
      </div>

      <section className="bg-white dark:bg-gray-800 p-6 rounded-2xl shadow-md border border-gray-200 dark:border-gray-700 space-y-4">
        <h2 className="text-xl font-semibold text-gray-900 dark:text-gray-100">API Key</h2>

        <div className="flex flex-wrap items-center justify-between gap-3 text-sm">
          <div className="text-gray-700 dark:text-gray-300">
            <p className="font-medium">{keySource}</p>
            {settings.key.masked && <p className="font-mono text-gray-500">{settings.key.masked}</p>}
          </div>
          {settings.key.source === "panel" && (
            <button type="button" onClick={() => save(true)} disabled={busy} className={secondaryButton}>
              Remove Saved Key
            </button>
          )}
        </div>

        <Field label="New API Key" hint="Leave blank to keep the current key. The saved key is encrypted and never shown again.">
          <input
            id="ai-api-key"
            type="password"
            autoComplete="new-password"
            value={apiKey}
            onChange={(e) => setApiKey(e.target.value)}
            placeholder="sk-..."
            className={fieldClass}
          />
        </Field>
      </section>

      <section className="bg-white dark:bg-gray-800 p-6 rounded-2xl shadow-md border border-gray-200 dark:border-gray-700 space-y-4">
        <h2 className="text-xl font-semibold text-gray-900 dark:text-gray-100">Model</h2>

        <Field
          label="ChatGPT Model"
          hint={
            estimate !== null
              ? `About $${estimate < 0.01 ? estimate.toFixed(3) : estimate.toFixed(2)} per report at medium reasoning. Input $${selected?.input_price} and output $${selected?.output_price} per 1M tokens.`
              : "Enter the exact model name from OpenAI."
          }
        >
          <select
            id="ai-model"
            value={customModel ? CUSTOM_MODEL : model}
            onChange={(e) => {
              const isCustom = e.target.value === CUSTOM_MODEL;
              setCustomModel(isCustom);
              setModel(isCustom ? "" : e.target.value);
              if (!isCustom && effort === "none") {
                const option = settings.options.models.find((item) => item.id === e.target.value);
                if (option && !option.supports_none) setEffort("medium");
              }
            }}
            className={fieldClass}
          >
            {settings.options.models.map((option) => (
              <option key={option.id} value={option.id}>
                {option.label}
              </option>
            ))}
            <option value={CUSTOM_MODEL}>Other model</option>
          </select>
        </Field>

        {customModel && (
          <Field label="Model Name">
            <input
              id="ai-custom-model"
              value={model}
              onChange={(e) => setModel(e.target.value.trim())}
              placeholder="gpt-..."
              className={fieldClass}
            />
          </Field>
        )}

        <Field label="Reasoning Level" hint={EFFORT_HINTS[effort]}>
          <select id="ai-effort" value={effort} onChange={(e) => setEffort(e.target.value)} className={fieldClass}>
            {efforts.map((level) => (
              <option key={level} value={level}>
                {level}
              </option>
            ))}
          </select>
        </Field>

        <div className="grid sm:grid-cols-2 gap-4">
          <Field label="Maximum Output Tokens" hint="Between 8,000 and 128,000. A low limit can cut a report short.">
            <input
              id="ai-max-tokens"
              type="number"
              min={8000}
              max={128000}
              step={1000}
              value={maxTokens}
              onChange={(e) => setMaxTokens(Number(e.target.value))}
              className={fieldClass}
            />
          </Field>

          <Field label="Request Timeout (seconds)" hint="Between 30 and 280. Higher reasoning levels need more time.">
            <input
              id="ai-timeout"
              type="number"
              min={30}
              max={280}
              value={timeout}
              onChange={(e) => setTimeoutSeconds(Number(e.target.value))}
              className={fieldClass}
            />
          </Field>
        </div>
      </section>

      {check && (
        <div
          role="status"
          className={`p-4 rounded-xl text-sm ${
            check.ok
              ? "bg-green-50 text-green-800 dark:bg-green-900/20 dark:text-green-300"
              : "bg-red-50 text-red-800 dark:bg-red-900/20 dark:text-red-300"
          }`}
        >
          {check.message}
        </div>
      )}

      <div className="flex flex-wrap items-center gap-3">
        <button type="button" onClick={() => save()} disabled={busy || !model} className={primaryButton}>
          Save Settings
        </button>
        <button type="button" onClick={testConnection} disabled={busy || !model} className={secondaryButton}>
          Test Connection
        </button>
      </div>
    </div>
  );
}
