// src/pages/User/pages/OneSpecificChallenge.tsx
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../../../api/axios";
import Header from "../Header";
import Footer from "../Footer";

export default function OneSpecificChallenge() {
  const navigate = useNavigate();
  const [userName, setUserName] = useState<string>("");

  // ✅ Fetch user name
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

  // ✅ Logout
  const handleLogout = () => {
    localStorage.removeItem("token");
    sessionStorage.removeItem("token");
    navigate("/signin");
  };

  // ✅ Accordion state (first open by default)
  const [openSections, setOpenSections] = useState<{ [key: number]: boolean }>({
    0: true, // first section open
  });

  const toggleSection = (index: number) => {
    setOpenSections((prev) => ({
      ...prev,
      [index]: !prev[index],
    }));
  };

  // ✅ Role data
  const roles = [
    {
      title: "Patient Care Services",
      description: `Deliver direct medical care and support to patients through various healthcare services, including emergency, surgical, and rehabilitative care.`,
      details: `Provide direct patient care, diagnose medical conditions, and develop treatment plans to improve patient health outcomes.`,
    },
    {
      title: "Nurse",
      description: `Support physicians and patients through clinical care, medication administration, and ongoing patient education.`,
      details: `Nurses play a key role in monitoring patient progress, ensuring treatment adherence, and improving healthcare outcomes.`,
    },
    {
      title: "Pharmacist",
      description: `Prepare and dispense medications, provide advice on drug interactions, and promote safe use of prescriptions.`,
      details: `Pharmacists work closely with healthcare providers to ensure optimal medication therapy and patient safety.`,
    },
    {
      title: "Therapist",
      description: `Provide mental, physical, or occupational therapy to patients to improve health and functionality.`,
      details: `Therapists help patients recover and enhance their quality of life through personalized treatment programs.`,
    },
  ];

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
          <div
            className="w-full max-w-5xl rounded-2xl shadow-2xl text-white p-4 md:p-6 border border-white/10 transition-all duration-300"
            style={{
              background:
                "linear-gradient(180deg, rgba(20,25,70,0.9) 0%, rgba(10,12,50,0.9) 50%, rgba(8,11,45,0.95) 100%)",
            }}
          >
            <h1 className="text-2xl lg:text-3xl font-extrabold mb-1">
              Let’s Start!
            </h1>

            <p className="text-gray-300 mb-3 text-sm lg:text-sm leading-relaxed">
              First we will identify whether you care to work in any specific
              roles{" "}
              <span className="font-semibold text-white">directly related</span>{" "}
              to your chosen fields:
            </p>

            {/* Progress Bar */}
            <div className="flex items-center gap-1.5 mb-4">
              <div className="h-1 w-1/4 bg-lime-500 rounded"></div>
              <div className="h-1 w-1/4 bg-gray-600 rounded"></div>
              <div className="h-1 w-1/4 bg-gray-600 rounded"></div>
              <div className="h-1 w-1/4 bg-gray-600 rounded"></div>
            </div>

            <span className="text-xs uppercase bg-gray-700 px-2 py-0.5 rounded-full text-gray-200">
              Industry
            </span>
            <h2 className="text-lg lg:text-xl font-bold mt-1 mb-2">
              <span className="text-orange-500">Healthcare</span>{" "}
              <span className="text-orange-300">&amp; Medicine</span>
            </h2>

            <p className="text-gray-300 mb-3 text-sm lg:text-sm">
              From the following roles select the ones you feel{" "}
              <span className="font-semibold text-white">
                most passionate about.
              </span>
            </p>

            {/* ✅ Roles Section */}
            <div className="space-y-2">
              {roles.map((role, i) => (
                <div
                  key={i}
                  className="bg-gradient-to-r from-[#0b0e3d] via-[#10153f] to-[#0b0e3d] border border-gray-700 rounded-xl shadow-inner transition-all duration-300"
                >
                  <div
                    onClick={() => toggleSection(i)}
                    className="flex items-center justify-between px-3 py-2 cursor-pointer select-none"
                  >
                    <p
                      className={`font-semibold text-md ${
                        openSections[i] ? "text-lime-400" : "text-white"
                      }`}
                    >
                      {openSections[i] ? "– " : "+ "}
                      {role.title}
                    </p>
                    <input
                      type="checkbox"
                      onClick={(e) => e.stopPropagation()} // Prevent toggle when clicking checkbox
                      className="appearance-none w-4 h-4 border-2 border-lime-400 rounded-full checked:bg-lime-400 checked:border-lime-400 transition duration-200 cursor-pointer"
                    />
                  </div>

                  {openSections[i] && (
                    <div className="px-4 pb-3 text-sm text-gray-300">
                      <p className="leading-snug mb-1">{role.description}</p>
                      <p className="leading-snug">
                        <span className="font-semibold text-white">
                          Details:
                        </span>{" "}
                        {role.details}
                      </p>
                    </div>
                  )}
                </div>
              ))}
            </div>

            {/* ✅ Next Button */}
            <button
              onClick={() => navigate("/secound-phases")}
              className="w-full mt-5 bg-lime-400 hover:bg-lime-500 text-black font-semibold py-2 rounded-xl text-base flex items-center justify-center gap-2 transition-all duration-200"
            >
              Next <span className="text-lg">→</span>
            </button>
          </div>
        </main>

        {/* ✅ Footer */}
        <Footer />
      </div>
    </>
  );
}
