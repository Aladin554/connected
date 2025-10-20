// src/pages/Dashboard/UserDashboard.tsx
import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import api from "../../api/axios";
import Header from "../User/Header";
import Footer from "../User/Footer";

export default function UserDashboard() {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [userName, setUserName] = useState<string>("");
  const navigate = useNavigate();

  // Set document title
  useEffect(() => {
    document.title = "Connected — Challenge Cards";
  }, []);

  // Fetch logged-in user's name
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

  const openModal = () => setIsModalOpen(true);
  const closeModal = () => setIsModalOpen(false);

  const handleLogoutClick = () => {
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
        <Header userName={userName} onLogout={handleLogoutClick} />

        {/* Main content */}
        <main className="min-h-[70vh] flex flex-col items-center relative px-6">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-1 gap-8 mt-10 max-w-[320px]">
            {[...Array(1)].map((_, idx) => (
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
                      <img src="images/lamp.png" alt="lamp icon" className="w-4 h-4" />
                    </button>
                  </div>

                  <h1 className="mt-5 text-xl leading-snug font-extrabold tracking-tight text-white">
                    Software
                    <span className="block text-[--accent]">
                      Builds apps, websites, and systems.
                    </span>
                    Coding (Python, JavaScript), problem-solving, teamwork.
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

          {/* Action buttons */}
          <div className="mt-16 flex flex-col items-center space-y-5">
            <button
              onClick={() => navigate("/introduction")}
              className="px-6 py-3 rounded-full font-semibold text-white bg-blue-500/90 hover:bg-[#146ff5]/90 hover:scale-105 transition-transform shadow-lg"
            >
              Sort the Cards again
            </button>

            <button className="px-8 py-3 rounded-full font-semibold text-white bg-gradient-to-r from-green-400 to-teal-500 hover:from-green-500 hover:to-teal-600 hover:scale-105 transition-transform shadow-lg">
              Download your profile
            </button>

            <a
              href="#"
              className="text-white-400 font-medium underline hover:text-white-200 transition"
            >
              Email me the profile instead
            </a>
            <a
              href="#"
              className="text-white-400 font-medium underline hover:text-white-200 transition"
            >
              I require an accessible PDF
            </a>
          </div>
        </main>

        {/* Footer */}
        <Footer />

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
              <h3 className="text-2xl font-black leading-snug mt-1">
                Healthcare and <br /> Medicine Industry?
              </h3>

              <img
                src="images/download.jpg"
                alt="Doctor"
                className="rounded-xl mt-4 w-full max-h-40 object-cover"
              />

              <div className="mt-3 text-sm leading-relaxed">
                <p>Your work will involve mitigating challenges such as:</p>
                <p className="mt-2">
                  <a
                    href="#"
                    className="text-blue-600 font-semibold hover:underline"
                  >
                    Global Health Security
                  </a>
                  <br />
                  <span className="text-gray-700">
                    Strengthening health systems to prevent and respond to global health
                    threats.
                  </span>
                </p>
                <p className="mt-3">
                  <a
                    href="#"
                    className="text-blue-600 font-semibold hover:underline"
                  >
                    Mental Health and Wellness Coaching
                  </a>
                  <br />
                  <span className="text-gray-700">
                    Providing support to enhance mental well-being and cope with life
                    challenges.
                  </span>
                </p>
              </div>
            </div>
          </div>
        )}
      </div>
    </>
  );
}
