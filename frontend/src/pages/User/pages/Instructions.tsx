import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import Header from "../Header";
import Footer from "../Footer";

export default function Instructions() {
  const navigate = useNavigate();
  useEffect(() => {
    document.title = "Connected — Instructions";
  }, []);
  return (
    <div className="text-white min-h-screen bg-[#080b3d]" style={{ fontFamily: "Poppins, sans-serif" }}>
      {/* Header */}
      <Header userName="test user" onLogout={() => navigate("/signin")} />

      {/* Main content */}
      <main className="max-w-3xl mx-auto px-6 py-16 text-center">
        <h1 className="text-2xl md:text-3xl font-extrabold mb-8">Instructions</h1>

        <div className="space-y-8">
          <p className="text-lg text-white/90 leading-relaxed">
            Your first step is to sort 56 challenges based on your preferences.
          </p>
          <p className="text-lg text-white/90 leading-relaxed">
            For each card, click on the button "Not Interested," "Interested" or "Very Interested."
          </p>
        </div>

        {/* Buttons for choices */}
        <div className="mt-8">
          <div className="flex items-center justify-center gap-4">
            <button className="flex items-center justify-center w-14 h-14 rounded-2xl border border-white/60 bg-white/5 text-white/80 text-xl font-bold hover:bg-white/10 transition">
              ?
            </button>
            <button className="flex items-center justify-center w-14 h-14 rounded-2xl border border-white/60 bg-white/5 hover:bg-white/10 transition">
              <svg xmlns="http://www.w3.org/2000/svg" className="w-7 h-7 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
            <button className="flex items-center justify-center w-14 h-14 rounded-2xl border border-white/60 bg-white/5 hover:bg-white/10 transition">
              <svg xmlns="http://www.w3.org/2000/svg" className="w-7 h-7 text-[--accent]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" d="M5 13l4 4L19 7" />
              </svg>
            </button>
          </div>
        </div>

        <div className="space-y-8 mt-8">
          <p className="text-lg text-white/90 leading-relaxed">
            Once one of the three buttons are pressed, the next challenge card will automatically load into the screen.
          </p>
        </div>

        {/* Navigation buttons */}
        <div className="flex flex-col items-center justify-center gap-4 mt-12">
          <button
            onClick={() => navigate("/tip")} // update route to your next page
            className="px-6 py-3 rounded-full font-semibold text-white 
                       bg-gradient-to-r from-[--accent] to-emerald-600 
                       hover:from-emerald-400 hover:to-emerald-700 transition"
          >
            Next
          </button>

          <button
            onClick={() => navigate("/introduction")}
            className="px-6 py-3 rounded-full font-semibold text-white/90 
                       border border-white/40 hover:bg-white/10 transition"
          >
            ↩ Back to intro
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
