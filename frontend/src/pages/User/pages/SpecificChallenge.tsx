// src/pages/User/pages/SpecificChallenge.tsx
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../../../api/axios"; // adjust path if needed
import Header from "../Header";
import Footer from "../Footer";

export default function SpecificChallenge() {
  const navigate = useNavigate();
  const [userName, setUserName] = useState<string>("");

  // ✅ Fetch logged-in user's name
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

  // ✅ Handle logout
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

        {/* ✅ Main Content */}
        <main className="flex-grow flex items-center justify-center p-4">
          <div className="w-full max-w-md md:max-w-3xl lg:max-w-5xl bg-gradient-to-b from-[#0c1040] to-[#070a2f] border border-gray-700 rounded-xl shadow-xl overflow-hidden flex flex-col justify-between p-5 md:p-6 lg:p-8 transition-all duration-300 text-white">
            <div className="relative">
              {/* Heading */}
              <h1 className="text-3xl sm:text-4xl lg:text-5xl font-extrabold tracking-tight leading-tight mb-1">
                Alright{" "}
                <span className="inline-block text-[#18e08a]">
                  {userName ? userName.split(" ")[0] : "User"}
                  <span className="text-white">!</span>
                </span>
              </h1>

              <p className="mt-2 text-sm lg:text-base text-gray-300 leading-relaxed mb-2">
                Now that we know what type of work you find purpose in, it's
                time for the{" "}
                <span className="font-semibold text-white">exciting part!</span>
              </p>

              <hr className="my-2 border-t border-gray-600" />

              {/* Instructions */}
              <div className="relative">
                <div className="flex items-center justify-between">
                  <div className="text-lg font-semibold text-white">Instructions</div>
                </div>
                <div className="absolute top-[-.1rem] right-[2rem] text-3xl text-gray-400 rotate-45">
                  ➜
                </div>
              </div>

              <hr className="my-2 border-t border-gray-600" />

              <p className="mt-2 text-sm text-gray-300">
                In the next step we will ask you questions in{" "}
                <span className="font-semibold text-white">two phases</span>.
              </p>

              {/* Timeline */}
              <div className="mt-3 relative pl-8">
                {/* vertical line */}
                <div className="absolute left-4 top-2 bottom-[130px] lg:bottom-[60px] w-0.5 bg-gray-500"></div>

                {/* First Phase */}
                <div className="relative mb-3">
                  <div className="absolute left-[-1.5rem] top-0 w-4 h-4 rounded-full bg-[#18e08a] shadow"></div>
                  <div className="ml-1">
                    <div className="text-base font-semibold text-white">
                      First Phase
                    </div>
                    <p className="mt-1 text-sm text-gray-300 leading-relaxed">
                      We will identify whether you care to work in any specific
                      roles{" "}
                      <span className="font-semibold text-white">
                        directly related to your chosen industry
                      </span>
                      . For example, working as a doctor in the healthcare industry.
                    </p>
                  </div>
                </div>

                {/* Second Phase */}
                <div className="relative">
                  <div className="absolute left-[-1.5rem] top-0 w-4 h-4 rounded-full bg-[#18e08a] shadow"></div>
                  <div>
                    <div className="text-base font-semibold text-white">
                      Second Phase
                    </div>
                    <p className="mt-1 text-sm text-gray-300 leading-relaxed">
                      We will identify whether you have any interest to work in{" "}
                      <span className="font-semibold text-white">
                        roles which are available in almost any industries
                      </span>
                      . For example, a sales role exists in almost any industry.
                    </p>
                  </div>
                </div>
              </div>
            </div>

            {/* Bottom Section */}
            <div className="bg-gradient-to-r from-[#0b0f3d] via-[#10143f] to-[#0c1040] text-white rounded-t-3xl p-4 mt-6 shadow-inner border-t border-gray-700">
              <div className="text-center">
                <h2
                  className="text-lg sm:text-xl font-extrabold"
                  style={{ color: "var(--accent)" }}
                >
                  Discover Yourself..
                </h2>
                <p className="mt-1 text-xs sm:text-sm text-gray-300 leading-relaxed">
                  This step is{" "}
                  <span className="font-semibold text-white">crucial</span> for your
                  success because now we are looking to explore{" "}
                  <span className="font-semibold text-white">
                    what type of role you’d like to take on
                  </span>{" "}
                  to help solve the challenge you care about!
                </p>

                <button
                  onClick={() => navigate("/first-phases")}
                  className="mt-3 inline-block w-full py-2.5 rounded-lg text-base font-semibold shadow-lg transition-transform hover:scale-[1.02]"
                  style={{
                    background: "linear-gradient(90deg, var(--accent), #b9ff2f)",
                    color: "#0b0b0b",
                  }}
                >
                  Launch Module ➜
                </button>
              </div>
            </div>
          </div>
        </main>

        {/* ✅ Updated Footer */}
        <Footer />
      </div>
    </>
  );
}
