// src/pages/User/UserDashboard.tsx
import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import api from "../../api/axios";
import Header from "../User/Header";
import Footer from "../User/Footer";
import Loader from "../Loader/Loader";

interface Department {
  id: number;
  name: string;
  details?: string;
}

interface IndustryGroup {
  id: number;
  industry: string;
  sub_departments: Department[];
}

interface SubmittedAnswer {
  id: number;
  selected_option: string;
  question: {
    id: number;
    title: string;
    details?: string;
  };
}

export default function UserDashboard() {
  const navigate = useNavigate();

  const [userName, setUserName] = useState("");
  const [industries, setIndustries] = useState<IndustryGroup[]>([]);
  const [commonDepartments, setCommonDepartments] = useState<Department[]>([]);
  const [submittedAnswers, setSubmittedAnswers] = useState<SubmittedAnswer[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    api.get("/profile").then((res) =>
      setUserName(`${res.data.first_name} ${res.data.last_name}`)
    );
  }, []);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const res = await api.get("/user-dashboard-data");

        if (!res.data.success) {
          navigate("/introduction", { replace: true });
          return;
        }

        const { industries, common_departments, submitted_answers } = res.data.data;

        if (!industries?.length || !submitted_answers?.length) {
          navigate("/introduction", { replace: true });
          return;
        }

        setIndustries(industries);
        setCommonDepartments(common_departments || []);
        setSubmittedAnswers(submitted_answers || []);
      } catch {
        navigate("/introduction", { replace: true });
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [navigate]);

  const CORE_GRADIENTS = [
    "from-[#00A651] to-[#006837]",
    "from-[#6A1B9A] to-[#4A148C]",
    "from-[#1E88E5] to-[#1565C0]",
    "from-[#FF6D00] to-[#E65100]",
  ];

  const getIndustryGradientIndex = (industry: string) => {
    const name = industry.toLowerCase();
    if (name.includes("health")) return 0;
    if (name.includes("it") || name.includes("technology") || name.includes("science")) return 1;
    if (name.includes("business") || name.includes("finance")) return 2;
    if (name.includes("engineer")) return 3;
    return -1;
  };

  if (loading) return <Loader message="Fetching your dashboard..." />;

  let fallbackIndex = 0;

  return (
    <>
      <link
        href="https://fonts.googleapis.com/css2?family=Abril+Fatface&family=Poppins:wght@400;500;600;700;800;900&display=swap"
        rel="stylesheet"
      />
      <style>
        {`
          body {
            font-family: 'Poppins', system-ui, -apple-system, "Segoe UI", Roboto, 'Helvetica Neue', Arial;
            background-color: #080b3d;
          }
        `}
      </style>

      <div className="text-white bg-[#080b3d] min-h-screen flex flex-col">
        <Header
          userName={userName}
          onLogout={() => {
            sessionStorage.clear();
            window.location.href = "/signin";
          }}
        />

        <main className="flex-grow flex justify-center items-start px-6 py-16">
          <div className="w-full max-w-6xl rounded-2xl p-4 sm:p-6 md:p-8 border border-white/10 shadow-2xl bg-[#0f1533]/60 backdrop-blur-md">

            <h1 className="text-lg sm:text-2xl md:text-4xl font-extrabold mb-2">
              My Report
            </h1>

            <p className="text-gray-300 mb-6 sm:mb-8 text-sm lg:text-base leading-relaxed">
              Here’s a summary of your career interest selections.
            </p>

            {/* === INDUSTRY CARDS (MATCHED WITH SelectedData) === */}
            <div className="space-y-5 sm:space-y-8">
              {industries.map((group) => {
                const fixedIndex = getIndustryGradientIndex(group.industry);
                const gradient =
                  fixedIndex !== -1
                    ? CORE_GRADIENTS[fixedIndex]
                    : CORE_GRADIENTS[fallbackIndex++ % 4];

                return (
                  <div
                    key={group.id}
                    className={`
                      rounded-2xl sm:rounded-3xl
                      p-4 sm:p-6 md:p-7
                      shadow-xl sm:shadow-2xl
                      transition-all duration-300
                      bg-gradient-to-br ${gradient}
                      border border-white/20
                      sm:hover:-translate-y-2 sm:hover:shadow-3xl
                    `}
                  >
                    <h2 className="text-base sm:text-xl md:text-3xl font-extrabold mb-4 text-white">
                      {group.industry}
                    </h2>

                    {group.sub_departments.length > 0 ? (
                      <div className="flex flex-wrap gap-2 sm:gap-4">
                        {group.sub_departments.map((sub) => (
                          <span
                            key={sub.id}
                            className="
                              bg-white/25
                              px-3 sm:px-5
                              py-1.5 sm:py-2
                              rounded-full
                              text-xs sm:text-sm md:text-base
                              font-semibold
                              backdrop-blur-sm
                              border border-white/30
                            "
                            title={sub.details}
                          >
                            {sub.name}
                          </span>
                        ))}
                      </div>
                    ) : (
                      <p className="text-white/80 text-xs sm:text-sm italic">
                        No specific roles selected.
                      </p>
                    )}

                    {commonDepartments.length > 0 && (
                      <div className="mt-5 sm:mt-6 pt-4 sm:pt-5 border-t border-white/30">
                        <p className="text-white/90 text-xs sm:text-sm font-medium mb-3">
                          Common roles across your interests:
                        </p>

                        <div className="flex flex-wrap gap-2 sm:gap-4">
                          {commonDepartments.map((dept) => (
                            <span
                              key={dept.id}
                              className="
                                bg-white/15
                                px-3 sm:px-5
                                py-1.5 sm:py-2
                                rounded-full
                                text-xs sm:text-sm md:text-base
                                font-medium
                                backdrop-blur-sm
                                border border-white/20
                              "
                              title={dept.details}
                            >
                              {dept.name}
                            </span>
                          ))}
                        </div>
                      </div>
                    )}
                  </div>
                );
              })}
            </div>

            {/* === PERSONALITY TABLE (UNCHANGED) === */}
            {submittedAnswers.length > 0 && (
              <div className="mt-10">
                <h2 className="text-xl sm:text-2xl font-bold mb-6">
                  Personality Highlights
                </h2>

                <div className="bg-white/10 rounded-2xl overflow-x-auto">
                  <table className="min-w-full text-sm">
                    <thead>
                      <tr className="border-b border-white/20 text-left">
                        <th className="px-4 py-3">Area</th>
                        <th className="px-4 py-3">Preference</th>
                      </tr>
                    </thead>
                    <tbody>
                      {submittedAnswers.map((ans) => (
                        <tr key={ans.id} className="border-b border-white/10">
                          <td className="px-4 py-2">{ans.question.title}</td>
                          <td className="px-4 py-2">{ans.selected_option}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            )}

            <div className="mt-10">
              <button
                onClick={() => navigate("/introduction")}
                className="w-full bg-[#0055FF] hover:bg-[#0042cc] text-white font-semibold py-3 rounded-xl"
              >
                Return to Dashboard
              </button>
            </div>
          </div>
        </main>

        <Footer />
      </div>
    </>
  );
}
