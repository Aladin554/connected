import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import SignIn from "./pages/AuthPages/SignIn";
import SignUp from "./pages/AuthPages/SignUp";
import NotFound from "./pages/OtherPage/NotFound";
import UserProfiles from "./pages/UserProfiles";
import Videos from "./pages/UiElements/Videos";
import Images from "./pages/UiElements/Images";
import Alerts from "./pages/UiElements/Alerts";
import Badges from "./pages/UiElements/Badges";
import Avatars from "./pages/UiElements/Avatars";
import Buttons from "./pages/UiElements/Buttons";
import LineChart from "./pages/Charts/LineChart";
import BarChart from "./pages/Charts/BarChart";
import Calendar from "./pages/Calendar";
import BasicTables from "./pages/Tables/BasicTables";
import FormElements from "./pages/Forms/FormElements";
import Blank from "./pages/Blank";
import AppLayout from "./layout/AppLayout";
import { ScrollToTop } from "./components/common/ScrollToTop";
import ProtectedRoute from "./components/ProtectedRoute";
import Home from "./pages/Dashboard/Home";
import AdminUsers from "./pages/Admin/AdminUsers";
import AdminUserForm from "./pages/Admin/AdminUserForm";
import WorkType from "./pages/Admin/WorkType/WorkType";
import WorkTypeForm from "./pages/Admin/WorkType/WorkTypeForm";
import RootRedirect from "./components/RootRedirect";
import UserDashboard from "./pages/Dashboard/UserDashboard"; // role 3 special dashboard
import Profile from "./pages/Profile/EditProfile"; // role 3 Profile
import Introduction from "./pages/User/pages/Introduction"; // ✅ add Introduction page
import Instructions from "./pages/User/pages/Instructions";
import Tip from "./pages/User/pages/Tip";
import Sort from "./pages/User/pages/Sort";
import PickTop from "./pages/User/pages/PickTop";
import ChallengeCards from "./pages/User/pages/ChallengeCards";
import SelectedChallenges from "./pages/User/pages/SelectedChallenges.tsx";
import SpecificChallenge from "./pages/User/pages/SpecificChallenge.tsx";
import OneSpecificChallenge from "./pages/User/pages/OneSpecificChallenge.tsx";
import SelectSpecificChallenge from "./pages/User/pages/SelectSpecificChallenge.tsx";
import SuccessPage from "./pages/User/pages/SuccessPage.tsx";
import SelectedDepartments from "./pages/User/pages/SelectedDepartments.tsx";
import SelectedData from "./pages/User/pages/SelectedData.tsx";
import QAInstructions from "./pages/User/pages/QAInstructions.tsx";
import Questionnaire from "./pages/User/pages/Questionnaire.tsx";

export default function App() {
  return (
    <Router>
      <ScrollToTop />
      <Routes>
        {/* Root Redirect */}
        <Route path="/" element={<RootRedirect />} />

        {/* Auth Pages */}
        <Route path="/signin" element={<SignIn />} />
        <Route path="/signup" element={<SignUp />} />

        {/* Special Dashboard for role 3 */}
        <Route
          path="/user-dashboard"
          element={
            <ProtectedRoute allowedRoles={[3]}>
              <UserDashboard />
            </ProtectedRoute>
          }
        />
        <Route
          path="/profile"
          element={
            <ProtectedRoute allowedRoles={[3]}>
              <Profile />
            </ProtectedRoute>
          }
        />

        {/* ✅ New Introduction route for role 3 */}
        <Route
          path="/introduction"
          element={
            <ProtectedRoute allowedRoles={[3]}>
              <Introduction />
            </ProtectedRoute>
          }
        />
        <Route
  path="/instructions"
  element={
    <ProtectedRoute allowedRoles={[3]}> {/* adjust roles if needed */}
      <Instructions />
    </ProtectedRoute>
  }
/>
<Route
  path="/tip"
  element={
    <ProtectedRoute allowedRoles={[3]}>
      <Tip />
    </ProtectedRoute>
  }
/>
<Route
  path="/sort-cards"
  element={
    <ProtectedRoute allowedRoles={[3]}>
      <Sort />
    </ProtectedRoute>
  }
/>
<Route
  path="/pick-top"
  element={
    <ProtectedRoute allowedRoles={[3]}>
      <PickTop />
    </ProtectedRoute>
  }
/>
 <Route path="/sort-three-challenge-card"
  element={
    <ProtectedRoute allowedRoles={[3]}>
      <ChallengeCards />
    </ProtectedRoute>
  }
/>
 <Route path="/selected-three-challenge-card"
  element={
    <ProtectedRoute allowedRoles={[3]}>
      <SelectedChallenges />
    </ProtectedRoute>
  }
/>
 <Route path="/phases-instructions"
  element={
    <ProtectedRoute allowedRoles={[3]}>
      <SpecificChallenge />
    </ProtectedRoute>
  }
/>
 <Route path="/select-specific-sort-three-challenge-card"
  element={
    <ProtectedRoute allowedRoles={[3]}>
      <SelectSpecificChallenge />
    </ProtectedRoute>
  }
/>
 <Route path="/success-page"
  element={
    <ProtectedRoute allowedRoles={[3]}>
      <SuccessPage />
    </ProtectedRoute>
  }
/>
 <Route path="/first-phases"
  element={
    <ProtectedRoute allowedRoles={[3]}>
      <OneSpecificChallenge />
    </ProtectedRoute>
  }
/>
 <Route path="/secound-phases"
  element={
    <ProtectedRoute allowedRoles={[3]}>
      <SelectedDepartments />
    </ProtectedRoute>
  }
/>
 <Route path="/selected-data"
  element={
    <ProtectedRoute allowedRoles={[3]}>
      <SelectedData />
    </ProtectedRoute>
  }
/>
 <Route path="/qa-instructions"
  element={
    <ProtectedRoute allowedRoles={[3]}>
      <QAInstructions />
    </ProtectedRoute>
  }
/>
 <Route path="/questionnaire"
  element={
    <ProtectedRoute allowedRoles={[3]}>
      <Questionnaire />
    </ProtectedRoute>
  }
/>

        {/* Dashboard Layout - Protected */}
        <Route
          path="/dashboard/*"
          element={
            <ProtectedRoute allowedRoles={[1, 2]}>
              <AppLayout />
            </ProtectedRoute>
          }
        >
          {/* Default Dashboard */}
          <Route index element={<Home />} />

          {/* Misc Pages */}
          <Route path="profile" element={<UserProfiles />} />
          <Route path="calendar" element={<Calendar />} />
          <Route path="blank" element={<Blank />} />

          {/* Forms */}
          <Route path="form-elements" element={<FormElements />} />

          {/* Tables */}
          <Route path="basic-tables" element={<BasicTables />} />

          {/* UI Elements */}
          <Route path="alerts" element={<Alerts />} />
          <Route path="avatars" element={<Avatars />} />
          <Route path="badges" element={<Badges />} />
          <Route path="buttons" element={<Buttons />} />
          <Route path="images" element={<Images />} />
          <Route path="videos" element={<Videos />} />

          {/* Charts */}
          <Route path="line-chart" element={<LineChart />} />
          <Route path="bar-chart" element={<BarChart />} />

          {/* Admin Pages */}
          <Route path="admin-users" element={<AdminUsers />} />
          <Route path="admin-users/add" element={<AdminUserForm />} />
          <Route path="admin-users/:id/edit" element={<AdminUserForm />} />

          <Route path="categories" element={<WorkType />} />
          <Route path="categories/add" element={<WorkTypeForm />} />
          <Route path="categories/:id/edit" element={<WorkTypeForm />} />
        </Route>

        {/* Fallback */}
        <Route path="*" element={<NotFound />} />
      </Routes>
    </Router>
  );
}
