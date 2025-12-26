// src/pages/User/pages/QAInstructions.tsx
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../../../api/axios";
import Header from "../Header";
import Footer from "../Footer";
import Loader from "../../Loader/Loader";

export default function QAInstructions() {
  const navigate = useNavigate();
  const [userName, setUserName] = useState<string>("");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchUser = async () => {
      try {
        setLoading(true);
        const res = await api.get("/profile");
        setUserName(`${res.data.first_name} ${res.data.last_name}`);
      } catch (err) {
        console.error("Failed to fetch user:", err);
      } finally {
        setLoading(false);
      }
    };
    fetchUser();
  }, []);

  const handleLogout = () => {
    sessionStorage.clear();
  window.location.href = "/signin";
  };

  if (loading) return <Loader message="Fetching user data..." />;

  return (
    <>
      {/* Google Fonts */}
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
        @keyframes pulseRhythm {
          0%,10% { transform: scale(1); opacity: 0.8; }
          20% { transform: scale(1.05); opacity: 1; }
          30% { transform: scale(1); opacity: 0.8; }
          40% { transform: scale(1.05); opacity: 1; }
          50% { transform: scale(1); opacity: 0.8; }
          60% { transform: scale(1.05); opacity: 1; }
          70%,100% { transform: scale(1); opacity: 0.8; }
        }
        @keyframes fillProgress {
          0% { stroke-dashoffset: 283; }
          100% { stroke-dashoffset: 70; }
        }
      `}</style>

      <div className="text-white bg-[#080b3d] min-h-screen flex flex-col">
        <Header userName={userName} onLogout={handleLogout} />

         <main className="flex-1 flex flex-col items-center px-6 py-16 max-w-4xl mx-auto">
          <div className="w-full max-w-4xl bg-[#0f1533]/80 backdrop-blur-md border border-white/10 rounded-3xl shadow-2xl p-6 sm:p-10 lg:p-16 transition-all">
            
            {/* Title */}
            <h1 className="text-4xl sm:text-5xl lg:text-6xl font-extrabold mb-6 text-[#a757f7]">
              Amazing {userName.split(" ")[1]}!
            </h1>

            {/* Subtitle */}
            <p className="text-gray-300 text-sm sm:text-base lg:text-lg mb-8 leading-relaxed">
              This is the{" "}
              <span className="text-white font-semibold">
                final step {userName?.split(" ")[0] || ""}!
              </span>{" "}
              We are about to discover the answer you’ve been waiting for!
            </p>

            {/* Instructions Divider */}
            <div className="border-t border-b border-gray-600 py-2 flex justify-between items-center mb-10 text-xs sm:text-sm lg:text-base">
              <span className="tracking-wide font-bold">Instructions</span>
              <span className="text-xl lg:text-2xl font-bold">➜</span>
            </div>

            {/* Description */}
            <p className="text-gray-300 text-xs sm:text-sm lg:text-base mb-12 leading-relaxed">
              Now we would like to explore your personality on a deeper level so we can
              connect your{" "}
              <span className="text-white font-semibold">
                interests and preferences
              </span>{" "}
              to the characteristics of each role.
              <br /><br />
              In this step, we will ask you{" "}
              <span className="text-white font-semibold">20 questions</span>. Please
              answer them carefully.
            </p>

            {/* Animated Circle */}
            <div className="relative w-56 h-56 sm:w-64 sm:h-64 lg:w-72 lg:h-72 mx-auto mb-16 flex items-center justify-center">
              {/* Outer animated ring */}
             

              {/* Progress Circle */}
              <svg className="w-full h-full" viewBox="0 0 100 100">
                <defs>
                  <linearGradient id="progressGradient" x1="1" y1="0" x2="0" y2="1">
                    <stop offset="0%" stopColor="#6366f1" />
                    <stop offset="100%" stopColor="#f97316" />
                  </linearGradient>
                </defs>

                <circle
                  cx="50"
                  cy="50"
                  r="45"
                  stroke="rgba(255,255,255,0.1)"
                  strokeWidth="10"
                  fill="none"
                />

                <circle
                  cx="50"
                  cy="50"
                  r="45"
                  stroke="url(#progressGradient)"
                  strokeWidth="10"
                  fill="none"
                  strokeDasharray="283"
                  strokeDashoffset="283"
                  strokeLinecap="round"
                  transform="rotate(-90 50 50)"
                  className="animate-[fillProgress_3s_ease-out_forwards]"
                />
              </svg>

              {/* Step Text */}
              <div className="absolute flex flex-col items-center justify-center">
                <span className="text-xs sm:text-sm text-gray-300 font-medium">STEP</span>
                <span className="text-2xl sm:text-3xl lg:text-4xl font-extrabold">3 of 3</span>
              </div>
            </div>


            {/* CTA Button */}
            <div className="flex justify-center">
              <button
                onClick={() => navigate("/questionnaire")}
                className="w-full sm:w-1/2 lg:w-1/4 bg-[#0055FF] hover:bg-[#0042cc] text-white font-semibold py-3 rounded-xl transition duration-200"
              >
                Get Started →
              </button>
            </div>

          </div>
        </main>

        <Footer />
      </div>
    </>
  );
}
