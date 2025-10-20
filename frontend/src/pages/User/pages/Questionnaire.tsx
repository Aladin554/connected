// src/components/Questionnaire.tsx
import { useState } from "react";
import { useNavigate } from "react-router-dom";
import Header from "../Header";
import Footer from "../Footer";

export default function Questionnaire() {
  const navigate = useNavigate();
  const [selected, setSelected] = useState<{ [key: number]: number | null }>({
    1: null,
    2: null,
  });

  const handleSelect = (question: number, option: number) => {
    setSelected((prev) => ({ ...prev, [question]: option }));
  };

  const handleSubmit = () => {
    // Example navigation or logic
    alert("✅ Your answers have been submitted!");
    navigate("/next"); // Change path if needed
  };

  const userName = "John Doe";

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

        {/* ✅ Main */}
        <main className="flex-1 flex justify-center items-start px-4 py-6">
          <div className="w-full max-w-3xl space-y-10 mt-6">
            {/* Question 1 */}
            <div className="bg-gradient-to-r from-[#0b0e3d] via-[#10153f] to-[#0b0e3d] p-6 rounded-xl shadow-inner border border-gray-700">
              <p className="text-sm text-gray-400 mb-2">Question 01.</p>
              <h2 className="text-2xl font-bold mb-4">
                Importance of High Salary
              </h2>
              <p className="text-gray-300 mb-6">
                Is receiving a high salary extremely important for your job
                satisfaction? For example, would you prefer a career that offers
                a higher salary over one that provides an average household
                income?
              </p>
              <div className="flex flex-col gap-4">
                <button
                  className={`rounded-lg py-3 px-4 font-semibold transition-colors duration-200 ${
                    selected[1] === 1
                      ? "bg-lime-400 text-black"
                      : "bg-gray-800 text-gray-200 hover:bg-gray-700"
                  }`}
                  onClick={() => handleSelect(1, 1)}
                >
                  Yes, I am highly money motivated.
                </button>
                <button
                  className={`rounded-lg py-3 px-4 font-semibold transition-colors duration-200 ${
                    selected[1] === 2
                      ? "bg-lime-400 text-black"
                      : "bg-gray-800 text-gray-200 hover:bg-gray-700"
                  }`}
                  onClick={() => handleSelect(1, 2)}
                >
                  Gosh no! I will still be happy with an average income if I
                  like my job.
                </button>
              </div>
            </div>

            {/* Question 2 */}
            <div className="bg-gradient-to-r from-[#0b0e3d] via-[#10153f] to-[#0b0e3d] p-6 rounded-xl shadow-inner border border-gray-700">
              <p className="text-sm text-gray-400 mb-2">Question 02.</p>
              <h2 className="text-2xl font-bold mb-4">
                Importance of Job Security
              </h2>
              <p className="text-gray-300 mb-6">
                Is long term job security a crucial factor for you to pursue a
                career?
              </p>
              <div className="flex flex-col gap-4">
                <button
                  className={`rounded-lg py-3 px-4 font-semibold transition-colors duration-200 ${
                    selected[2] === 1
                      ? "bg-lime-400 text-black"
                      : "bg-gray-800 text-gray-200 hover:bg-gray-700"
                  }`}
                  onClick={() => handleSelect(2, 1)}
                >
                  Yes, it’s important for me to feel stable and secure.
                </button>
                <button
                  className={`rounded-lg py-3 px-4 font-semibold transition-colors duration-200 ${
                    selected[2] === 2
                      ? "bg-lime-400 text-black"
                      : "bg-gray-800 text-gray-200 hover:bg-gray-700"
                  }`}
                  onClick={() => handleSelect(2, 2)}
                >
                  Not really, I prefer dynamic and changing opportunities.
                </button>
              </div>
            </div>

            {/* ✅ Timer and Submit Section */}
            <div className="flex flex-col items-center text-center space-y-4 mt-8">
              <div className="bg-blue-600 rounded-lg py-4 px-6 w-full max-w-md shadow-md">
                <p className="text-2xl font-bold tracking-wider">05 : 03</p>
                <p className="text-sm text-blue-100 mt-1">
                  Urgency = Clarity! ⏳🌟 Let's do this!
                </p>
              </div>

              <button
                onClick={handleSubmit}
                className="mt-4 bg-lime-400 hover:bg-lime-500 text-black font-bold py-3 px-8 rounded-lg shadow-md transition-all duration-200"
              >
                Submit
              </button>
            </div>
          </div>
        </main>

        {/* Footer */}
        <Footer />
      </div>
    </>
  );
}
