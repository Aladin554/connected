// Updated SelectedChallenges component with decreased card width, smaller tag text, white color, and adjusted spacing

import { useState, useEffect } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import api from "../../../api/axios";
import Header from "../Header";
import Footer from "../Footer";
import parse from "html-react-parser";

interface Industry {
  id: number;
  name: string;
  final_details?: string;
}

interface LocationState {
  selectedIds: number[];
}

export default function SelectedChallenges() {
  const navigate = useNavigate();
  const location = useLocation();
  const [userName, setUserName] = useState<string>("");
  const [profileName, setProfileUserName] = useState<string>("");
  const [selectedChallenges, setSelectedChallenges] = useState<Industry[]>([]);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    document.title = "Connected — Selected Challenges";
  }, []);

  useEffect(() => {
    const fetchUser = async () => {
      try {
        const res = await api.get("/profile");
        setUserName(`${res.data.last_name || ""}`);
      } catch (err) {
        console.error("Failed to fetch user:", err);
      }
    };
    fetchUser();
  }, []);

  useEffect(() => {
    const fetchUser = async () => {
      try {
        const res = await api.get("/profile");
        setProfileUserName(`${res.data.first_name || "User"} ${res.data.last_name || ""}`);
      } catch (err) {
        console.error("Failed to fetch user:", err);
      }
    };
    fetchUser();
  }, []);

  useEffect(() => {
    const selectedIds =
      (location.state as LocationState)?.selectedIds ||
      JSON.parse(localStorage.getItem("selectedChallenges") || "[]");

    if (!selectedIds.length) {
      navigate("/challenges");
      return;
    }

    fetchSelectedChallenges(selectedIds);
  }, [location.state]);

  const fetchSelectedChallenges = async (ids: number[]) => {
    try {
      setIsLoading(true);
      const res = await api.get("/industry");
      const all = res.data.data || res.data;

      const formatted = all.map((item: any) => ({
        id: item.id,
        name: item.name || item.title,
        final_details: item.final_details || "",
      }));

      const filtered = formatted.filter((cat: Industry) => ids.includes(cat.id));
      const ordered = ids
        .map((id) => filtered.find((c) => c.id === id))
        .filter(Boolean) as Industry[];

      setSelectedChallenges(ordered);
      localStorage.setItem("selectedChallenges", JSON.stringify(ids));
    } catch (err) {
      console.error("Failed to fetch selected challenges:", err);
    } finally {
      setIsLoading(false);
    }
  };

  const handleLogoutClick = () => {
    sessionStorage.clear();
  window.location.href = "/signin";
  };

  const handleWatchDemo = () => {
    alert("Watch Demo clicked! (Add video modal or redirect)");
  };

  const handleStartNext = () => {
    navigate("/phases-instructions", {
      state: { challengeIds: selectedChallenges.map((c) => c.id) },
    });
  };

  return (
    <>
      <link
        href="https://fonts.googleapis.com/css2?family=Abril+Fatface&family=Poppins:wght@400;500;600;700;800;900&display=swap"
        rel="stylesheet"
      />

      {isLoading ? (
        <div className="fixed inset-0 bg-[#080b3d] flex items-center justify-center z-50">
          <div className="flex flex-col items-center gap-3 text-white">
            <div className="w-8 h-8 border-4 border-white/20 border-t-green-400 rounded-full animate-spin"></div>
            <span className="text-sm text-white/70">Loading your passions...</span>
          </div>
        </div>
      ) : (
        <div className="min-h-screen flex flex-col bg-[#080b3d] text-white" style={{ fontFamily: "'Poppins', sans-serif" }}>
          <Header userName={profileName} onLogout={handleLogoutClick} />

           <main className="flex-1 flex flex-col items-center px-6 py-16 max-w-6xl mx-auto w-full">
            <div className="text-center mb-8 sm:mb-10 -mt-4">
              <h1 className="text-2xl sm:text-3xl md:text-4xl font-bold text-white mb-2 mt-7">
                Perfect {userName}! <span className="font-semibold">⭐</span>
              </h1>

              <p className="text-xs sm:text-sm md:text-base text-white max-w-3xl mx-auto flex flex-col sm:flex-row items-center justify-center gap-1">
                Looks like you are <span className="text-white font-bold">VERY interested</span> to solve challenges related to
                <span className="text-xl sm:text-2xl md:text-3xl mt-1 sm:mt-0">👇</span>
              </p>
            </div>

            <div className="w-full max-w-6xl mx-auto px-4 py-10">
  {/* Mobile: flex-col, Tablet+: horizontal scroll */}
  <div className="flex flex-col sm:flex-row sm:justify-center sm:gap-6 md:flex-nowrap md:overflow-x-auto pb-2 scrollbar-hide">
    {selectedChallenges.slice(0, 4).map((challenge, index) => (
      <div
        key={challenge.id}
        className="w-full sm:w-72 flex-shrink-0 bg-white/5 border-2 border-green-400 rounded-3xl p-5 flex flex-col backdrop-blur-xl shadow-md min-h-[220px] transition-all mx-auto sm:mx-0 mb-4 sm:mb-0"
      >
        {/* Card Header */}
        <div className="flex items-center justify-between mb-2 -mt-3">
          <span className="mt-2 text-lg sm:text-xl font-['Abril Fatface'] font-semibold text-white/90">
            0{index + 1}.
          </span>
          <span className="bg-green-400/20 text-white text-[9px] font-semibold px-2.5 py-0.5 rounded-full border border-green-400/40 -mt-1">
            Highly Interested
          </span>
        </div>

        {/* Card Title */}
        <div className="flex flex-col gap-2">
  <h3 className="text-base sm:text-lg md:text-xl font-semibold text-white">
    {challenge.name}
  </h3>

  <p className="text-xs sm:text-sm text-white/80 leading-relaxed">
    {challenge.final_details
      ? parse(challenge.final_details)
      : "You have shown interest to work in these industries."}
  </p>
</div>

      </div>
    ))}
  </div>
</div>



            <p className="text-center text-xs sm:text-sm md:text-base text-white mt-10 sm:mt-14 max-w-3xl mx-auto leading-relaxed">
              This is super exciting! We just got to learn which type of industries you care to work in.
              <br />
              <strong className="text-white">Next we will identify, which types of role you are passionate about.</strong>
            </p>

            <div className="mt-8 sm:mt-12 flex flex-col sm:flex-row gap-4 justify-center items-center w-full">
              {/* <button
                onClick={handleWatchDemo}
                className="w-full sm:w-auto bg-purple-500 hover:bg-purple-400 text-white font-bold py-3 px-7 rounded-full shadow-md hover:-translate-y-0.5 transition-all"
              >
                Watch Demo ▶️
              </button> */}
              <button
                onClick={handleStartNext}
                className="w-full sm:w-auto bg-blue-500 hover:bg-blue-400 text-white font-bold py-3 px-7 rounded-full shadow-md hover:-translate-y-0.5 transition-all"
              >
                Start Next Module 👉
              </button>
            </div>
          </main>

          <Footer />
        </div>
      )}
    </>
  );
}
