import { useState, useEffect } from "react";
import { Navigate } from "react-router-dom";

const RootRedirect = () => {
  const [token, setToken] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const t = localStorage.getItem("token");
    setToken(t);
    setLoading(false);
  }, []);

  if (loading) return null; // You can replace null with a spinner if you want

  return token ? <Navigate to="/dashboard" replace /> : <Navigate to="/signin" replace />;
};

export default RootRedirect;
