// src/pages/User/pages/QACompletion.tsx
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../../../api/axios";
import Header from "../Header";
import Footer from "../Footer";

export default function QACompletion() {
  const navigate = useNavigate();
  const [userName, setUserName] = useState<string>("");
  const [showModal, setShowModal] = useState(false);

  useEffect(() => {
    const fetchUser = async () => {
      try {
        const res = await api.get("/profile");
        setUserName(`${res.data.first_name} ${res.data.last_name}`);
      } catch (err) {
        console.error("Failed to fetch user:", err);
      }
    };
    fetchUser();
  }, []);

  const handleLogout = () => {
    sessionStorage.clear();
  window.location.href = "/signin";
  };

  const handleSendToCounsellor = async () => {
    try {
      await api.put("/reports/update-status", { report_notification: 1 });
      setShowModal(true);
    } catch (err) {
      console.error("Failed to update report:", err);
      alert("Failed to send report to counsellor. Please try again.");
    }
  };

  const handleModalOk = () => {
    setShowModal(false);
    navigate("/dashboard");
  };

  return (
    <>
      <link
        href="https://fonts.googleapis.com/css2?family=Abril+Fatface&family=Poppins:wght@400;500;600;700;800;900&display=swap"
        rel="stylesheet"
      />
      <style>{`
        :root {
          --bg: #0f1533;
          --accent: #18e08a;
        }
        body {
          font-family: 'Poppins', system-ui, -apple-system, "Segoe UI", Roboto, 'Helvetica Neue', Arial;
          background-color: #080b3d;
        }
      `}</style>

      <div className="text-white bg-[#080b3d] min-h-screen flex flex-col">
        <Header userName={userName} onLogout={handleLogout} />

        <main className="flex-1 flex flex-col items-center px-6 py-16 max-w-4xl mx-auto">
          <div className="w-full max-w-5xl bg-[#0c1240]/90 backdrop-blur-xl border border-white/10 rounded-2xl sm:rounded-3xl shadow-2xl p-6 sm:p-10 md:p-14 text-left">

            {/* Title + Description */}
            <h1 className="text-3xl sm:text-4xl md:text-5xl font-extrabold mb-4 sm:mb-6">
              Congratulations!
            </h1>
            <p className="text-gray-300 text-sm sm:text-base mb-1">
              We’ve reached the <span className="font-semibold text-white">end of the line!</span>
            </p>
            <p className="text-gray-400 text-xs sm:text-sm mb-6 sm:mb-8 leading-relaxed">
              Thanks for sharing your preferences with us! It’s helped us understand your goals
              better, so we can guide you toward the <span className="font-semibold text-white">perfect program</span>.
            </p>

            {/* Steps */}
            <div className="w-full border-t border-b border-gray-700 py-3 mb-8 sm:mb-12">
              {[
                { label: "Program Preferences", done: true },
                { label: "Career Preferences", done: true },
                { label: "Personality Assessment", done: true },
              ].map((item, i) => (
                <div key={i} className="flex justify-between items-center py-2 text-sm sm:text-base">
                  <span className="font-semibold text-gray-100">{item.label}</span>
                  <span className={`w-3 h-3 rounded-full ${item.done ? "bg-green-400" : "border border-gray-400"}`}></span>
                </div>
              ))}
            </div>

            {/* Progress Chart */}
            <div className="flex justify-center mb-10 sm:mb-12">
              <div className="relative w-44 h-44 sm:w-56 sm:h-56 md:w-64 md:h-64">
                <svg className="w-full h-full" viewBox="0 0 100 100">
                  <defs>
                    <linearGradient id="progressGradient" x1="1" y1="0" x2="0" y2="1">
                      <stop offset="0%" stopColor="#00ff95" />
                      <stop offset="100%" stopColor="#a0ff00" />
                    </linearGradient>
                  </defs>
                  <circle cx="50" cy="50" r="45" stroke="rgba(255,255,255,0.1)" strokeWidth="10" fill="none" />
                  <circle
                    cx="50"
                    cy="50"
                    r="45"
                    stroke="url(#progressGradient)"
                    strokeWidth="10"
                    fill="none"
                    strokeDasharray="283"
                    strokeDashoffset="0"
                    strokeLinecap="round"
                    transform="rotate(-90 50 50)"
                  />
                </svg>
                <div className="absolute inset-0 flex flex-col justify-center items-center">
                  <span className="text-3xl sm:text-4xl md:text-5xl font-extrabold text-white">100%</span>
                </div>
              </div>
            </div>

            {/* Send to Counsellor Button */}
            <button
              onClick={handleSendToCounsellor}
              className="w-full bg-[#0066ff] hover:bg-[#0051cc] text-white font-semibold text-sm sm:text-base md:text-lg py-3 sm:py-4 rounded-xl sm:rounded-2xl transition-transform transform hover:scale-105 shadow-lg flex items-center justify-center gap-2"
            >
              Send to Counsellor
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor" className="w-5 h-5 sm:w-6 sm:h-6">
                <path strokeLinecap="round" strokeLinejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3" />
              </svg>
            </button>

          </div>
        </main>

        <Footer />

        {/* Modal */}
        {showModal && (
          <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/70">
            <div className="bg-gray-900 rounded-3xl p-8 sm:p-12 w-11/12 sm:w-96 shadow-2xl animate-fadeIn">
              <h2 className="text-2xl sm:text-3xl font-bold text-white mb-4 text-center">
                Report Completed
              </h2>
              <p className="text-gray-300 text-center mb-6 leading-relaxed">
                Your program counselling session has been completed.<br />
                Please speak to your counsellor regarding next steps.
              </p>
              <button
                onClick={handleModalOk}
                className="w-full bg-[#18e08a] hover:bg-[#12b46b] text-black font-semibold py-2 px-6 rounded-xl transition-all shadow-lg"
              >
                OK
              </button>
            </div>
          </div>
        )}
      </div>
    </>
  );
}
