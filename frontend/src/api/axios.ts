import axios from "axios";

// Create an axios instance
const api = axios.create({
  baseURL: "/api", // all requests will be prefixed with /api
});

// Attach token automatically
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem("token");
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => Promise.reject(error)
);

export default api;
