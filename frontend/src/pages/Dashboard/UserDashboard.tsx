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

  const [userName, setUserName] = useState<string>("");
  const [industries, setIndustries] = useState<IndustryGroup[]>([]);
  const [commonDepartments, setCommonDepartments] = useState<Department[]>([]);
  const [submittedAnswers, setSubmittedAnswers] = useState<SubmittedAnswer[]>([]);
  const [loading, setLoading] = useState<boolean>(true);

  // --- Fetch user profile
  useEffect(() => {
    api
      .get("/profile")
      .then((res) => setUserName(`${res.data.first_name} ${res.data.last_name}`))
      .catch((err) => console.error("Profile fetch failed:", err));
  }, []);

  // --- Fetch dashboard data
  useEffect(() => {
    const fetchDashboardData = async () => {
      try {
        setLoading(true);
        const res = await api.get("/user-dashboard-data");

        if (res.data.success) {
          const industriesData = Array.isArray(res.data.data.industries) ? res.data.data.industries : [];
          const submittedAnswersData = Array.isArray(res.data.data.submitted_answers)
            ? res.data.data.submitted_answers
            : [];
          const commonDepartmentsData = Array.isArray(res.data.data.common_departments)
            ? res.data.data.common_departments
            : [];

          if (industriesData.length === 0 || submittedAnswersData.length === 0) {
            navigate("/introduction", { replace: true });
            return;
          }

          setIndustries(industriesData);
          setCommonDepartments(commonDepartmentsData);
          setSubmittedAnswers(submittedAnswersData);
        } else {
          navigate("/introduction", { replace: true });
        }
      } catch (err) {
        console.error("Error fetching dashboard data:", err);
        navigate("/introduction", { replace: true });
      } finally {
        setLoading(false);
      }
    };

    fetchDashboardData();
  }, [navigate]);

  // --- Core gradient colors (same as SelectedData)
  const CORE_GRADIENTS = [
    "from-[#00A651] to-[#006837]", // Green - Healthcare
    "from-[#6A1B9A] to-[#4A148C]", // Purple - IT/Tech
    "from-[#1E88E5] to-[#1565C0]", // Blue - Business/Finance
    "from-[#FF6D00] to-[#E65100]", // Orange - Engineering
  ];

  // --- Map industries to gradient index
  const getIndustryGradientIndex = (industryName: string): number => {
    const name = industryName.toLowerCase();
    if (name.includes("health") || name.includes("medicine") || name.includes("healthcare")) return 0;
    if (name.includes("it") || name.includes("computer") || name.includes("technology") || name.includes("science"))
      return 1;
    if (name.includes("business") || name.includes("finance")) return 2;
    if (name.includes("engineer")) return 3;
    return -1; // fallback
  };

  if (loading) return <Loader message="Fetching your dashboard..." />;

  // --- Fallback counter for unknown industries
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
          <div className="w-full max-w-6xl rounded-2xl shadow-2xl p-8 border border-white/10 bg-[#0f1533]/60 backdrop-blur-md">
            <h1 className="text-4xl font-extrabold mb-4">My Report</h1>
            <p className="text-gray-300 mb-8 leading-relaxed">
              Here’s a summary of your career interest selections, including common roles within each industry.
            </p>

            {/* Industries */}
            {industries.length > 0 ? (
              <div className="space-y-6">
                {industries.map((group) => {
                  const fixedIndex = getIndustryGradientIndex(group.industry);
                  let gradient;
                  if (fixedIndex !== -1) {
                    gradient = CORE_GRADIENTS[fixedIndex];
                    fallbackIndex = 0; // reset fallback
                  } else {
                    gradient = CORE_GRADIENTS[fallbackIndex % CORE_GRADIENTS.length];
                    fallbackIndex++;
                  }

                  return (
                    <div
                      key={group.id}
                      className={`rounded-2xl p-6 shadow-lg transition-all duration-300 transform hover:-translate-y-1 hover:shadow-xl bg-gradient-to-br ${gradient}`}
                    >
                      <h2 className="text-2xl font-extrabold mb-3">{group.industry}</h2>

                      {group.sub_departments.length > 0 ? (
                        <div className="flex flex-wrap gap-3 mt-3">
                          {group.sub_departments.map((subDept) => (
                            <span
                              key={`${group.id}-${subDept.id}`}
                              className="bg-white/20 px-4 py-1.5 rounded-full text-sm font-medium backdrop-blur-sm"
                              title={subDept.details}
                            >
                              {subDept.name}
                            </span>
                          ))}
                        </div>
                      ) : (
                        <p className="text-gray-200 text-sm italic">No sub-departments found.</p>
                      )}

                      {commonDepartments.length > 0 && (
                        <div className="flex flex-wrap gap-3 mt-5 border-t border-white/20 pt-4">
                          {commonDepartments.map((dept) => (
                            <span
                              key={`common-${dept.id}`}
                              className="bg-white/10 px-4 py-1.5 rounded-full text-sm font-medium backdrop-blur-sm text-white/90"
                              title={dept.details}
                            >
                              {dept.name}
                            </span>
                          ))}
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            ) : (
              <p className="text-center text-gray-400">No industries found.</p>
            )}

            {/* Personality Highlights */}
            {submittedAnswers.length > 0 && (
              <div className="mt-10">
                <h2 className="text-2xl font-bold mb-6">Personality Highlights</h2>
                <div className="bg-white/10 rounded-2xl overflow-x-auto">
                  <table className="min-w-full text-sm">
                    <thead>
                      <tr className="text-left border-b border-white/20">
                        <th className="px-4 py-3">Area</th>
                        <th className="px-4 py-3">Preference</th>
                      </tr>
                    </thead>
                    <tbody>
                      {submittedAnswers.map((ans) => (
                        <tr key={ans.id} className="border-b border-white/10">
                          <td className="px-4 py-2">{ans.question?.title}</td>
                          <td className="px-4 py-2">{ans.selected_option}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            )}

            {/* Restart Button */}
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
