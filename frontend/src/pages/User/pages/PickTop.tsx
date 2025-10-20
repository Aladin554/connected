// src/pages/Dashboard/UserDashboard.tsx
import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import api from "../../../api/axios";
import Header from "../Header";
import Footer from "../Footer";

export default function UserDashboard() {
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
        <main className="flex flex-col items-center justify-center text-center px-6 py-20 min-h-[70vh]">
          <h1 className="text-2xl sm:text-3xl font-extrabold mb-4">Nice job! ⭐️</h1>
          <p className="text-lg text-gray-300 max-w-2xl">
            Now, take a look at the Challenges you liked the most and pick your top 3.
          </p>
          <button
            onClick={() => navigate("/sort-three-challenge-card")}
            className="mt-8 bg-[var(--accent)] text-black font-semibold px-8 py-3 rounded-full shadow-lg hover:bg-green-400 transition transform hover:scale-105"
          >
            Pick Your Top 3 Challenges
          </button>
        </main>

        {/* Footer */}
        <Footer />
      </div>
    </>
  );
}
