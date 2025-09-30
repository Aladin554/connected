// src/pages/Dashboard/UserDashboard.tsx
import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import api from "../../api/axios"; // your axios instance

export default function UserDashboard() {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [userName, setUserName] = useState<string>(""); // store user name
  const navigate = useNavigate();

  // Set document title
  useEffect(() => {
    document.title = "Connected — Challenge Cards";
  }, []);

  // Fetch logged-in user's name
  useEffect(() => {
    const fetchUser = async () => {
      try {
        const res = await api.get("/profile"); // axios instance automatically attaches token
        setUserName(`${res.data.firstName} ${res.data.lastName}`);
      } catch (err) {
        console.error("Failed to fetch user:", err);
      }
    };

    fetchUser();
  }, []);

  const openModal = () => setIsModalOpen(true);
  const closeModal = () => setIsModalOpen(false);

  const handleProfileClick = () => {
    navigate("/profile"); // Navigate to profile page
  };

  const handleLogoutClick = () => {
    localStorage.removeItem("token"); // remove auth token
    sessionStorage.removeItem("token");
    navigate("/signin"); // redirect to login
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

      <div className="text-white bg-[#080b3d] min-h-screen" style={{ fontFamily: "Poppins, sans-serif" }}>
        {/* Header */}
        <header className="max-w-7xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between w-full">
            <div
              className="text-xl font-serif font-semibold tracking-tight"
              style={{ fontSize: "1.25rem", lineHeight: "1.75rem" }}
            >
              Connected.
            </div>
            <div className="flex items-center gap-4">
              <button
                onClick={handleProfileClick}
                className="inline-block bg-blue-500/90 px-3 py-1 rounded-full text-xs font-medium"
              >
                {userName || "Loading..."} {/* dynamic user name */}
              </button>
              <button
                onClick={handleLogoutClick}
                className="border border-white/30 px-3 py-1 rounded-full text-xs"
              >
                Logout
              </button>
            </div>
          </div>
          <div className="h-px bg-white/50 mt-4"></div>
        </header>

        {/* Main content */}
        <main className="min-h-[70vh] flex flex-col items-center relative px-6">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 mt-10 w-full max-w-[1020px]">
            {[...Array(3)].map((_, idx) => (
              <section
                key={idx}
                className="border border-white/40 p-6 sm:p-8 md:p-10 rounded-[2.75rem] bg-[linear-gradient(180deg,rgba(255,255,255,0.04),transparent)] min-h-[420px] sm:min-h-[480px] md:min-h-[420px] flex flex-col justify-between"
              >
                <div>
                  <div className="flex items-start justify-between">
                    <div className="text-sky-300/80 text-base font-semibold">Do you care to</div>
                    <button
                      onClick={openModal}
                      className="w-7 h-7 rounded-full bg-[#a3dd2f] flex items-center justify-center shadow hover:scale-110 transition-transform focus:outline-none focus:ring-2 focus:ring-sky-300"
                      aria-label="Lamp Button"
                    >
                      <img src="/lamp.png" alt="lamp icon" className="w-4 h-4" />
                    </button>
                  </div>

                  <h1 className="mt-5 text-xl leading-snug font-extrabold tracking-tight text-white">
                    Improve Public Health And Well-Being,
                    <span className="block text-[--accent]">
                      Provide Medical Care To Those In Need,
                    </span>
                    And Advance Medical Knowledge?
                  </h1>
                </div>

                <div className="mt-8 flex justify-center">
                  <div className="flex items-center gap-4">
                    <button
                      className="flex items-center justify-center w-14 h-14 rounded-2xl border border-white/60 bg-white/5 text-white/80 text-xl font-bold hover:bg-white/10 transition-colors focus:outline-none focus:ring-2 focus:ring-sky-300"
                      aria-label="Maybe"
                    >
                      ?
                    </button>
                    <button
                      className="flex items-center justify-center w-14 h-14 rounded-2xl border border-white/60 bg-white/5 hover:bg-white/10 transition-colors focus:outline-none focus:ring-2 focus:ring-red-500"
                      aria-label="No"
                    >
                      <svg xmlns="http://www.w3.org/2000/svg" className="w-7 h-7 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" d="M6 18L18 6M6 6l12 12" />
                      </svg>
                    </button>
                    <button
                      className="flex items-center justify-center w-14 h-14 rounded-2xl border border-white/60 bg-white/5 hover:bg-white/10 transition-colors focus:outline-none focus:ring-2 focus:ring-[--accent]"
                      aria-label="Yes"
                    >
                      <svg xmlns="http://www.w3.org/2000/svg" className="w-7 h-7 text-[--accent]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" d="M5 13l4 4L19 7" />
                      </svg>
                    </button>
                  </div>
                </div>
              </section>
            ))}
          </div>

          {/* Progress bar */}
          <div className="mt-6 w-full max-w-xs mx-auto">
            <div className="flex items-center justify-between text-xs text-white/80 mb-2">
              <div className="font-semibold">Progress</div>
              <div>30%</div>
            </div>
            <div className="w-full bg-white/20 rounded-full h-4 overflow-hidden">
              <div className="h-full rounded-full" style={{ width: "30%", background: "linear-gradient(90deg,var(--accent), #1cd3a2)" }}></div>
            </div>
          </div>

          {/* Action buttons */}
          <div className="mt-16 flex flex-col items-center space-y-5">
            <button className="px-6 py-3 rounded-full font-semibold text-white bg-blue-500/90 hover:bg-[#146ff5]/90 hover:scale-105 transition-transform shadow-lg">
              Sort the Cards again
            </button>
            <button className="px-8 py-3 rounded-full font-semibold text-white bg-gradient-to-r from-green-400 to-teal-500 hover:from-green-500 hover:to-teal-600 hover:scale-105 transition-transform shadow-lg">
              Download your profile
            </button>
            <a href="#" className="text-white-400 font-medium underline hover:text-white-200 transition">
              Email me the profile instead
            </a>
            <a href="#" className="text-white-400 font-medium underline hover:text-white-200 transition">
              I require an accessible PDF
            </a>
          </div>
        </main>

        {/* Footer */}
        <footer className="py-6 mt-16 border-t border-white/20">
          <div className="max-w-6xl mx-auto px-6 text-center">
            <div className="flex flex-col sm:flex-row items-center justify-center gap-4 sm:gap-6 mb-3">
              <a href="#" className="text-sm font-medium underline hover:text-gray-300 transition">
                Terms &amp; Conditions
              </a>
              <span className="hidden sm:inline">|</span>
              <a href="#" className="text-sm font-medium underline hover:text-gray-300 transition">
                Privacy Policy
              </a>
            </div>
            <div className="text-sm text-gray-400">© 2025. All rights reserved.</div>
          </div>
        </footer>

        {/* Modal */}
        {isModalOpen && (
          <div className="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center z-50">
            <div className="bg-white text-black rounded-3xl max-w-sm w-full p-6 relative shadow-xl overflow-y-auto max-h-[90vh]">
              <button
                onClick={closeModal}
                className="absolute top-3 right-3 w-8 h-8 flex items-center justify-center rounded-full hover:bg-gray-200"
              >
                ✕
              </button>

              <div className="text-gray-500 text-base font-semibold">Do you care to</div>
              <h3 className="text-2xl font-black leading-snug mt-1">Healthcare and <br /> Medicine Industry?</h3>

              <img src="/download.jpg" alt="Doctor" className="rounded-xl mt-4 w-full max-h-40 object-cover" />

              <div className="mt-3 text-sm leading-relaxed">
                <p>Your work will involve mitigating challenges such as:</p>
                <p className="mt-2">
                  <a href="#" className="text-blue-600 font-semibold hover:underline">Global Health Security</a><br />
                  <span className="text-gray-700">Strengthening health systems to prevent and respond to global health threats.</span>
                </p>
                <p className="mt-3">
                  <a href="#" className="text-blue-600 font-semibold hover:underline">Mental Health and Wellness Coaching</a><br />
                  <span className="text-gray-700">Providing support to enhance mental well-being and cope with life challenges.</span>
                </p>
              </div>
            </div>
          </div>
        )}
      </div>
    </>
  );
}
