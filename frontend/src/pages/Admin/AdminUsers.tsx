import { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import api from "../../api/axios.ts";
import { Trash2, Edit, Plus } from "lucide-react";

import {
  Table,
  TableHeader,
  TableBody,
  TableRow,
  TableCell,
} from "../../components/ui/table";

interface User {
  id: number;
  firstName: string;
  lastName: string;
  email: string;
  role?: string;
  created_at?: string;
  updated_at?: string;
}

export default function AdminUsers() {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState("");
  const [perPage, setPerPage] = useState(5);
  const [currentPage, setCurrentPage] = useState(1);

  const [selected, setSelected] = useState<number[]>([]);
  const [selectAll, setSelectAll] = useState(false);

  const navigate = useNavigate();

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

  const openEditForm = (user: User) => {
    navigate(`/dashboard/admin-users/${user.id}/edit`);
  };

  // Checkbox handling
  const toggleSelectAll = () => {
    if (selectAll) {
      setSelected([]);
    } else {
      setSelected(users.map((u) => u.id));
    }
    setSelectAll(!selectAll);
  };

  const toggleSelect = (id: number) => {
    if (selected.includes(id)) {
      setSelected(selected.filter((s) => s !== id));
    } else {
      setSelected([...selected, id]);
    }
  };

  const formatDate = (dateString?: string) => {
    if (!dateString) return "-";
    return new Date(dateString).toISOString().split("T")[0];
  };

  // Filter + paginate
  const filteredData = users.filter(
    (u) =>
      `${u.firstName} ${u.lastName}`
        .toLowerCase()
        .includes(search.toLowerCase()) ||
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
      {/* Header */}
      <div className="flex justify-between items-center mb-5">
        <h1 className="text-2xl font-bold dark:text-gray-200">
          Admin User Management
        </h1>
        <Link
          to="/dashboard/admin-users/add"
          className="bg-blue-600 text-white px-4 py-2 rounded flex items-center gap-2 hover:bg-blue-700"
        >
          <Plus size={18} /> Add User
        </Link>
      </div>

      {/* Controls */}
      <div className="flex flex-col md:flex-row justify-between mb-4 gap-2 items-center">
        <div className="flex items-center gap-2 text-gray-600 dark:text-gray-300">
          <span>Show</span>
          <select
            value={perPage}
            onChange={(e) => {
              setPerPage(Number(e.target.value));
              setCurrentPage(1);
            }}
            className="border px-5 py-1 rounded dark:bg-gray-800 dark:text-gray-200 focus:outline-none focus:ring-2 focus:ring-indigo-400"
          >
            <option value={5}>5</option>
            <option value={10}>10</option>
            <option value={25}>25</option>
          </select>
          <span>entries</span>
        </div>

        <div className="flex items-center gap-2 w-full md:w-auto">
          <input
            type="text"
            placeholder="Search..."
            value={search}
            onChange={(e) => {
              setSearch(e.target.value);
              setCurrentPage(1);
            }}
            className="border px-3 py-2 rounded w-full md:w-[200px] dark:bg-gray-800 dark:text-gray-200 focus:outline-none focus:ring-2 focus:ring-indigo-400"
          />
        </div>
      </div>

      {/* Table */}
      <div className="overflow-hidden rounded-xl border border-gray-200 dark:border-gray-700 dark:bg-gray-800">
        <div className="max-w-full overflow-x-auto">
          <div className="min-w-[700px]">
            <Table>
              <TableHeader className="border-b border-gray-100 dark:border-gray-600 bg-gray-50 dark:bg-gray-700">
                <TableRow>
                  <TableCell isHeader className="w-12 text-center">
                    <input
                      type="checkbox"
                      checked={selectAll}
                      onChange={toggleSelectAll}
                    />
                  </TableCell>
                  <TableCell
                    isHeader
                    className="px-5 py-3 font-medium text-gray-700 dark:text-gray-200 border-r"
                  >
                    User
                  </TableCell>
                  <TableCell
                    isHeader
                    className="px-5 py-3 font-medium text-gray-700 dark:text-gray-200 border-r"
                  >
                    Role
                  </TableCell>
                  <TableCell
                    isHeader
                    className="px-5 py-3 font-medium text-gray-700 dark:text-gray-200 border-r"
                  >
                    Created At
                  </TableCell>
                  <TableCell
                    isHeader
                    className="px-5 py-3 font-medium text-gray-700 dark:text-gray-200 border-r"
                  >
                    Updated At
                  </TableCell>
                  <TableCell
                    isHeader
                    className="px-5 py-3 font-medium text-gray-700 dark:text-gray-200 text-right"
                  >
                    Action
                  </TableCell>
                </TableRow>
              </TableHeader>

              <TableBody className="divide-y divide-gray-200 dark:divide-gray-600">
                {loading ? (
                  <TableRow>
                    <TableCell className="px-5 py-4 text-center dark:text-gray-200">
                      Loading...
                    </TableCell>
                  </TableRow>
                ) : paginatedData.length === 0 ? (
                  <TableRow>
                    <TableCell className="px-5 py-4 text-center dark:text-gray-200">
                      No users found
                    </TableCell>
                  </TableRow>
                ) : (
                  paginatedData.map((user) => (
                    <TableRow
                      key={user.id}
                      className="hover:bg-gray-50 dark:hover:bg-gray-700"
                    >
                      <TableCell className="w-12 text-center">
                        <input
                          type="checkbox"
                          checked={selected.includes(user.id)}
                          onChange={() => toggleSelect(user.id)}
                        />
                      </TableCell>

                      <TableCell className="px-5 py-4 border-r dark:border-gray-600">
                        <div className="font-medium text-gray-900 dark:text-gray-200">
                          {user.firstName} {user.lastName}
                        </div>
                        <div className="text-sm text-gray-500">
                          {user.email}
                        </div>
                      </TableCell>

                      <TableCell className="px-5 py-4 border-r text-gray-700 dark:text-gray-200">
                        {user.role || "-"}
                      </TableCell>

                      <TableCell className="px-5 py-4 border-r text-gray-700 dark:text-gray-200">
                        {formatDate(user.created_at)}
                      </TableCell>

                      <TableCell className="px-5 py-4 border-r text-gray-700 dark:text-gray-200">
                        {formatDate(user.updated_at)}
                      </TableCell>

                      <TableCell className="px-5 py-4 text-right">
                        <div className="flex justify-end gap-2">
                          <button
                            onClick={() => openEditForm(user)}
                            className="p-2 rounded hover:bg-yellow-100 text-yellow-600"
                          >
                            <Edit size={18} />
                          </button>
                          <button
                            onClick={() => handleDelete(user.id)}
                            className="p-2 rounded hover:bg-red-100 text-red-600"
                          >
                            <Trash2 size={18} />
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
          Showing {totalRows === 0 ? 0 : (currentPage - 1) * perPage + 1} to{" "}
          {Math.min(currentPage * perPage, totalRows)} of {totalRows} entries
        </div>
        <div className="flex items-center space-x-1">
          <button
            onClick={() => setCurrentPage((p) => Math.max(p - 1, 1))}
            disabled={currentPage === 1}
            className="px-3 py-1 border rounded disabled:opacity-50 dark:border-gray-600"
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
            disabled={currentPage === totalPages}
            className="px-3 py-1 border rounded disabled:opacity-50 dark:border-gray-600"
          >
            Next
          </button>
        </div>
      </div>
    </div>
  );
}
