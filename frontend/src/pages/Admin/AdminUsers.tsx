import { useEffect, useState } from "react";
import api from "../../api/axios"; // use the custom axios instance

import {
  Table,
  TableHeader,
  TableBody,
  TableRow,
  TableCell,
} from "../../components/ui/table";

interface User {
  id: number;
  name: string;
  email: string;
}

export default function AdminUsers() {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);
  const [form, setForm] = useState({ name: "", email: "", password: "" });
  const [editingUser, setEditingUser] = useState<User | null>(null);
  const [search, setSearch] = useState("");
  const [perPage, setPerPage] = useState(5);
  const [currentPage, setCurrentPage] = useState(1);

  useEffect(() => {
    fetchUsers();
  }, []);

  const fetchUsers = async () => {
    try {
      const res = await api.get("/users");
      setUsers(res.data);
    } catch {
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
        await api.put(`/users/${editingUser.id}`, form);
        alert("User updated");
      } else {
        await api.post("/users", form);
        alert("User created");
      }
      setForm({ name: "", email: "", password: "" });
      setEditingUser(null);
      fetchUsers();
    } catch {
      alert("Error saving user");
    }
  };

  const handleEdit = (user: User) => {
    setEditingUser(user);
    setForm({ name: user.name, email: user.email, password: "" });
  };

  const handleDelete = async (id: number) => {
    if (!confirm("Are you sure?")) return;
    try {
      await api.delete(`/users/${id}`);
      alert("User deleted");
      fetchUsers();
    } catch {
      alert("Error deleting user");
    }
  };

  // Filter + paginate
  const filteredData = users.filter(
    (u) =>
      u.name.toLowerCase().includes(search.toLowerCase()) ||
      u.email.toLowerCase().includes(search.toLowerCase())
  );

  const totalRows = filteredData.length;
  const totalPages = Math.ceil(totalRows / perPage);
  const paginatedData = filteredData.slice(
    (currentPage - 1) * perPage,
    currentPage * perPage
  );

  return (
    <div className="p-5 border border-gray-200 rounded-2xl dark:border-gray-700 lg:p-6 dark:bg-gray-900">
      <h1 className="text-2xl font-bold mb-5 dark:text-gray-200">
        Admin User Management
      </h1>

      {/* Form */}
      <form onSubmit={handleSubmit} className="space-y-3 mb-6 max-w-md">
        <input
          name="name"
          value={form.name}
          onChange={handleInput}
          placeholder="Name"
          className="border p-2 w-full rounded dark:bg-gray-800 dark:text-gray-200 focus:outline-none focus:ring-2 focus:ring-indigo-400"
          required
        />
        <input
          name="email"
          value={form.email}
          onChange={handleInput}
          placeholder="Email"
          type="email"
          className="border p-2 w-full rounded dark:bg-gray-800 dark:text-gray-200 focus:outline-none focus:ring-2 focus:ring-indigo-400"
          required
        />
        <input
          name="password"
          value={form.password}
          onChange={handleInput}
          type="password"
          placeholder={editingUser ? "New Password (optional)" : "Password"}
          className="border p-2 w-full rounded dark:bg-gray-800 dark:text-gray-200 focus:outline-none focus:ring-2 focus:ring-indigo-400"
          required={!editingUser}
        />
        <button className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
          {editingUser ? "Update User" : "Create User"}
        </button>
      </form>

      {/* Controls */}
      <div className="flex flex-col md:flex-row justify-between mb-4 gap-2 items-center">
        <input
          type="text"
          placeholder="Search users..."
          value={search}
          onChange={(e) => {
            setSearch(e.target.value);
            setCurrentPage(1);
          }}
          className="border px-3 py-2 rounded w-full md:w-64 dark:bg-gray-800 dark:text-gray-200 focus:outline-none focus:ring-2 focus:ring-indigo-400"
        />
        <div className="flex items-center gap-2 text-gray-600 dark:text-gray-300">
          <span>Show</span>
          <select
            value={perPage}
            onChange={(e) => {
              setPerPage(Number(e.target.value));
              setCurrentPage(1);
            }}
            className="border px-2 py-1 rounded dark:bg-gray-800 dark:text-gray-200 focus:outline-none focus:ring-2 focus:ring-indigo-400"
          >
            <option value={5}>5</option>
            <option value={10}>10</option>
            <option value={25}>25</option>
          </select>
          <span>entries</span>
        </div>
      </div>

      {/* Table */}
      <div className="overflow-hidden rounded-xl border border-gray-200 dark:border-gray-700 dark:bg-gray-800">
        <div className="max-w-full overflow-x-auto">
          <div className="min-w-[600px]">
            <Table>
              <TableHeader className="border-b border-gray-200 dark:border-gray-600 bg-gray-50 dark:bg-gray-700">
                <TableRow>
                  <TableCell isHeader className="px-5 py-3 font-medium text-gray-700 dark:text-gray-200">
                    ID
                  </TableCell>
                  <TableCell isHeader className="px-5 py-3 font-medium text-gray-700 dark:text-gray-200">
                    Name
                  </TableCell>
                  <TableCell isHeader className="px-5 py-3 font-medium text-gray-700 dark:text-gray-200">
                    Email
                  </TableCell>
                  <TableCell isHeader className="px-5 py-3 font-medium text-gray-700 dark:text-gray-200">
                    Actions
                  </TableCell>
                </TableRow>
              </TableHeader>
              <TableBody className="divide-y divide-gray-200 dark:divide-gray-600">
                {loading ? (
                  <TableRow>
                    <TableCell className="px-5 py-4 text-center dark:text-gray-200" colSpan={4}>
                      Loading...
                    </TableCell>
                  </TableRow>
                ) : paginatedData.length === 0 ? (
                  <TableRow>
                    <TableCell className="px-5 py-4 text-center dark:text-gray-200" colSpan={4}>
                      No users found
                    </TableCell>
                  </TableRow>
                ) : (
                  paginatedData.map((user) => (
                    <TableRow key={user.id}>
                      <TableCell className="px-5 py-4 dark:text-gray-200">{user.id}</TableCell>
                      <TableCell className="px-5 py-4 dark:text-gray-200">{user.name}</TableCell>
                      <TableCell className="px-5 py-4 dark:text-gray-200">{user.email}</TableCell>
                      <TableCell className="px-5 py-4">
                        <div className="flex gap-2">
                          <button
                            onClick={() => handleEdit(user)}
                            className="bg-yellow-500 px-3 py-1 rounded text-white hover:bg-yellow-600"
                          >
                            Edit
                          </button>
                          <button
                            onClick={() => handleDelete(user.id)}
                            className="bg-red-500 px-3 py-1 rounded text-white hover:bg-red-600"
                          >
                            Delete
                          </button>
                        </div>
                      </TableCell>
                    </TableRow>
                  ))
                )}
              </TableBody>
            </Table>
          </div>
        </div>
      </div>

      {/* Pagination */}
      <div className="flex flex-col md:flex-row justify-between items-center mt-4 gap-2 text-gray-700 dark:text-gray-300">
        <div>
          Showing{" "}
          {totalRows === 0 ? 0 : (currentPage - 1) * perPage + 1} to{" "}
          {Math.min(currentPage * perPage, totalRows)} of {totalRows} entries
        </div>
        <div className="flex items-center space-x-1">
          <button
            onClick={() => setCurrentPage((p) => Math.max(p - 1, 1))}
            className="px-3 py-1 border rounded disabled:opacity-50 dark:border-gray-600"
            disabled={currentPage === 1}
          >
            Previous
          </button>
          {Array.from({ length: totalPages }, (_, i) => i + 1).map((num) => (
            <button
              key={num}
              onClick={() => setCurrentPage(num)}
              className={`px-3 py-1 border rounded dark:border-gray-600 ${
                num === currentPage ? "bg-blue-600 text-white" : ""
              }`}
            >
              {num}
            </button>
          ))}
          <button
            onClick={() => setCurrentPage((p) => Math.min(p + 1, totalPages))}
            className="px-3 py-1 border rounded disabled:opacity-50 dark:border-gray-600"
            disabled={currentPage === totalPages}
          >
            Next
          </button>
        </div>
      </div>
    </div>
  );
}
