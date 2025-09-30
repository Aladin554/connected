import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../../api/axios"; // your axios instance

interface User {
  firstName: string;
  lastName: string;
  email: string;
  password?: string;
}

export default function EditProfile() {
  const [form, setForm] = useState<User>({
    firstName: "",
    lastName: "",
    email: "",
    password: "",
  });

  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  // Fetch profile details on mount
  useEffect(() => {
  const fetchProfile = async () => {
    try {
      // Get token from localStorage or sessionStorage
      const token = sessionStorage.getItem("token");
      if (!token) {
        console.warn("No token found, cannot fetch profile");
        return;
      }

      // Make API request using axios instance
      const res = await api.get("/profile", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      console.log("Profile data received:", res.data); // Debug log

      // Update form state
      setForm({
        firstName: res.data.firstName || "",
        lastName: res.data.lastName || "",
        email: res.data.email || "",
        password: "", // leave blank
      });
    } catch (err: any) {
      // More detailed error logging
      if (err.response) {
        console.error("Server responded with error:", err.response.status, err.response.data);
      } else if (err.request) {
        console.error("No response received:", err.request);
      } else {
        console.error("Error setting up request:", err.message);
      }
    }
  };

  fetchProfile();
}, []);


  // Handle form input
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  // Save profile
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    try {
      const token =
        sessionStorage.getItem("token");

      const payload = { ...form };
      if (!payload.password) {
        delete payload.password; // do not send empty password
      }

      await api.put("/profile", payload, {
        headers: { Authorization: `Bearer ${token}` },
      });

      alert("Profile updated successfully!");
      navigate("/dashboard"); // redirect back after save
    } catch (err) {
      console.error("Profile update failed:", err);
      alert("Failed to update profile");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#080b3d] text-white flex items-center justify-center px-6">
      <div className="w-full max-w-md bg-white/10 p-8 rounded-3xl shadow-xl">
        <h1 className="text-2xl font-bold mb-6 text-center">Edit Profile</h1>

        <form onSubmit={handleSubmit} className="space-y-5">
          <div>
            <label className="block mb-1 text-sm">First Name</label>
            <input
              type="text"
              name="firstName"
              value={form.firstName}
              onChange={handleChange}
              className="w-full px-4 py-2 rounded-lg bg-white/20 focus:bg-white/30 outline-none"
              required
            />
          </div>

          <div>
            <label className="block mb-1 text-sm">Last Name</label>
            <input
              type="text"
              name="lastName"
              value={form.lastName}
              onChange={handleChange}
              className="w-full px-4 py-2 rounded-lg bg-white/20 focus:bg-white/30 outline-none"
              required
            />
          </div>

          <div>
            <label className="block mb-1 text-sm">Email</label>
            <input
              type="email"
              name="email"
              value={form.email}
              onChange={handleChange}
              className="w-full px-4 py-2 rounded-lg bg-white/20 focus:bg-white/30 outline-none"
              required
            />
          </div>

          <div>
            <label className="block mb-1 text-sm">New Password (optional)</label>
            <input
              type="password"
              name="password"
              value={form.password}
              onChange={handleChange}
              className="w-full px-4 py-2 rounded-lg bg-white/20 focus:bg-white/30 outline-none"
              placeholder="Leave blank to keep current"
            />
          </div>

          <button
            type="submit"
            disabled={loading}
            className="w-full bg-blue-500 hover:bg-blue-600 transition py-2 rounded-lg font-semibold shadow-md"
          >
            {loading ? "Saving..." : "Save Changes"}
          </button>
        </form>

        <button
          onClick={() => navigate("/dashboard")}
          className="mt-4 w-full border border-white/40 py-2 rounded-lg font-medium hover:bg-white/20 transition"
        >
          Cancel
        </button>
      </div>
    </div>
  );
}
