import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import api from "../../../api/axios";
import Header from "../Header";
import Footer from "../Footer";

interface WorkType {
  id: number;
  title: string;
  modal_title: string;
  modal_image?: string;
  modal_description?: string;
}

export default function Sort() {
  const [userName, setUserName] = useState<string>("");
  const [workTypes, setWorkTypes] = useState<WorkType[]>([]);
  const [currentIndex, setCurrentIndex] = useState<number>(0);
  const [selections, setSelections] = useState<
    { workTypeId: number; answer: "yes" | "maybe" }[]
  >([]);
  const [processing, setProcessing] = useState(false);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const navigate = useNavigate();
  const currentWork = workTypes[currentIndex];

  useEffect(() => {
    document.title = "Connected — Challenge Cards";

    // ✅ Prevent flash before data loads
    document.documentElement.style.backgroundColor = "#080b3d";
    document.body.style.backgroundColor = "#080b3d";
  }, []);

  useEffect(() => {
    const fetchUserAndData = async () => {
      try {
        const [userRes, workRes] = await Promise.all([
          api.get("/profile"),
          api.get("/categories"),
        ]);

        setUserName(`${userRes.data.first_name} ${userRes.data.last_name}`);

        const data: WorkType[] = workRes.data.data || workRes.data;
        const formatted = data.map((item) => ({
          ...item,
          modal_image: item.modal_image
            ? item.modal_image.startsWith("http")
              ? item.modal_image
              : `${import.meta.env.VITE_API_URL}/storage/${item.modal_image}`
            : undefined,
        }));
        setWorkTypes(formatted);
      } catch (err) {
        console.error("Failed to fetch data:", err);
      } finally {
        setIsLoading(false);
      }
    };

    fetchUserAndData();
  }, []);

  const handleAnswer = (answer: "yes" | "no" | "maybe") => {
    if (processing || !currentWork) return;
    setProcessing(true);

    const updatedSelections = [...selections];
    if (answer !== "no") {
      updatedSelections.push({ workTypeId: currentWork.id, answer });
    }

    setSelections(updatedSelections);
    localStorage.setItem("selectedWork", JSON.stringify(updatedSelections));

    setTimeout(() => {
      setProcessing(false);
      if (currentIndex + 1 < workTypes.length) {
        setCurrentIndex(currentIndex + 1);
      } else {
        navigate("/pick-top");
      }
    }, 500);
  };

  const progressPercent =
    workTypes.length > 0
      ? Math.floor((currentIndex / workTypes.length) * 100)
      : 0;

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
          @keyframes gradientMove {
            0% { background-position: 0% 50%; }
            100% { background-position: 100% 50%; }
          }
        `}
      </style>

      {/* ✅ Show loader while waiting for data */}
      {isLoading ? (
        <div className="fixed inset-0 bg-[#080b3d] flex items-center justify-center">
          <div className="flex flex-col items-center gap-3 text-white">
            <div className="w-8 h-8 border-4 border-white/30 border-t-[--accent] rounded-full animate-spin"></div>
            <span className="text-sm text-white/70">Loading...</span>
          </div>
        </div>
      ) : (
        <div
        className="text-white bg-[#080b3d] min-h-screen"
        style={{ fontFamily: "Poppins, sans-serif" }}
      >
        {/* Header */}
          <Header userName={userName} onLogout={handleLogoutClick} />

        {/* Main content */}
        <main className="min-h-[70vh] flex flex-col items-center relative px-6">
            {/* Challenge Card */}
            <section className="border border-white/40 p-6 sm:p-8 md:p-10 rounded-[2.75rem] bg-[linear-gradient(180deg,rgba(255,255,255,0.04),transparent)] min-h-[420px] sm:min-h-[480px] md:min-h-[420px] flex flex-col justify-between max-w-[320px] w-full relative transition-opacity duration-300 opacity-100 mt-2">
              {processing && (
                <div className="absolute inset-0 bg-black/50 flex items-center justify-center rounded-[2.75rem] text-white font-bold text-lg z-10">
                  Processing...
                </div>
              )}

              <div>
                <div className="flex items-start justify-between">
                  <div className="text-sky-300/80 text-base font-semibold">
                    Do you care to
                  </div>
                  <button
                    onClick={openModal}
                    className="w-7 h-7 rounded-full bg-[#a3dd2f] flex items-center justify-center shadow hover:scale-110 transition-transform focus:outline-none focus:ring-2 focus:ring-sky-300"
                    aria-label="Lamp Button"
                  >
                    <img
                      src="images/lamp.png"
                      alt="lamp icon"
                      className="w-4 h-4"
                    />
                  </button>
                </div>

                <h1
                  className="mt-5 text-xl leading-snug font-extrabold tracking-tight text-white"
                  dangerouslySetInnerHTML={{ __html: currentWork.title }}
                />
              </div>

              <div className="mt-8 flex justify-center">
                <div className="flex items-center gap-4">
                  <button
                    onClick={() => handleAnswer("maybe")}
                    className="flex items-center justify-center w-14 h-14 rounded-2xl border border-white/60 bg-white/5 text-white/80 text-xl font-bold hover:bg-white/10 transition-colors focus:outline-none focus:ring-2 focus:ring-sky-300"
                    aria-label="Maybe"
                  >
                    ?
                  </button>

                  <button
                    onClick={() => handleAnswer("no")}
                    className="flex items-center justify-center w-14 h-14 rounded-2xl border border-white/60 bg-white/5 hover:bg-white/10 transition-colors focus:outline-none focus:ring-2 focus:ring-red-500"
                    aria-label="No"
                  >
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      className="w-7 h-7 text-red-500"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth="3"
                        d="M6 18L18 6M6 6l12 12"
                      />
                    </svg>
                  </button>

                  <button
                    onClick={() => handleAnswer("yes")}
                    className="flex items-center justify-center w-14 h-14 rounded-2xl border border-white/60 bg-white/5 hover:bg-white/10 transition-colors focus:outline-none focus:ring-2 focus:ring-[--accent]"
                    aria-label="Yes"
                  >
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      className="w-7 h-7 text-[--accent]"
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
                  </button>
                </div>
              </div>
            </section>

            {/* Progress Bar */}
            <div className="mt-10 w-full max-w-xs mx-auto">
              <div className="flex items-center justify-between text-xs text-white/80 mb-2">
                <span className="font-semibold tracking-wide">Progress</span>
                <span className="font-semibold text-[--accent]">
                  {progressPercent}%
                </span>
              </div>

              <div className="w-full bg-white/20 rounded-full h-4 overflow-hidden shadow-inner relative">
                <div
                  className="h-full rounded-full transition-all duration-700 ease-out animate-pulse"
                  style={{
                    width: `${progressPercent}%`,
                    background:
                      "linear-gradient(270deg, var(--accent), #1cd3a2, #0ae2ff)",
                    backgroundSize: "300% 300%",
                    animation: "gradientMove 2s linear infinite",
                    boxShadow:
                      "0 0 8px rgba(24,224,138,0.6), 0 0 16px rgba(24,224,138,0.3)",
                  }}
                ></div>
              </div>

              <div className="text-center text-[10px] text-white/60 mt-2">
                {workTypes.length > 0
                  ? `Card ${currentIndex + 1} of ${workTypes.length}`
                  : "Loading cards..."}
              </div>
            </div>
          </main>

          <Footer />

          {isModalOpen && currentWork && (
            <div className="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center z-50">
              <div className="bg-white text-black rounded-3xl max-w-sm w-full p-6 relative shadow-xl overflow-y-auto max-h-[90vh]">
                <button
                  onClick={closeModal}
                  className="absolute top-3 right-3 w-8 h-8 flex items-center justify-center rounded-full hover:bg-gray-200"
                >
                  ✕
                </button>

                <div className="text-gray-500 text-base font-semibold">
                  Do you care to
                </div>
                <h3 className="text-2xl font-black leading-snug mt-1 text-black">
                  {currentWork.modal_title}
                </h3>

                {currentWork.modal_image && (
                  <img
                    src={currentWork.modal_image}
                    alt={currentWork.modal_title}
                    className="rounded-xl mt-4 w-full max-h-40 object-cover border border-gray-200"
                  />
                )}

                {currentWork.modal_description && (
                  <div
                    className="mt-3 text-sm leading-relaxed text-gray-700"
                    dangerouslySetInnerHTML={{
                      __html: currentWork.modal_description,
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
