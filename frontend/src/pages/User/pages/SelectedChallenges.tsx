// src/pages/Dashboard/SelectedChallenges.tsx
import { useState, useEffect } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import axios from "axios";
import Header from "../Header";
import Footer from "../Footer";

// Create an axios instance
const api = axios.create({
  baseURL: "/api",
});

api.interceptors.request.use(
  (config) => {
    const token = sessionStorage.getItem("token");
    if (token) config.headers.Authorization = `Bearer ${token}`;
    return config;
  },
  (error) => Promise.reject(error)
);

interface WorkType {
  id: number;
  title: string;
  modal_title?: string;
  modal_description?: string;
  modal_image?: string;
}

export default function SelectedChallenges() {
  const navigate = useNavigate();
  const location = useLocation();
  const [userName, setUserName] = useState<string>("");
  const [selectedChallenges, setSelectedChallenges] = useState<WorkType[]>([]);
  const [activeWork, setActiveWork] = useState<WorkType | null>(null);
  const [isLoading, setIsLoading] = useState(true); // ✅ Add loading state

  useEffect(() => {
    document.title = "Connected — Selected Challenges";
  }, []);

  // ✅ Fetch logged-in user
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

  // ✅ Load selected challenge IDs and fetch data
  useEffect(() => {
    const stored = location.state?.challenges || JSON.parse(localStorage.getItem("selectedChallenges") || "[]");
    if (stored.length) {
      fetchSelectedChallenges(stored);
    } else {
      navigate("/challenges");
    }
  }, [location.state]);

  const fetchSelectedChallenges = async (ids: number[]) => {
    try {
      setIsLoading(true); // ✅ start loading
      const res = await api.get("/categories");
      const allWorkTypes: WorkType[] = res.data.data || res.data;

      const formatted = allWorkTypes.map((item) => ({
        ...item,
        modal_image: item.modal_image
          ? item.modal_image.startsWith("http")
            ? item.modal_image
            : `${import.meta.env.VITE_API_URL}/storage/${item.modal_image}`
          : undefined,
      }));

      const filtered = formatted.filter((work) => ids.includes(work.id));
      setSelectedChallenges(filtered);
      localStorage.setItem("selectedChallenges", JSON.stringify(ids));
    } catch (err) {
      console.error("Failed to fetch selected challenges:", err);
    } finally {
      setIsLoading(false); // ✅ stop loading
    }
  };

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
       {/* ✅ Loading Overlay */}
      {isLoading && (
        <div className="fixed inset-0 bg-[#080b3d] flex items-center justify-center z-50">
          <div className="flex flex-col items-center gap-3 text-white">
            <div className="w-8 h-8 border-4 border-white/30 border-t-[--accent] rounded-full animate-spin"></div>
            <span className="text-sm text-white/70">Loading...</span>
          </div>
        </div>
      )}

      <div
        className="text-white bg-[#080b3d] min-h-screen"
        style={{ fontFamily: "Poppins, sans-serif" }}
      >
        {/* Header */}
        <Header userName={userName} onLogout={handleLogoutClick} />

        {/* Main */}
        <main className="flex-1 flex flex-col items-center px-4 sm:px-6 mt-6 w-full">
          <h2 className="text-2xl sm:text-3xl font-extrabold text-[--accent] mt-8 mb-6">
            Your Selected Challenges
          </h2>

          {selectedChallenges.length === 0 && !isLoading ? (
            <p className="text-gray-400 mt-6">No selected challenges found.</p>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 mt-4 w-full max-w-[1020px]">
              {selectedChallenges.map((work) => (
                <section
                  key={work.id}
                  onClick={() => navigate(`/phases-instructions`, { state: { work } })}
                  className="border border-white/40 p-6 sm:p-8 rounded-[2.5rem] bg-[linear-gradient(180deg,rgba(255,255,255,0.04),transparent)] min-h-[420px] flex flex-col justify-between hover:scale-105 transition-transform cursor-pointer"
                >
                  <div>
                    <div className="flex items-start justify-between">
                      <div className="text-sky-300/80 text-base font-semibold">
                        Do you care to
                      </div>
                      <button
                        onClick={(e) => {
                          e.stopPropagation();
                          setActiveWork(work);
                        }}
                        className="w-7 h-7 rounded-full bg-[#a3dd2f] flex items-center justify-center shadow hover:scale-110 transition-transform"
                        aria-label="Lamp Button"
                      >
                        <img src="/images/lamp.png" alt="lamp icon" className="w-4 h-4" />
                      </button>
                    </div>

                    <h1
                      className="mt-5 text-xl leading-snug font-extrabold tracking-tight text-white"
                      dangerouslySetInnerHTML={{ __html: work.title }}
                    />
                  </div>
                </section>
              ))}
            </div>
          )}
        </main>

        <Footer />

        {activeWork && (
          <div className="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center z-50">
            <div className="bg-white text-black rounded-3xl max-w-sm w-full p-6 relative shadow-xl overflow-y-auto max-h-[90vh]">
              <button
                onClick={() => setActiveWork(null)}
                className="absolute top-3 right-3 w-8 h-8 flex items-center justify-center rounded-full hover:bg-gray-200"
              >
                ✕
              </button>

              <div className="text-gray-500 text-base font-semibold">
                Do you care to
              </div>

              <h3
                className="text-2xl font-black leading-snug mt-1"
                dangerouslySetInnerHTML={{
                  __html: activeWork.modal_title || activeWork.title,
                }}
              />

              {activeWork.modal_image && (
                <img
                  src={activeWork.modal_image}
                  alt={activeWork.title}
                  className="rounded-xl mt-4 w-full max-h-40 object-cover border border-gray-200"
                />
              )}

              {activeWork.modal_description && (
                <div
                  className="mt-3 text-sm leading-relaxed text-gray-700"
                  dangerouslySetInnerHTML={{
                    __html: activeWork.modal_description,
                  }}
                />
              )}
            </div>
          </div>
        )}
      </div>
    </>
  );
}
