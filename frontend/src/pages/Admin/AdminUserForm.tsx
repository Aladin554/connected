import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import api from "../../api/axios.ts";

export default function AdminUserForm() {
  const { id } = useParams(); // if editing, id will exist
  const navigate = useNavigate();

  const [form, setForm] = useState({
    firstName: "",
    lastName: "",
    email: "",
    role: "",
    password: "",
  });

  const [errors, setErrors] = useState({
    firstName: "",
    lastName: "",
    email: "",
    role: "",
    password: "",
  });

  const [submitting, setSubmitting] = useState(false);
  const isEdit = Boolean(id);

  // fetch existing user for edit
  useEffect(() => {
    if (isEdit) {
      api
        .get(`/users/${id}`)
        .then((res) => {
          setForm({
            firstName: res.data.firstName,
            lastName: res.data.lastName,
            email: res.data.email,
            role: res.data.role || "",
            password: "",
          });
        })
        .catch(() => alert("Failed to load user"));
    }
  }, [id, isEdit]);

  const validateForm = () => {
    let valid = true;
    const newErrors = {
      firstName: "",
      lastName: "",
      email: "",
      role: "",
      password: "",
    };

    if (!form.firstName.trim()) {
      newErrors.firstName = "First name is required.";
      valid = false;
    }
    if (!form.lastName.trim()) {
      newErrors.lastName = "Last name is required.";
      valid = false;
    }
    if (!form.email.trim()) {
      newErrors.email = "Email is required.";
      valid = false;
    } else if (
      !/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i.test(form.email)
    ) {
      newErrors.email = "Invalid email address.";
      valid = false;
    }
    if (!form.role.trim()) {
      newErrors.role = "Role is required.";
      valid = false;
    }
    if (!isEdit && !form.password.trim()) {
      newErrors.password = "Password is required.";
      valid = false;
    }

    setErrors(newErrors);
    return valid;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!validateForm()) return;

    setSubmitting(true);
    try {
      if (isEdit) {
        await api.put(`/users/${id}`, form);
        alert("User updated successfully!");
      } else {
        await api.post("/users", form);
        alert("User added successfully!");
      }
      navigate("/admin/users");
    } catch {
      alert("Error saving user");
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className="p-5 border border-gray-200 rounded-2xl dark:border-gray-700 lg:p-6 dark:bg-gray-900">
      <h1 className="text-2xl font-bold mb-6 dark:text-gray-200">
        {isEdit ? "Edit User" : "Add New User"}
      </h1>

      <form onSubmit={handleSubmit} className="space-y-4 max-w-lg">
        {/* First Name */}
        <div>
          <label className="block mb-1 text-sm font-medium dark:text-gray-300">
            First Name
          </label>
          <input
            type="text"
            value={form.firstName}
            onChange={(e) => setForm({ ...form, firstName: e.target.value })}
            className={`w-full border px-3 py-2 rounded dark:bg-gray-700 dark:text-gray-200 focus:outline-none focus:ring-2 ${
              errors.firstName
                ? "focus:ring-red-500 border-red-500"
                : "focus:ring-blue-500"
            }`}
          />
          {errors.firstName && (
            <p className="text-red-500 text-sm mt-1">{errors.firstName}</p>
          )}
        </div>

        {/* Last Name */}
        <div>
          <label className="block mb-1 text-sm font-medium dark:text-gray-300">
            Last Name
          </label>
          <input
            type="text"
            value={form.lastName}
            onChange={(e) => setForm({ ...form, lastName: e.target.value })}
            className={`w-full border px-3 py-2 rounded dark:bg-gray-700 dark:text-gray-200 focus:outline-none focus:ring-2 ${
              errors.lastName
                ? "focus:ring-red-500 border-red-500"
                : "focus:ring-blue-500"
            }`}
          />
          {errors.lastName && (
            <p className="text-red-500 text-sm mt-1">{errors.lastName}</p>
          )}
        </div>

        {/* Email */}
        <div>
          <label className="block mb-1 text-sm font-medium dark:text-gray-300">
            Email
          </label>
          <input
            type="email"
            value={form.email}
            onChange={(e) => setForm({ ...form, email: e.target.value })}
            className={`w-full border px-3 py-2 rounded dark:bg-gray-700 dark:text-gray-200 focus:outline-none focus:ring-2 ${
              errors.email
                ? "focus:ring-red-500 border-red-500"
                : "focus:ring-blue-500"
            }`}
          />
          {errors.email && (
            <p className="text-red-500 text-sm mt-1">{errors.email}</p>
          )}
        </div>

        {/* Password */}
        <div>
          <label className="block mb-1 text-sm font-medium dark:text-gray-300">
            Password {isEdit && "(leave blank to keep unchanged)"}
          </label>
          <input
            type="password"
            value={form.password}
            onChange={(e) => setForm({ ...form, password: e.target.value })}
            className={`w-full border px-3 py-2 rounded dark:bg-gray-700 dark:text-gray-200 focus:outline-none focus:ring-2 ${
              errors.password
                ? "focus:ring-red-500 border-red-500"
                : "focus:ring-blue-500"
            }`}
          />
          {errors.password && (
            <p className="text-red-500 text-sm mt-1">{errors.password}</p>
          )}
        </div>

        {/* Role */}
        <div>
          <label className="block mb-1 text-sm font-medium dark:text-gray-300">
            Role
          </label>
          <select
            value={form.role}
            onChange={(e) => setForm({ ...form, role: e.target.value })}
            className={`w-full border px-3 py-2 rounded dark:bg-gray-700 dark:text-gray-200 focus:outline-none focus:ring-2 ${
              errors.role
                ? "focus:ring-red-500 border-red-500"
                : "focus:ring-blue-500"
            }`}
          >
            <option value="">Select role</option>
            <option value="Admin">Admin</option>
            <option value="Editor">Editor</option>
            <option value="User">User</option>
          </select>
          {errors.role && (
            <p className="text-red-500 text-sm mt-1">{errors.role}</p>
          )}
        </div>

        {/* Buttons */}
        <div className="flex justify-end gap-2 mt-6">
          <button
            type="button"
            onClick={() => navigate("/admin/users")}
            className="px-4 py-2 rounded border dark:border-gray-600 dark:text-gray-300"
          >
            Cancel
          </button>
          <button
            type="submit"
            disabled={submitting}
            className="px-4 py-2 rounded bg-blue-600 text-white hover:bg-blue-700 disabled:opacity-50"
          >
            {submitting ? "Saving..." : "Save"}
          </button>
        </div>
      </form>
    </div>
  );
}
