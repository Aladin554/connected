import { useEffect, useState } from "react";
import axios from "axios";

export default function AdminUsers() {
  const [users, setUsers] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [form, setForm] = useState({ name: "", email: "", password: "" });
  const [editingUser, setEditingUser] = useState<any | null>(null);

  // Load all users
  useEffect(() => {
    fetchUsers();
  }, []);

  const fetchUsers = async () => {
    try {
      const res = await axios.get("/api/users");
      setUsers(res.data);
    } catch (err) {
      console.error(err);
      alert("Failed to fetch users");
    } finally {
      setLoading(false);
    }
  };

  const handleInput = (e: React.ChangeEvent<HTMLInputElement>) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      if (editingUser) {
        await axios.put(`/api/users/${editingUser.id}`, form);
        alert("User updated successfully");
      } else {
        await axios.post("/api/users", form);
        alert("User created successfully");
      }
      setForm({ name: "", email: "", password: "" });
      setEditingUser(null);
      fetchUsers();
    } catch (err) {
      console.error(err);
      alert("Error saving user");
    }
  };

  const handleEdit = (user: any) => {
    setEditingUser(user);
    setForm({ name: user.name, email: user.email, password: "" });
  };

  const handleDelete = async (id: number) => {
    if (!window.confirm("Are you sure?")) return;
    try {
      await axios.delete(`/api/users/${id}`);
      alert("User deleted");
      fetchUsers();
    } catch (err) {
      console.error(err);
      alert("Error deleting user");
    }
  };

  if (loading) return <p className="p-5">Loading users...</p>;

  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold mb-4">Admin User Management</h1>

      {/* User Form */}
      <form onSubmit={handleSubmit} className="space-y-3 mb-6">
        <input
          name="name"
          value={form.name}
          onChange={handleInput}
          placeholder="Name"
          className="border p-2 w-full rounded"
          required
        />
        <input
          name="email"
          value={form.email}
          onChange={handleInput}
          type="email"
          placeholder="Email"
          className="border p-2 w-full rounded"
          required
        />
        <input
          name="password"
          value={form.password}
          onChange={handleInput}
          type="password"
          placeholder={editingUser ? "New Password (optional)" : "Password"}
          className="border p-2 w-full rounded"
          required={!editingUser}
        />
        <button
          type="submit"
          className="bg-blue-600 text-white px-4 py-2 rounded"
        >
          {editingUser ? "Update User" : "Create User"}
        </button>
      </form>

      {/* User List Table */}
      <table className="w-full border-collapse border">
        <thead>
          <tr className="bg-gray-200">
            <th className="border p-2">ID</th>
            <th className="border p-2">Name</th>
            <th className="border p-2">Email</th>
            <th className="border p-2">Actions</th>
          </tr>
        </thead>
        <tbody>
          {users.length === 0 ? (
            <tr>
              <td colSpan={4} className="text-center p-4">
                No users found
              </td>
            </tr>
          ) : (
            users.map((user) => (
              <tr key={user.id}>
                <td className="border p-2">{user.id}</td>
                <td className="border p-2">{user.name}</td>
                <td className="border p-2">{user.email}</td>
                <td className="border p-2 space-x-2">
                  <button
                    onClick={() => handleEdit(user)}
                    className="bg-yellow-500 text-white px-2 py-1 rounded"
                  >
                    Edit
                  </button>
                  <button
                    onClick={() => handleDelete(user.id)}
                    className="bg-red-600 text-white px-2 py-1 rounded"
                  >
                    Delete
                  </button>
                </td>
              </tr>
            ))
          )}
        </tbody>
      </table>
    </div>
  );
}
