import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import api from "../../api/axios.ts";

interface Role {
    id: number;
    name: string;
}

export default function AdminUserForm() {
    const { id } = useParams();
    const navigate = useNavigate();
    const isEdit = Boolean(id);

    const [form, setForm] = useState({
        firstName: "",
        lastName: "",
        email: "",
        roleId: "",
        password: "",
    });

    const [errors, setErrors] = useState({
        firstName: "",
        lastName: "",
        email: "",
        roleId: "",
        password: "",
    });

    const [submitting, setSubmitting] = useState(false);
    const [roles, setRoles] = useState<Role[]>([]);

    // Fetch roles
    useEffect(() => {
        api.get("/roles")
            .then((res) => setRoles(Array.isArray(res.data) ? res.data : []))
            .catch(() => alert("Failed to fetch roles"));
    }, []);

    // Load user if editing
    useEffect(() => {
        if (isEdit) {
            api.get(`/users/${id}`)
                .then((res) => {
                    setForm({
                        firstName: res.data.firstName,
                        lastName: res.data.lastName,
                        email: res.data.email,
                        roleId: res.data.role?.id || "",
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
            roleId: "",
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
        if (!form.roleId) {
            newErrors.roleId = "Role is required.";
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
            const payload = {
                first_name: form.firstName,
                last_name: form.lastName,
                email: form.email,
                role_id: form.roleId,
                password: form.password || undefined,
            };

            if (isEdit) {
                await api.put(`/users/${id}`, payload);
                alert("User updated successfully!");
            } else {
                await api.post("/users", payload);
                alert("User added successfully!");
            }
            navigate("/dashboard/admin-users");
        } catch {
            alert("Error saving user");
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div className="p-16 border border-gray-200 rounded-2xl dark:border-gray-700 dark:bg-gray-900 shadow-sm max-w-5xl mx-auto w-full">
            <h1 className="text-2xl font-semibold mb-6 dark:text-gray-200">
                {isEdit ? "Edit User" : "Add New User"}
            </h1>

            {/* Form stretched wider */}
            <form onSubmit={handleSubmit} className="space-y-6 w-full">
                {/* Grid: 2 columns */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                    {/* First Name */}
                    <div>
                        <label className="block mb-1 text-sm font-medium dark:text-gray-300">
                            First Name
                        </label>
                        <input
                            type="text"
                            value={form.firstName}
                            onChange={(e) =>
                                setForm({ ...form, firstName: e.target.value })
                            }
                            className={`w-full border px-3 py-2 rounded-lg text-lg dark:bg-gray-700 dark:text-gray-200 focus:outline-none focus:ring-2 ${
                                errors.firstName
                                    ? "focus:ring-red-500 border-red-500"
                                    : "focus:ring-blue-500"
                            }`}
                        />
                        {errors.firstName && (
                            <p className="text-red-500 text-sm mt-1">
                                {errors.firstName}
                            </p>
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
                            onChange={(e) =>
                                setForm({ ...form, lastName: e.target.value })
                            }
                            className={`w-full border px-3 py-2 rounded-lg text-lg dark:bg-gray-700 dark:text-gray-200 focus:outline-none focus:ring-2 ${
                                errors.lastName
                                    ? "focus:ring-red-500 border-red-500"
                                    : "focus:ring-blue-500"
                            }`}
                        />
                        {errors.lastName && (
                            <p className="text-red-500 text-sm mt-1">
                                {errors.lastName}
                            </p>
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
                            onChange={(e) =>
                                setForm({ ...form, email: e.target.value })
                            }
                            className={`w-full border px-3 py-2 rounded-lg text-lg dark:bg-gray-700 dark:text-gray-200 focus:outline-none focus:ring-2 ${
                                errors.email
                                    ? "focus:ring-red-500 border-red-500"
                                    : "focus:ring-blue-500"
                            }`}
                        />
                        {errors.email && (
                            <p className="text-red-500 text-sm mt-1">
                                {errors.email}
                            </p>
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
                            onChange={(e) =>
                                setForm({ ...form, password: e.target.value })
                            }
                            className={`w-full border px-3 py-2 rounded-lg text-lg dark:bg-gray-700 dark:text-gray-200 focus:outline-none focus:ring-2 ${
                                errors.password
                                    ? "focus:ring-red-500 border-red-500"
                                    : "focus:ring-blue-500"
                            }`}
                        />
                        {errors.password && (
                            <p className="text-red-500 text-sm mt-1">
                                {errors.password}
                            </p>
                        )}
                    </div>

                    {/* Role (Full Width) */}
                    <div>
                        <label className="block mb-1 text-sm font-medium dark:text-gray-300">
                            Role
                        </label>
                        <select
                            value={form.roleId}
                            onChange={(e) =>
                                setForm({ ...form, roleId: e.target.value })
                            }
                            className={`w-full border px-3 py-2 rounded-lg text-lg dark:bg-gray-700 dark:text-gray-200 focus:outline-none focus:ring-2 ${
                                errors.roleId
                                    ? "focus:ring-red-500 border-red-500"
                                    : "focus:ring-blue-500"
                            }`}
                        >
                            <option value="">Select role</option>
                            {roles.map((role) => (
                                <option key={role.id} value={role.id}>
                                    {role.name}
                                </option>
                            ))}
                        </select>
                        {errors.roleId && (
                            <p className="text-red-500 text-sm mt-1">
                                {errors.roleId}
                            </p>
                        )}
                    </div>
                </div>

                {/* Buttons */}
                <div className="flex justify-end gap-3">
                    <button
                        type="button"
                        onClick={() => navigate("/dashboard/admin-users")}
                        className="px-5 py-2 rounded-lg border dark:border-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800"
                    >
                        Cancel
                    </button>
                    <button
                        type="submit"
                        disabled={submitting}
                        className="px-6 py-3 rounded-lg bg-blue-600 text-white hover:bg-blue-700 text-lg disabled:opacity-50"
                    >
                        {submitting ? "Saving..." : "Save"}
                    </button>
                </div>
            </form>
        </div>
    );
}
