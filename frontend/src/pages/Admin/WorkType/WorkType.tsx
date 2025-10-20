import { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import api from "../../../api/axios";
import { Trash2, Edit, Plus, ImageIcon } from "lucide-react";

interface WorkType {
    id: number;
    title: string;
    modal_title: string;
    modal_image?: string;
    modal_description?: string;
    created_at?: string;
    updated_at?: string;
}

export default function WorkType() {
    const [workTypes, setWorkTypes] = useState<WorkType[]>([]);
    const [loading, setLoading] = useState(true);
    const [search, setSearch] = useState("");
    const [perPage, setPerPage] = useState(5);
    const [currentPage, setCurrentPage] = useState(1);
    const [selected, setSelected] = useState<number[]>([]);
    const [selectAll, setSelectAll] = useState(false);
    const navigate = useNavigate();

    useEffect(() => {
        fetchWorkTypes();
    }, []);

    const fetchWorkTypes = async () => {
        try {
            const res = await api.get("/categories");
            setWorkTypes(res.data.data || res.data);
        } catch {
            alert("Failed to fetch work types");
        } finally {
            setLoading(false);
        }
    };

    const handleDelete = async (id: number) => {
        if (!confirm("Are you sure you want to delete this work type?")) return;
        try {
            await api.delete(`/categories/${id}`);
            alert("Work type deleted successfully");
            fetchWorkTypes();
        } catch {
            alert("Error deleting work type");
        }
    };

    const openEditForm = (item: WorkType) => {
        navigate(`/dashboard/categories/${item.id}/edit`);
    };

    const toggleSelectAll = () => {
        if (selectAll) setSelected([]);
        else setSelected(workTypes.map((w) => w.id));
        setSelectAll(!selectAll);
    };

    const toggleSelect = (id: number) => {
        if (selected.includes(id))
            setSelected(selected.filter((s) => s !== id));
        else setSelected([...selected, id]);
    };

    const formatDate = (dateString?: string) =>
        !dateString ? "-" : new Date(dateString).toISOString().split("T")[0];

    const filteredData = workTypes.filter(
        (w) =>
            w.title.toLowerCase().includes(search.toLowerCase()) ||
            w.modal_title.toLowerCase().includes(search.toLowerCase())
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
            <div className="flex flex-col sm:flex-row justify-between items-center mb-5 gap-3">
                <h1 className="text-lg sm:text-2xl font-bold dark:text-gray-200 text-center sm:text-left">
                    Work Type Management
                </h1>
                <Link
                    to="/dashboard/categories/add"
                    className="flex items-center gap-2 px-5 py-3 rounded-lg bg-blue-600 text-white text-base font-medium shadow-sm hover:bg-blue-700 hover:shadow-md transition-all"
                >
                    <Plus size={20} /> Add Work Type
                </Link>
            </div>

            {/* Controls */}
            <div className="flex flex-col md:flex-row justify-between mb-4 gap-3 items-center">
                <div className="flex items-center gap-2 text-gray-600 dark:text-gray-300 text-base">
                    <span>Show</span>
                    <select
                        value={perPage}
                        onChange={(e) => {
                            setPerPage(Number(e.target.value));
                            setCurrentPage(1);
                        }}
                        className="border px-5 py-2 rounded text-base dark:bg-gray-800 dark:text-gray-200 focus:outline-none focus:ring-2 focus:ring-indigo-400"
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
                        className="border px-4 py-2 rounded w-full md:w-64 text-base dark:bg-gray-800 dark:text-gray-200 focus:outline-none focus:ring-2 focus:ring-indigo-400"
                    />
                </div>
            </div>

            {/* Table */}
            <div className="overflow-x-auto rounded-xl border border-gray-200 dark:border-gray-700 dark:bg-gray-800">
                <table className="min-w-full text-base">
                    <thead className="border-b border-gray-100 dark:border-gray-600 bg-gray-50 dark:bg-gray-700">
                        <tr>
                            <th className="w-14 text-center">
                                <input
                                    type="checkbox"
                                    checked={selectAll}
                                    onChange={toggleSelectAll}
                                />
                            </th>
                            <th className="px-6 py-4 text-left font-medium text-gray-700 dark:text-gray-200 border-r">
                                Title
                            </th>
                            <th className="px-6 py-4 text-left font-medium text-gray-700 dark:text-gray-200 border-r">
                                Modal Title
                            </th>
                            <th className="px-6 py-4 text-left font-medium text-gray-700 dark:text-gray-200 border-r">
                                Image
                            </th>
                            <th className="px-6 py-4 text-left font-medium text-gray-700 dark:text-gray-200 border-r">
                                Created
                            </th>
                            <th className="px-6 py-4 text-left font-medium text-gray-700 dark:text-gray-200 border-r">
                                Updated
                            </th>
                            <th className="px-6 py-4 text-left font-medium text-gray-700 dark:text-gray-200">
                                Action
                            </th>
                        </tr>
                    </thead>
                    <tbody className="divide-y divide-gray-200 dark:divide-gray-600">
                        {loading ? (
                            <tr>
                                <td
                                    colSpan={7}
                                    className="px-6 py-4 text-center dark:text-gray-200"
                                >
                                    Loading...
                                </td>
                            </tr>
                        ) : paginatedData.length === 0 ? (
                            <tr>
                                <td
                                    colSpan={7}
                                    className="px-6 py-4 text-center dark:text-gray-200"
                                >
                                    No work types found
                                </td>
                            </tr>
                        ) : (
                            paginatedData.map((item) => (
                                <tr
                                    key={item.id}
                                    className="hover:bg-gray-50 dark:hover:bg-gray-700"
                                >
                                    <td className="w-14 text-center">
                                        <input
                                            type="checkbox"
                                            checked={selected.includes(item.id)}
                                            onChange={() =>
                                                toggleSelect(item.id)
                                            }
                                            className="w-5 h-5 rounded-sm"
                                        />
                                    </td>
                                    <td className="px-6 py-4 border-r text-left dark:text-gray-200 text-left text-base">
                                        {item.title.replace(/<[^>]*>?/gm, "")}
                                    </td>

                                    <td
                                        className="px-6 py-4 border-r text-left dark:text-gray-200 text-left text-base"
                                        dangerouslySetInnerHTML={{
                                            __html: item.modal_title,
                                        }}
                                    />
                                    <td className="px-6 py-4 border-r text-left">
                                        {item.modal_image ? (
                                            <img
                                                src={
                                                    item.modal_image ||
                                                    "/placeholder.png"
                                                }
                                                alt="modal"
                                                className="w-12 h-12 rounded object-cover"
                                            />
                                        ) : (
                                            <ImageIcon
                                                size={20}
                                                className="text-gray-400"
                                            />
                                        )}
                                    </td>
                                    <td className="px-6 py-4 border-r text-gray-700 dark:text-gray-200 text-left text-base">
                                        {formatDate(item.created_at)}
                                    </td>
                                    <td className="px-6 py-4 border-r text-gray-700 dark:text-gray-200 text-left text-base">
                                        {formatDate(item.updated_at)}
                                    </td>
                                    <td className="px-6 py-4 flex gap-3">
                                        <button
                                            onClick={() => openEditForm(item)}
                                            className="p-3 rounded hover:bg-yellow-100 text-yellow-600"
                                        >
                                            <Edit size={20} />
                                        </button>
                                        <button
                                            onClick={() =>
                                                handleDelete(item.id)
                                            }
                                            className="p-3 rounded hover:bg-red-100 text-red-600"
                                        >
                                            <Trash2 size={20} />
                                        </button>
                                    </td>
                                </tr>
                            ))
                        )}
                    </tbody>
                </table>
            </div>

            {/* Pagination */}
            <div className="flex flex-col md:flex-row justify-between items-center mt-4 gap-2 text-gray-700 dark:text-gray-300">
                <div>
                    Showing{" "}
                    {totalRows === 0 ? 0 : (currentPage - 1) * perPage + 1} to{" "}
                    {Math.min(currentPage * perPage, totalRows)} of {totalRows}{" "}
                    entries
                </div>
                <div className="flex flex-wrap items-center space-x-1">
                    <button
                        onClick={() =>
                            setCurrentPage((p) => Math.max(p - 1, 1))
                        }
                        disabled={currentPage === 1}
                        className="px-3 py-2 border rounded disabled:opacity-50 dark:border-gray-600"
                    >
                        Previous
                    </button>
                    {Array.from({ length: totalPages }, (_, i) => i + 1).map(
                        (num) => (
                            <button
                                key={num}
                                onClick={() => setCurrentPage(num)}
                                className={`px-3 py-2 border rounded dark:border-gray-600 ${
                                    num === currentPage
                                        ? "bg-blue-600 text-white"
                                        : ""
                                }`}
                            >
                                {num}
                            </button>
                        )
                    )}
                    <button
                        onClick={() =>
                            setCurrentPage((p) => Math.min(p + 1, totalPages))
                        }
                        disabled={currentPage === totalPages}
                        className="px-3 py-2 border rounded disabled:opacity-50 dark:border-gray-600"
                    >
                        Next
                    </button>
                </div>
            </div>
        </div>
    );
}
