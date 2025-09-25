import { Navigate } from "react-router-dom";
import { ReactNode } from "react";

type ProtectedRouteProps = {
  children: ReactNode;
};

const ProtectedRoute = ({ children }: ProtectedRouteProps) => {
  const isAuthenticated = localStorage.getItem("auth") === "true";
  return isAuthenticated ? <>{children}</> : <Navigate to="/signin" replace />;
};

export default ProtectedRoute;
