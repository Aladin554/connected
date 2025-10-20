// E:\connectedreact\connected\frontend\src\pages\User\Header.tsx
import { useNavigate } from "react-router-dom";

interface HeaderProps {
  userName: string;
  onLogout: () => void;
}

export default function Header({ userName, onLogout }: HeaderProps) {
  const navigate = useNavigate();

  const handleProfileClick = () => {
    navigate("/profile");
  };

  return (
    <header className="max-w-7xl mx-auto px-6 py-4">
      <div className="flex items-center justify-between w-full">
        <div
          onClick={() => navigate("/user-dashboard")}
          className="cursor-pointer text-xl font-serif font-semibold tracking-tight hover:text-gray-300 transition"
          style={{ fontSize: "1.25rem", lineHeight: "1.75rem" }}
        >
          Connected.
        </div>
        <div className="flex items-center gap-4">
          <button
            onClick={handleProfileClick}
            className="inline-block bg-blue-500/90 px-3 py-1 rounded-full text-xs font-medium"
          >
            {userName || "Loading..."}
          </button>
          <button
            onClick={onLogout}
            className="border border-white/30 px-3 py-1 rounded-full text-xs"
          >
            Logout
          </button>
        </div>
      </div>
      <div className="h-px bg-white/50 mt-4"></div>
    </header>
  );
}
