import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import api from "../../../api/axios";
import Header from "../Header";
import Footer from "../Footer";
import parse from "html-react-parser";

interface WorkType {
  id: number;
  title: string;
  modal_title?: string;
  modal_description?: string;
  modal_image?: string;
}

interface StoredWork {
  workTypeId: number;
  answer: "yes" | "maybe";
}

export default function ChallengeCards() {
  const navigate = useNavigate();
  const [workTypes, setWorkTypes] = useState<WorkType[]>([]);
  const [selected, setSelected] = useState<number[]>([]);
  const [userName, setUserName] = useState<string>("");
  const [activeWork, setActiveWork] = useState<WorkType | null>(null);
  const [isLoading, setIsLoading] = useState(true); // ✅ Loading state

  // ✅ Set page title
  useEffect(() => {
    document.title = "Connected — Challenge Cards";
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

  // ✅ Fetch and filter work types
  useEffect(() => {
    const fetchWorkTypes = async () => {
      try {
        const res = await api.get("/categories");
        const data: WorkType[] = Array.isArray(res.data.data)
          ? res.data.data
          : res.data;

        const formatted: WorkType[] = data.map((item) => ({
          ...item,
          modal_image: item.modal_image
            ? item.modal_image.startsWith("http")
              ? item.modal_image
              : `${import.meta.env.VITE_API_URL}/storage/${item.modal_image}`
            : undefined,
        }));

        const storedRaw = localStorage.getItem("selectedWork");
        const stored: StoredWork[] = storedRaw ? JSON.parse(storedRaw) : [];

        const yesIds = stored
          .filter((w: StoredWork) => w.answer === "yes")
          .map((w: StoredWork) => w.workTypeId);

        const filtered = formatted.filter((w) => yesIds.includes(w.id));
        setWorkTypes(filtered);
      } catch (err) {
        console.error("Failed to fetch work types:", err);
      } finally {
        setIsLoading(false); // ✅ Stop loading after fetch
      }
    };

    fetchWorkTypes();
  }, []);

  // ✅ Logout
  const handleLogoutClick = () => {
    localStorage.removeItem("token");
    sessionStorage.removeItem("token");
    navigate("/signin");
  };

  // ✅ Select/Unselect challenge (max 3)
  const handleSelect = (id: number) => {
    setSelected((prev) => {
      if (prev.includes(id)) {
        return prev.filter((s) => s !== id);
      } else if (prev.length < 3) {
        return [...prev, id];
      } else {
        alert("You can only select up to 3 challenges!");
        return prev;
      }
    });
  };

  // ✅ Confirm
  const handleConfirm = () => {
    if (selected.length === 3) {
      navigate("/selected-three-challenge-card", { state: { challenges: selected } });
    } else {
      alert("Please select exactly 3 challenges.");
    }
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

      {isLoading ? (
        // ✅ Loading overlay
        <div className="fixed inset-0 bg-[#080b3d] flex items-center justify-center z-50">
          <div className="flex flex-col items-center gap-3 text-white">
            <div className="w-8 h-8 border-4 border-white/30 border-t-[--accent] rounded-full animate-spin"></div>
            <span className="text-sm text-white/70">Loading challenges...</span>
          </div>
        </div>
      ) : (
        <div
          className="text-white bg-[#080b3d] min-h-screen"
          style={{ fontFamily: "Poppins, sans-serif" }}
        >
          {/* Header */}
          <Header userName={userName} onLogout={handleLogoutClick} />

          {/* Main */}
          <main className="flex-1 flex flex-col items-center px-4 sm:px-6 mt-6 w-full">
            <h2 className="text-xl sm:text-3xl font-extrabold tracking-tight text-center text-[--accent]">
              Pick Your Top 3
            </h2>

            {/* Cards Grid */}
            {workTypes.length === 0 ? (
              <p className="text-gray-400 mt-10">No challenges found.</p>
            ) : (
              <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-5 gap-5 sm:gap-6 mt-10 max-w-7xl w-full justify-center">
                {workTypes.map((work) => {
                  const isSelected = selected.includes(work.id);
                  return (
                    <section
                      key={work.id}
                      className={`border p-4 rounded-2xl flex flex-col justify-between hover:scale-105 transition-transform duration-300
                        w-full max-w-[180px] sm:max-w-[225px] min-h-[268px] sm:min-h-[300px] lg:min-h-[330px]
                        ${
                          isSelected
                            ? "border-[var(--accent)] bg-[rgba(24,224,138,0.1)] shadow-[0_0_15px_rgba(24,224,138,0.3)]"
                            : "border-white/30 bg-[linear-gradient(180deg,rgba(255,255,255,0.03),transparent)]"
                        }`}
                    >

                      <div>
                        <div className="flex items-start justify-between">
                          <div className="text-sky-300/70 text-xs font-semibold">
                            Do you care to
                          </div>
                          <button
                            onClick={() => setActiveWork(work)}
                            className="w-6 h-6 rounded-full bg-[#a3dd2f] flex items-center justify-center shadow hover:scale-110 transition-transform"
                          >
                            <img
                              src="/images/lamp.png"
                              alt="lamp icon"
                              className="w-3 h-3"
                            />
                          </button>
                        </div>

                        <div
                          className="
                            mt-3 
                            leading-snug 
                            font-bold 
                            tracking-tight
                            [&_h1]:text-[14px]     
                            sm:[&_h1]:text-[16px]  
                            md:[&_h1]:text-[18px]  
                            lg:[&_h1]:text-[19px]  
                            [&_h1]:leading-[1.5rem]
                          "
                        >
                          {parse(work.title)}
                        </div>
                      </div>

                      <div className="mt-4 flex justify-center">
                        <button
                          onClick={() => handleSelect(work.id)}
                          className={`px-3 py-1.5 rounded-xl border text-xs font-bold transition
                            ${
                              isSelected
                                ? "bg-[var(--accent)] text-black border-[var(--accent)]"
                                : "bg-white/5 text-white/80 border-white/50 hover:bg-white/10"
                            }`}
                        >
                          {isSelected ? "Selected" : "Select"}
                        </button>
                      </div>
                    </section>
                  );
                })}
              </div>
            )}

            {/* Confirm Button */}
            <div className="mt-10 mb-16">
              <button
                disabled={selected.length !== 3}
                onClick={handleConfirm}
                className={`flex items-center justify-center gap-2 px-6 py-2.5 rounded-full text-sm sm:text-base font-bold transition
                  ${
                    selected.length === 3
                      ? "bg-[--accent] hover:bg-[#1cd3a2] text-black"
                      : "bg-gray-500 cursor-not-allowed text-black"
                  }`}
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  className="w-5 h-5"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth="3"
                    d="M5 13l4 4L19 7"
                  />
                </svg>
                Confirm
              </button>
            </div>
          </main>

          <Footer />

          {/* Modal */}
          {activeWork && (
            <div className="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center z-50">
              <div className="bg-white text-black rounded-3xl max-w-sm w-full p-6 relative shadow-xl overflow-y-auto max-h-[90vh]">
                <button
                  onClick={() => setActiveWork(null)}
                  className="absolute top-3 right-3 w-8 h-8 flex items-center justify-center rounded-full hover:bg-gray-200"
                >
                  ✕
                </button>

                <div className="text-gray-500 text-sm font-semibold">
                  Do you care to
                </div>

                <h3
                  className="text-xl font-black leading-snug mt-1"
                  dangerouslySetInnerHTML={{
                    __html: activeWork.modal_title || activeWork.title,
                  }}
                />

                {activeWork.modal_image && (
                  <img
                    src={activeWork.modal_image}
                    alt={activeWork.title}
                    className="rounded-xl mt-4 w-full max-h-44 object-cover border border-gray-200"
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
      )}
    </>
  );
}
