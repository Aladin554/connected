import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css"; // required CSS

import SignIn from "./pages/AuthPages/SignIn";
import SignUp from "./pages/AuthPages/SignUp";
import ForgotPassword from "./pages/AuthPages/ForgotPassword";
import ResetPassword from "./pages/AuthPages/ResetPassword";
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
import RootRedirect from "./components/RootRedirect";

import Home from "./pages/Dashboard/Home";
import AdminUsers from "./pages/Admin/AdminUsers";
import AdminUserForm from "./pages/Admin/AdminUserForm";
import Industry from "./pages/Admin/Industry/Industry.tsx";
import IndustryForm from "./pages/Admin/Industry/IndustryForm.tsx";
import QuestionnaireAnswer from "./pages/Admin/QA/QuestionnaireAnswer.tsx";
import QAForm from "./pages/Admin/QA/QAForm.tsx";

import UserDashboard from "./pages/Dashboard/UserDashboard";
import Profile from "./pages/Profile/EditProfile";
import Introduction from "./pages/User/pages/Introduction";
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
import QACompletion from "./pages/User/pages/QACompletion.tsx";

import AdminDepartments from "./pages/Admin/Department/AdminDepartments.tsx";
import AdminDepartmentForm from "./pages/Admin/Department/AdminDepartmentForm.tsx";
import Report from "./pages/Admin/Report/Report.tsx";
import ReportDetails from "./pages/Admin/Report/ReportDetails.tsx";
import Departments from "./pages/Admin/CommonDepartment/Departments.tsx";
import DepartmentForm from "./pages/Admin/CommonDepartment/DepartmentForm.tsx";
import MyReport from "./pages/User/pages/MyReport.tsx";
import IndustryData from "./pages/User/pages/IndustryData.tsx";
import AdminSubDepartments from "./pages/Admin/SubDepartment/AdminSubDepartments.tsx";
import AdminSubDepartmentForm from "./pages/Admin/SubDepartment/AdminSubDepartmentForm.tsx";
import ChooseDashboard from "./components/auth/ChooseDashboard.tsx";
import AdminAllowedIps from "./pages/Admin/Security/AdminAllowedIps.tsx";


export default function App() {
  return (
    <Router>
      <ScrollToTop />

      {/* ToastContainer added at root so toast shows on any page */}
      <ToastContainer
  position="top-right"
  autoClose={3000}
  hideProgressBar
  toastStyle={{ zIndex: 100000 }} // <-- make it very high
/>


      <Routes>
        <Route path="/" element={<RootRedirect />} />
        <Route path="/signin" element={<SignIn />} />
        <Route path="/signup" element={<SignUp />} />
        <Route path="/forgot-password" element={<ForgotPassword />} />
        <Route path="/reset-password" element={<ResetPassword />} />
        <Route path="/choose-dashboard" element={<ProtectedRoute allowedRoles={[2]}><ChooseDashboard /></ProtectedRoute>}/>

        {/* User routes */}
        <Route path="/user-dashboard" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><UserDashboard /></ProtectedRoute>} />
        <Route path="/industry-data" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><IndustryData /></ProtectedRoute>} />
        <Route path="/profile" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><Profile /></ProtectedRoute>} />
        <Route
            path="/my-report"
            element={
              <ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}>
                <MyReport />
              </ProtectedRoute>
            }
          />
        <Route path="/introduction" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><Introduction /></ProtectedRoute>} />
        <Route path="/instructions" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><Instructions /></ProtectedRoute>} />
        <Route path="/tip" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><Tip /></ProtectedRoute>} />
        <Route path="/sort-cards" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><Sort /></ProtectedRoute>} />
        <Route path="/pick-top" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><PickTop /></ProtectedRoute>} />
        <Route path="/sort-three-challenge-card" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><ChallengeCards /></ProtectedRoute>} />
        <Route path="/selected-three-challenge-card" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><SelectedChallenges /></ProtectedRoute>} />
        <Route path="/phases-instructions" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><SpecificChallenge /></ProtectedRoute>} />
        <Route path="/select-specific-sort-three-challenge-card" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><SelectSpecificChallenge /></ProtectedRoute>} />
        <Route path="/success-page" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><SuccessPage /></ProtectedRoute>} />
        <Route path="/first-phases" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><OneSpecificChallenge /></ProtectedRoute>} />
        <Route path="/secound-phases" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><SelectedDepartments /></ProtectedRoute>} />
        <Route path="/selected-data" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><SelectedData /></ProtectedRoute>} />
        <Route path="/qa-instructions" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><QAInstructions /></ProtectedRoute>} />
        <Route path="/process-done" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><QACompletion /></ProtectedRoute>} />
        <Route path="/questionnaire" element={<ProtectedRoute allowedRoles={[2, 3]} requireActivePanel={true}><Questionnaire /></ProtectedRoute>} />

        {/* Admin dashboard routes */}
        <Route path="/dashboard/*" element={<ProtectedRoute allowedRoles={[1, 2]}><AppLayout /></ProtectedRoute>}>
          <Route index element={<Home />} />
          <Route path="profile" element={<UserProfiles />} />
          <Route path="calendar" element={<Calendar />} />
          <Route path="blank" element={<Blank />} />
          <Route path="form-elements" element={<FormElements />} />
          <Route path="basic-tables" element={<BasicTables />} />
          <Route path="alerts" element={<Alerts />} />
          <Route path="avatars" element={<Avatars />} />
          <Route path="badges" element={<Badges />} />
          <Route path="buttons" element={<Buttons />} />
          <Route path="images" element={<Images />} />
          <Route path="videos" element={<Videos />} />
          <Route path="line-chart" element={<LineChart />} />
          <Route path="bar-chart" element={<BarChart />} />
          <Route path="admin-users" element={<AdminUsers />} />
          <Route path="admin-users/add" element={<AdminUserForm />} />
          <Route path="admin-users/:id/edit" element={<AdminUserForm />} />
          <Route path="users-report" element={<Report />} />
          <Route path="reports/:id" element={<ReportDetails />} />
          {/* Categories (Previously Departments) */}
          <Route path="categories" element={<AdminDepartments />} />
          <Route path="categories/add" element={<AdminDepartmentForm />} />
          <Route path="categories/:id/edit" element={<AdminDepartmentForm />} />

          {/* Departments (Previously Sub-Departments) */}
          <Route path="departments" element={<AdminSubDepartments />} />
          <Route path="departments/add" element={<AdminSubDepartmentForm />} />
          <Route path="departments/:id/edit" element={<AdminSubDepartmentForm />} />



          <Route path="common-departments" element={<Departments />} />
          <Route path="common-departments/add" element={<DepartmentForm />} />
          <Route path="common-departments/:id/edit" element={<DepartmentForm />} />
          <Route
            path="admin-allowed-ips"
            element={
              <ProtectedRoute allowedRoles={[1]}>
                <AdminAllowedIps />
              </ProtectedRoute>
            }
          />

          <Route path="industry" element={<Industry />} />
          <Route path="industry/add" element={<IndustryForm />} />
          <Route path="industry/:id/edit" element={<IndustryForm />} />
          <Route path="question-answers" element={<QuestionnaireAnswer />} />
          <Route path="question-answers/add" element={<QAForm />} />
          <Route path="question-answers/:id/edit" element={<QAForm />} />
        </Route>

        <Route path="*" element={<NotFound />} />
      </Routes>
    </Router>
  );
}
