// src/pages/User/pages/Introduction.tsx
import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import Header from "../Header";
import Footer from "../Footer";

export default function Introduction() {
    const navigate = useNavigate();

    useEffect(() => {
        document.title = "Connected — Introduction";
    }, []);

    const handleLogout = () => {
        localStorage.removeItem("token");
        navigate("/signin");
    };

    const userName = "test user"; // replace with actual user if available

    return (
        <div
            className="min-h-screen text-white"
            style={{
                fontFamily: "Poppins, sans-serif",
                backgroundColor: "#080b3d",
            }}
        >
            {/* Header */}
            <Header userName={userName} onLogout={handleLogout} />

            {/* Introduction content */}
            <main className="flex-1 max-w-3xl mx-auto px-6 py-16 text-center">
                <h1 className="text-2xl md:text-3xl font-extrabold mb-8">
                    Introduction
                </h1>

                <div className="space-y-8">
                    <p className="text-lg text-white/90 leading-relaxed">
                        One of the best ways to prepare for your future is to
                        choose challenges that you want to work on.
                    </p>
                    <p className="text-lg text-white/90 leading-relaxed">
                        Through the Challenge Cards, you will select three
                        challenges that you want to explore.
                    </p>
                </div>

                {/* Buttons */}
                <div className="flex flex-col items-center justify-center gap-4 mt-12">
                    <button
                        onClick={() => navigate("/instructions")} // Navigate to your sorting page
                        className="px-6 py-3 rounded-full font-semibold text-white 
      bg-gradient-to-r from-[--accent] to-emerald-600 
      hover:from-emerald-400 hover:to-emerald-700 transition"
                    >
                        Next
                    </button>

                    <button
                        onClick={() => navigate("/user-dashboard")} // Back to dashboard
                        className="px-6 py-3 rounded-full font-semibold text-white/90 
      border border-white/40 hover:bg-white/10 transition"
                    >
                        ↩ Back to dashboard
                    </button>
                </div>
            </main>

            {/* Footer */}
            <Footer />

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
        </div>
    );
}
