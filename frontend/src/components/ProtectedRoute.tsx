// components/ProtectedRoute.tsx
import { ReactNode, useState, useEffect } from "react";
import { Navigate } from "react-router-dom";

type ProtectedRouteProps = {
  children: ReactNode;
  allowedRoles?: number[]; // optional array of allowed role_ids
};

const ProtectedRoute = ({ children, allowedRoles }: ProtectedRouteProps) => {
  const [token, setToken] = useState<string | null>(null);
  const [roleId, setRoleId] = useState<number | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const storedToken = sessionStorage.getItem("token");
    const storedRole = sessionStorage.getItem("role_id");
    setToken(storedToken);
    setRoleId(storedRole ? parseInt(storedRole, 10) : null);
    setLoading(false);
  }, []);

  if (loading) return null; // optional spinner

  // Not logged in
  if (!token) return <Navigate to="/signin" replace />;

  // Role restriction
  if (allowedRoles && roleId !== null && !allowedRoles.includes(roleId)) {
    switch (roleId) {
      case 3:
        return <Navigate to="/user-dashboard" replace />; // role 3 redirect
      default:
        return <Navigate to="/dashboard" replace />; // other unauthorized roles
    }
  }

  return <>{children}</>;
};

export default ProtectedRoute;
