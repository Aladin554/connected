// src/pages/Dashboard/WorkTypeForm.tsx
import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import api from "../../../api/axios";
import toast from "react-hot-toast";
import { Editor } from "@tinymce/tinymce-react";

export default function WorkTypeForm() {
  const { id } = useParams();
  const navigate = useNavigate();
  const isEdit = Boolean(id);

  const [form, setForm] = useState({
    title: "",
    modal_title: "",
    modal_description: "",
    modal_image: null as File | null,
  });

  const [preview, setPreview] = useState<string | null>(null);
  const [errors, setErrors] = useState({
    title: "",
    modal_title: "",
    modal_description: "",
    modal_image: "",
  });

  const [submitting, setSubmitting] = useState(false);

  // ✅ Load existing work type for editing
  useEffect(() => {
    if (isEdit) {
      api
        .get(`/categories/${id}`)
        .then((res) => {
          const data = res.data.data || res.data;
          setForm({
            title: data.title || "",
            modal_title: data.modal_title || "",
            modal_description: data.modal_description || "",
            modal_image: null,
          });

          if (data.modal_image) {
            const imageUrl = data.modal_image.startsWith("http")
              ? data.modal_image
              : `${import.meta.env.VITE_API_URL}/storage/${data.modal_image}`;
            setPreview(imageUrl);
          }
        })
        .catch(() => toast.error("Failed to load work type"));
    }
  }, [id, isEdit]);

  // ✅ Validate form
  const validateForm = () => {
    let valid = true;
    const newErrors = { title: "", modal_title: "", modal_description: "", modal_image: "" };

    if (!form.title.trim()) {
      newErrors.title = "Title is required.";
      valid = false;
    }
    if (!form.modal_title.trim()) {
      newErrors.modal_title = "Modal title is required.";
      valid = false;
    }

    setErrors(newErrors);
    return valid;
  };

  // ✅ Handle file change
  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0] || null;
    setForm({ ...form, modal_image: file });
    if (file) setPreview(URL.createObjectURL(file));
  };

  // ✅ Handle form submit
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!validateForm()) return;
    setSubmitting(true);

    try {
      const formData = new FormData();
      formData.append("title", form.title);
      formData.append("modal_title", form.modal_title);
      if (form.modal_description) formData.append("modal_description", form.modal_description);
      if (form.modal_image) formData.append("modal_image", form.modal_image);

      if (isEdit) {
        await api.post(`/categories/${id}?_method=PUT`, formData, {
          headers: { "Content-Type": "multipart/form-data" },
        });
        toast.success("Work Type updated successfully!");
      } else {
        await api.post("/categories", formData, {
          headers: { "Content-Type": "multipart/form-data" },
        });
        toast.success("Work Type created successfully!");
      }

      navigate("/dashboard/categories");
    } catch (err: any) {
      const message =
        err.response?.data?.message || "Something went wrong while saving the work type";
      toast.error(message);
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className="p-10 md:p-16 border border-gray-200 rounded-2xl dark:border-gray-700 dark:bg-gray-900 shadow-sm max-w-5xl mx-auto w-full">
      <h1 className="text-2xl font-semibold mb-6 dark:text-gray-200">
        {isEdit ? "Edit Work Type" : "Add New Work Type"}
      </h1>

      <form onSubmit={handleSubmit} className="space-y-6 w-full">
        {/* Title using TinyMCE */}
        <div>
          <label className="block mb-1 text-sm font-medium dark:text-gray-300">Title</label>
          <Editor
            apiKey="3cpmmfl6xjoq28sx75olwzo4ps8j52qgea6efpx28fz70i0v"
            disabled={submitting}
            value={form.title}
            onEditorChange={(content) => setForm({ ...form, title: content })}
            init={{
              height: 300,
              menubar: true,
              plugins: ["advlist autolink lists link image charmap print preview anchor",
                        "searchreplace visualblocks code fullscreen",
                        "insertdatetime media table paste code help wordcount"],
              toolbar: "undo redo | formatselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | help",
              skin: "oxide-dark",
              content_css: "dark",
            }}
          />
          {errors.title && <p className="text-red-500 text-sm mt-1">{errors.title}</p>}
        </div>

        {/* Modal Title */}
        <div>
          <label className="block mb-1 text-sm font-medium dark:text-gray-300">Modal Title</label>
          <input
            type="text"
            disabled={submitting}
            value={form.modal_title}
            onChange={(e) => setForm({ ...form, modal_title: e.target.value })}
            className={`w-full border px-3 py-2 rounded-lg text-lg dark:bg-gray-700 dark:text-gray-200 focus:outline-none focus:ring-2 ${
              errors.modal_title ? "focus:ring-red-500 border-red-500" : "focus:ring-blue-500"
            }`}
          />
          {errors.modal_title && <p className="text-red-500 text-sm mt-1">{errors.modal_title}</p>}
        </div>

        {/* Modal Description */}
        <div>
          <label className="block mb-1 text-sm font-medium dark:text-gray-300">Modal Description</label>
          <Editor
            apiKey="3cpmmfl6xjoq28sx75olwzo4ps8j52qgea6efpx28fz70i0v"
            disabled={submitting}
            value={form.modal_description}
            onEditorChange={(content) => setForm({ ...form, modal_description: content })}
            init={{
              height: 300,
              menubar: true,
              plugins: ["advlist autolink lists link image charmap print preview anchor",
                        "searchreplace visualblocks code fullscreen",
                        "insertdatetime media table paste code help wordcount"],
              toolbar: "undo redo | formatselect | bold italic backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | help",
              skin: "oxide-dark",
              content_css: "dark",
            }}
          />
        </div>

        {/* Image Upload */}
        <div>
          <label className="block mb-1 text-sm font-medium dark:text-gray-300">Modal Image</label>
          <input
            type="file"
            accept="image/*"
            onChange={handleFileChange}
            disabled={submitting}
            className="block w-full text-gray-300 dark:text-gray-200 border border-gray-300 dark:border-gray-600 rounded-lg cursor-pointer bg-gray-50 dark:bg-gray-700"
          />
          {preview && (
            <img
              src={preview}
              alt="Preview"
              className="w-32 h-32 object-cover mt-3 rounded-lg border dark:border-gray-600"
            />
          )}
          {errors.modal_image && <p className="text-red-500 text-sm mt-1">{errors.modal_image}</p>}
        </div>

        {/* Buttons */}
        <div className="flex justify-end gap-3">
          <button
            type="button"
            onClick={() => navigate("/dashboard/categories")}
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
