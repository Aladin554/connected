import { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import api from "../../api/axios.ts";
import { Trash2, Edit, Plus } from "lucide-react";

interface Role { id: number; name: string; }
interface User { id: number; firstName: string; lastName: string; email: string; role?: Role; created_at?: string; updated_at?: string; }

export default function AdminUsers() {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState("");
  const [perPage, setPerPage] = useState(5);
  const [currentPage, setCurrentPage] = useState(1);
  const [selected, setSelected] = useState<number[]>([]);
  const [selectAll, setSelectAll] = useState(false);
  const navigate = useNavigate();

  useEffect(() => { fetchUsers(); }, []);
  const fetchUsers = async () => {
    try { const res = await api.get("/users"); setUsers(res.data); } 
    catch { alert("Failed to fetch users"); } 
    finally { setLoading(false); }
  };

  const handleDelete = async (id: number) => {
    if (!confirm("Are you sure?")) return;
    try { await api.delete(`/users/${id}`); alert("User deleted"); fetchUsers(); } 
    catch { alert("Error deleting user"); }
  };

  const openEditForm = (user: User) => { navigate(`/dashboard/admin-users/${user.id}/edit`); };
  const toggleSelectAll = () => { if (selectAll) setSelected([]); else setSelected(users.map((u) => u.id)); setSelectAll(!selectAll); };
  const toggleSelect = (id: number) => { if (selected.includes(id)) setSelected(selected.filter((s) => s !== id)); else setSelected([...selected, id]); };
  const formatDate = (dateString?: string) => !dateString ? "-" : new Date(dateString).toISOString().split("T")[0];

  const filteredData = users.filter(u => `${u.firstName} ${u.lastName}`.toLowerCase().includes(search.toLowerCase()) || u.email.toLowerCase().includes(search.toLowerCase()));
  const totalRows = filteredData.length;
  const totalPages = Math.ceil(totalRows / perPage);
  const paginatedData = filteredData.slice((currentPage - 1) * perPage, currentPage * perPage);

  return (
    <div className="p-5 border border-gray-200 rounded-2xl dark:border-gray-700 lg:p-6 dark:bg-gray-900">
      {/* Header */}
      <div className="flex flex-col sm:flex-row justify-between items-center mb-5 gap-3">
        <h1 className="text-lg sm:text-2xl font-bold dark:text-gray-200 text-center sm:text-left">Admin User Management</h1>
        <Link to="/dashboard/admin-users/add" className="flex items-center gap-2 px-5 py-3 rounded-lg bg-blue-600 text-white text-base font-medium shadow-sm hover:bg-blue-700 hover:shadow-md transition-all">
          <Plus size={20} /> Add User
        </Link>
      </div>

      {/* Controls */}
      <div className="flex flex-col md:flex-row justify-between mb-4 gap-3 items-center">
        <div className="flex items-center gap-2 text-gray-600 dark:text-gray-300 text-base">
          <span>Show</span>
          <select value={perPage} onChange={(e) => { setPerPage(Number(e.target.value)); setCurrentPage(1); }} className="border px-5 py-2 rounded text-base dark:bg-gray-800 dark:text-gray-200 focus:outline-none focus:ring-2 focus:ring-indigo-400">
            <option value={5}>5</option>
            <option value={10}>10</option>
            <option value={25}>25</option>
          </select>
          <span>entries</span>
        </div>
        <div className="flex items-center gap-2 w-full md:w-auto">
          <input type="text" placeholder="Search..." value={search} onChange={(e) => { setSearch(e.target.value); setCurrentPage(1); }} className="border px-4 py-2 rounded w-full md:w-64 text-base dark:bg-gray-800 dark:text-gray-200 focus:outline-none focus:ring-2 focus:ring-indigo-400" />
        </div>
      </div>

      {/* Table for md+ screens (larger) */}
      <div className="hidden md:block overflow-x-auto rounded-xl border border-gray-200 dark:border-gray-700 dark:bg-gray-800">
        <table className="min-w-full text-base">
          <thead className="border-b border-gray-100 dark:border-gray-600 bg-gray-50 dark:bg-gray-700">
            <tr>
              <th className="w-14 text-center"><input type="checkbox" checked={selectAll} onChange={toggleSelectAll} /></th>
              <th className="px-6 py-4 text-left font-medium text-gray-700 dark:text-gray-200 border-r">User</th>
              <th className="px-6 py-4 text-left font-medium text-gray-700 dark:text-gray-200 border-r">Role</th>
              <th className="px-6 py-4 text-left font-medium text-gray-700 dark:text-gray-200 border-r">Created At</th>
              <th className="px-6 py-4 text-left font-medium text-gray-700 dark:text-gray-200 border-r">Updated At</th>
              <th className="px-6 py-4 text-left font-medium text-gray-700 dark:text-gray-200">Action</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-200 dark:divide-gray-600">
            {loading ? (
              <tr><td colSpan={6} className="px-6 py-4 text-center dark:text-gray-200">Loading...</td></tr>
            ) : paginatedData.length === 0 ? (
              <tr><td colSpan={6} className="px-6 py-4 text-center dark:text-gray-200">No users found</td></tr>
            ) : (
              paginatedData.map(user => (
                <tr key={user.id} className="hover:bg-gray-50 dark:hover:bg-gray-700">
                  <td className="w-14 text-center"><input type="checkbox" checked={selected.includes(user.id)} onChange={() => toggleSelect(user.id)} className="w-5 h-5 rounded-sm" /></td>
                  <td className="px-6 py-4 border-r text-left">
                    <div className="font-semibold text-gray-900 dark:text-gray-200 text-lg">{user.firstName} {user.lastName}</div>
                    <div className="text-base text-gray-500 truncate">{user.email}</div>
                  </td>
                  <td className="px-6 py-4 border-r text-gray-700 dark:text-gray-200 text-left text-base">{user.role?.name || "-"}</td>
                  <td className="px-6 py-4 border-r text-gray-700 dark:text-gray-200 text-left text-base">{formatDate(user.created_at)}</td>
                  <td className="px-6 py-4 border-r text-gray-700 dark:text-gray-200 text-left text-base">{formatDate(user.updated_at)}</td>
                  <td className="px-6 py-4 text-left sm:text-right flex gap-3">
                    <button onClick={() => openEditForm(user)} className="p-3 rounded hover:bg-yellow-100 text-yellow-600"><Edit size={20} /></button>
                    <button onClick={() => handleDelete(user.id)} className="p-3 rounded hover:bg-red-100 text-red-600"><Trash2 size={20} /></button>
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>

      {/* Card layout for small devices remains unchanged */}
      {/* Card layout for small devices */}
<div className="md:hidden">
  {/* Mobile Select All */}
  <div className="flex items-center gap-2 mb-3 px-2">
    <input
      type="checkbox"
      checked={selectAll}
      onChange={toggleSelectAll}
      className="w-4 h-4 rounded-sm"
    />
    <span className="text-gray-700 dark:text-gray-300 text-sm">Select All</span>
  </div>

  {/* Cards */}
  <div className="grid gap-3">
    {loading ? (
      <div className="text-center dark:text-gray-200">Loading...</div>
    ) : paginatedData.length === 0 ? (
      <div className="text-center dark:text-gray-200">No users found</div>
    ) : (
      paginatedData.map((user) => (
        <div
          key={user.id}
          className="flex flex-col sm:flex-row sm:items-center justify-between p-4 border rounded-lg dark:border-gray-700 dark:bg-gray-800 hover:bg-gray-50 dark:hover:bg-gray-700"
        >
          <div className="flex items-center gap-3">
            <input
              type="checkbox"
              checked={selected.includes(user.id)}
              onChange={() => toggleSelect(user.id)}
              className="w-4 h-4 rounded-sm"
            />
            <div>
              <div className="font-medium text-gray-900 dark:text-gray-200">{user.firstName} {user.lastName}</div>
              <div className="text-sm text-gray-500 truncate">{user.email}</div>
              <div className="text-sm text-gray-400">Role: {user.role?.name || "-"}</div>
              <div className="text-sm text-gray-400">Created: {formatDate(user.created_at)}</div>
              <div className="text-sm text-gray-400">Updated: {formatDate(user.updated_at)}</div>
            </div>
          </div>
          <div className="flex gap-2 mt-3 sm:mt-0">
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
        </div>
      ))
    )}
  </div>
</div>


      {/* Pagination */}
      <div className="flex flex-col md:flex-row justify-between items-center mt-4 gap-2 text-gray-700 dark:text-gray-300">
        <div>Showing {totalRows === 0 ? 0 : (currentPage - 1) * perPage + 1} to {Math.min(currentPage * perPage, totalRows)} of {totalRows} entries</div>
        <div className="flex flex-wrap items-center space-x-1">
          <button onClick={() => setCurrentPage(p => Math.max(p-1,1))} disabled={currentPage===1} className="px-3 py-2 border rounded disabled:opacity-50 dark:border-gray-600">Previous</button>
          {Array.from({ length: totalPages }, (_, i) => i+1).map(num => (
            <button key={num} onClick={() => setCurrentPage(num)} className={`px-3 py-2 border rounded dark:border-gray-600 ${num===currentPage?'bg-blue-600 text-white':''}`}>{num}</button>
          ))}
          <button onClick={() => setCurrentPage(p => Math.min(p+1,totalPages))} disabled={currentPage===totalPages} className="px-3 py-2 border rounded disabled:opacity-50 dark:border-gray-600">Next</button>
        </div>
      </div>
    </div>
  );
}
