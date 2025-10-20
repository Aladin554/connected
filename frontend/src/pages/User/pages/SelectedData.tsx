// src/pages/User/pages/SelectedData.tsx

import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../../../api/axios";
import Header from "../Header";
import Footer from "../Footer";

export default function SelectedData() {
  const navigate = useNavigate();
  const [userName, setUserName] = useState<string>("");

  // ✅ Fetch user name
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

  // ✅ Logout
  const handleLogout = () => {
    localStorage.removeItem("token");
    sessionStorage.removeItem("token");
    navigate("/signin");
  };

  return (
    <>
      {/* Google Fonts */}
      <link
        href="https://fonts.googleapis.com/css2?family=Abril+Fatface&family=Poppins:wght@400;500;600;700;800;900&display=swap"
        rel="stylesheet"
      />
      <style>
        {`
          :root {
            --bg: #0f1533;
            --accent: #18e08a;
          }
          body {
            font-family: 'Poppins', system-ui, -apple-system, "Segoe UI", Roboto, 'Helvetica Neue', Arial;
            background-color: #080b3d;
          }
          .font-serif {
            font-family: 'serif';
          }
        `}
      </style>

      <div
        className="text-white bg-[#080b3d] min-h-screen"
        style={{ fontFamily: "Poppins, sans-serif" }}
      >
        {/* Header */}
        <Header userName={userName} onLogout={handleLogout} />

        {/* ✅ Main */}
        <main className="flex-1 flex justify-center items-start px-4 py-6">
          <div className="w-full max-w-6xl rounded-2xl shadow-2xl text-white p-8 border border-white/10 bg-[#0f1533]/60 backdrop-blur-md">
            <h1 className="text-4xl font-extrabold text-white mb-3">
              Alright.
            </h1>
            <p className="text-gray-300 mb-8 leading-relaxed text-sm lg:text-base">
              Looks like we are getting to know you better! It seems that you
              feel passionate about working in the following roles within each
              industry:
            </p>

            {/* ✅ Industry Cards */}
            <div className="space-y-6">
              {/* Healthcare Card */}
              <div className="rounded-2xl p-6 text-left shadow-lg transition-all duration-300 transform hover:-translate-y-1 hover:shadow-xl bg-gradient-to-br from-[#f97316] to-[#fb923c]">
                <h2 className="text-2xl font-extrabold mb-3">
                  Healthcare & <br /> Medicine Industry
                </h2>
                <div className="flex flex-wrap gap-3 mt-3">
                  {["Accounting Manager", "Nurse", "Therapist"].map((role) => (
                    <span
                      key={role}
                      className="bg-white/20 px-4 py-1.5 rounded-full text-sm font-medium backdrop-blur-sm"
                    >
                      {role}
                    </span>
                  ))}
                </div>
              </div>

              {/* Engineering Card */}
              <div className="rounded-2xl p-6 text-left shadow-lg transition-all duration-300 transform hover:-translate-y-1 hover:shadow-xl bg-gradient-to-br from-[#2563eb] to-[#1d4ed8]">
                <h2 className="text-2xl font-extrabold mb-3">
                  Engineering Industry
                </h2>
                <div className="flex flex-wrap gap-3 mt-3">
                  {["Mechanical Engineer", "Software Developer", "Architect"].map(
                    (role) => (
                      <span
                        key={role}
                        className="bg-white/20 px-4 py-1.5 rounded-full text-sm font-medium backdrop-blur-sm"
                      >
                        {role}
                      </span>
                    )
                  )}
                </div>
              </div>

              {/* Technology Card */}
              <div className="rounded-2xl p-6 text-left shadow-lg transition-all duration-300 transform hover:-translate-y-1 hover:shadow-xl bg-gradient-to-br from-[#10b981] to-[#059669]">
                <h2 className="text-2xl font-extrabold mb-3">
                  Technology & Innovation
                </h2>
                <div className="flex flex-wrap gap-3 mt-3">
                  {["AI Researcher", "Data Analyst", "Product Manager"].map(
                    (role) => (
                      <span
                        key={role}
                        className="bg-white/20 px-4 py-1.5 rounded-full text-sm font-medium backdrop-blur-sm"
                      >
                        {role}
                      </span>
                    )
                  )}
                </div>
              </div>
            </div>

            {/* ✅ Description */}
            <p className="text-gray-300 mt-8 text-sm leading-relaxed">
              In the next module we will further refine your choices, so we can
              determine roles which{" "}
              <span className="font-semibold text-white">
                actually match your personality.
              </span>
            </p>

            {/* ✅ Buttons */}
            <div className="mt-8 space-y-3">
              <button
                onClick={() => navigate("/qa-instructions")}
                className="w-full bg-[#0055FF] hover:bg-[#0042cc] text-white font-semibold py-3 rounded-xl transition duration-200"
              >
                Start Next Module
              </button>

              <button
                onClick={() => navigate("/role-selection")}
                className="w-full text-gray-400 hover:text-white text-sm font-medium"
              >
                Restart Role Selection
              </button>
            </div>
          </div>
        </main>

        {/* ✅ Footer */}
        <Footer />
      </div>
    </>
  );
}
