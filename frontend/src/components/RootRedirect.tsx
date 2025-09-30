import { useState, useEffect } from "react";
import { Navigate } from "react-router-dom";

const RootRedirect = () => {
  const [token, setToken] = useState<string | null>(null);
  const [roleId, setRoleId] = useState<number | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const t = sessionStorage.getItem("token");
    const role = sessionStorage.getItem("role_id");
    setToken(t);
    setRoleId(role ? parseInt(role, 10) : null);
    setLoading(false);
  }, []);

  if (loading) return null; // You can replace null with a spinner

  if (!token) return <Navigate to="/signin" replace />;

  // Role-based redirect
  if (roleId === 3) return <Navigate to="/user-dashboard" replace />;

  // Default dashboard for other roles
  return <Navigate to="/dashboard" replace />;
};

export default RootRedirect;
