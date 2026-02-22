-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 22, 2026 at 12:31 AM
-- Server version: 11.8.3-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u551499163_connected_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_allowed_ips`
--

CREATE TABLE `admin_allowed_ips` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ip` varchar(64) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_allowed_ips`
--

INSERT INTO `admin_allowed_ips` (`id`, `ip`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
(1, '110.54.224.169', 'Imported from admin_security.allowed_ips', 1, '2026-02-19 08:32:16', '2026-02-19 08:32:16'),
(2, '112.198.75.123', 'Imported from admin_security.allowed_ips', 1, '2026-02-19 08:32:16', '2026-02-19 08:32:16'),
(3, '203.87.50.200', 'Imported from admin_security.allowed_ips', 1, '2026-02-19 08:32:16', '2026-02-19 08:32:16');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `common_departments`
--

CREATE TABLE `common_departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `details` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `common_departments`
--

INSERT INTO `common_departments` (`id`, `name`, `details`, `created_at`, `updated_at`) VALUES
(1, 'Accounting', 'Handle financial record-keeping, ensure compliance with accounting standards, prepare financial statements, and manage audits.', '2025-11-16 21:53:56', '2025-11-16 21:53:56'),
(2, 'Business Development', 'Identify and pursue new business opportunities, build partnerships, and develop strategies to expand the company’s market presence.', '2025-11-16 21:54:05', '2025-11-16 21:54:05'),
(3, 'Compliance', 'Ensure the company adheres to all relevant laws, regulations, and internal policies, mitigating legal and regulatory risks.', '2025-11-16 21:54:21', '2025-11-16 21:54:21'),
(4, 'Customer Service', 'Provide support to customers, addressing inquiries and resolving issues to ensure high levels of customer satisfaction.', '2025-11-16 21:54:32', '2025-11-16 21:54:32'),
(5, 'Finance', 'Manage the company’s financial resources, including budgeting, financial planning, and compliance.', '2025-11-16 21:54:43', '2025-11-16 21:54:43'),
(6, 'Human Resources (HR)', 'Oversee recruitment, employee development, compensation, and compliance with labor laws, ensuring a skilled and motivated workforce.', '2025-11-16 21:55:50', '2025-11-16 21:55:50');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `industry_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `details` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `industry_id`, `name`, `details`, `created_at`, `updated_at`) VALUES
(8, 1, 'Patient Care Services', '<p>Deliver direct medical care and support to patients through various healthcare services, including emergency, surgical, and rehabilitative care.</p>', '2025-12-13 08:32:42', '2025-12-13 08:32:42'),
(9, 1, 'Specialized Medical Departments', '<p class=\"MsoNormal\">Provide focused medical expertise and treatment for specific health conditions and patient demographics, ranging from cardiology to pediatrics.</p>', '2025-12-13 08:32:55', '2025-12-13 08:32:55'),
(10, 1, 'Diagnostic and Therapeutic Services', '<p>Conduct diagnostic tests and therapeutic interventions to accurately diagnose and treat medical conditions, enhancing patient health outcomes.</p>', '2025-12-13 08:33:13', '2025-12-13 08:33:13'),
(11, 1, 'Medical Support and Research', '<p>Offer essential medical support functions, manage medication dispensing, and advance medical knowledge through research and education.</p>', '2025-12-13 08:33:24', '2025-12-13 08:33:24'),
(12, 2, 'Development and Engineering', '<p>Design, develop, and maintain software and systems that power businesses, enhance performance, and drive innovation.</p>', '2025-12-13 08:34:26', '2025-12-13 08:34:26'),
(13, 2, 'Security and Administration', '<p>Protect, manage, and optimize IT systems and networks to ensure security, reliability, and seamless operation.</p>', '2025-12-13 08:34:37', '2025-12-13 08:34:37'),
(14, 2, 'Quality and Support', '<p>Ensure software quality, clear communication, and user satisfaction through testing and technical assistance.</p>', '2025-12-13 08:34:47', '2025-12-13 08:34:47'),
(15, 2, 'Data and Analytics', '<p>Use data-driven technologies to generate insights, optimize performance, and enable smarter decision-making.</p>', '2025-12-13 08:34:58', '2025-12-13 08:34:58'),
(16, 2, 'Design and Experience', '<p>Create engaging and efficient digital experiences that meet user needs and ensure system scalability.</p>', '2025-12-13 08:35:42', '2025-12-13 08:35:42'),
(17, 3, 'Financial Management', '<p>Oversee financial resources, investments, and compliance to ensure business stability, profitability, and long-term growth.</p>', '2025-12-13 08:36:07', '2025-12-13 08:36:07'),
(18, 3, 'Risk and Compliance', '<h3>Identify, assess, and mitigate risks while ensuring adherence to financial laws, regulations, and corporate governance.</h3>', '2025-12-13 08:36:20', '2025-12-13 08:36:20'),
(19, 3, 'Strategic and Investment Management', '<p>Plan and execute strategies that drive growth, attract investors, and optimize investment portfolios for long-term success.&nbsp;</p>', '2025-12-13 08:36:41', '2025-12-13 08:36:41'),
(20, 3, 'Advisory and Analytics', '<p>Provide insights, analysis, and expert advice to enhance financial performance, planning, and economic decision-making.</p>', '2025-12-13 08:37:25', '2025-12-13 08:37:25'),
(21, 3, 'Asset and Resource Management', '<p>Manage and optimize physical and financial assets to maximize efficiency, value, and organizational sustainability.</p>', '2025-12-13 08:37:37', '2025-12-13 08:37:37'),
(22, 4, 'Core Engineering Disciplines', '<p>Design, develop, and maintain physical and technical systems that form the foundation of modern industry and infrastructure.</p>', '2025-12-13 08:39:33', '2025-12-13 08:39:33'),
(23, 4, 'Specialized Engineering Disciplines', '<p>Advance innovation by applying specialized knowledge to address complex technical, environmental, and societal challenges.</p>', '2025-12-13 08:39:44', '2025-12-13 08:39:44'),
(24, 4, 'Systems and Process Optimization', '<p>Streamline operations, integrate technologies, and improve systems to enhance productivity and sustainability across industries.</p>', '2025-12-13 08:39:53', '2025-12-13 08:39:53'),
(25, 4, 'Quality and Support Functions', '<p>Maintain engineering excellence through documentation, compliance, and continuous improvement.</p>', '2025-12-13 08:40:03', '2025-12-13 08:40:03'),
(26, 6, 'Academic Management', '<p>Plan and oversee academic programs, curriculum development, and institutional policies to support effective teaching and learning.</p>', '2025-12-25 21:42:35', '2025-12-25 21:42:35'),
(27, 6, 'Student Services', '<p>Provide academic, personal, and career support services to enhance student wellbeing, engagement, and success.</p>', '2025-12-25 21:42:49', '2025-12-25 21:42:49'),
(28, 6, 'Faculty and Staff Support', '<p>Support recruitment, development, and performance of faculty and staff to maintain effective educational operations.</p>', '2025-12-25 21:43:03', '2025-12-25 21:43:03'),
(29, 6, 'Quality and Evaluation', '<p>Monitor academic standards, assess performance, and ensure continuous improvement through evaluation and accreditation processes.</p>', '2025-12-25 21:43:16', '2025-12-25 21:43:16'),
(30, 6, 'Resource Management', '<p>Manage financial, physical, and technological resources to support educational programs and institutional sustainability.</p>', '2025-12-25 21:43:35', '2025-12-25 21:43:35'),
(31, 6, 'Community and Outreach', '<p data-start=\"962\" data-end=\"1110\">Build partnerships and engage with communities to promote access, collaboration, and the social impact of education.</p>', '2025-12-25 21:43:49', '2025-12-25 21:43:49'),
(32, 7, 'Creative and Production', '<p>Develop and produce artistic and cultural works through creative practice, research, and production processes.</p>', '2025-12-25 21:45:50', '2025-12-25 21:45:50'),
(33, 7, 'Exhibition and Curation', '<p>Plan, curate, and manage exhibitions and collections to present artistic and cultural content to diverse audiences.</p>', '2025-12-25 21:46:03', '2025-12-25 21:46:03'),
(34, 7, 'Education and Outreach', '<p>Deliver educational programs and outreach initiatives to promote cultural understanding and public engagement.</p>', '2025-12-25 21:46:18', '2025-12-25 21:46:18'),
(35, 7, 'Support and Administration', '<p>Manage administrative, financial, and operational activities that support arts and cultural organizations.</p>', '2025-12-25 21:46:56', '2025-12-25 21:46:56'),
(36, 7, 'Documentation and Publications', '<p>Research, document, and publish cultural, historical, and creative works to preserve and share knowledge.</p>', '2025-12-25 21:47:12', '2025-12-25 21:47:12'),
(37, 9, 'Research and Discovery', '<p>Conduct scientific research to generate new knowledge, test hypotheses, and advance understanding across disciplines.</p>', '2025-12-25 21:49:18', '2025-12-25 21:49:18'),
(38, 9, 'Experimental and Data Management', '<p>Design experiments and collect, analyze, and manage data to support accurate and reliable research outcomes.</p>', '2025-12-25 21:49:33', '2025-12-25 21:49:33'),
(39, 9, 'Laboratory and Equipment Management', '<p>Maintain laboratory facilities, equipment, and safety standards to support effective scientific research.</p>', '2025-12-25 21:49:48', '2025-12-25 21:49:48'),
(40, 9, 'Publication and Funding', '<p>Prepare research publications and secure funding through grants and proposals to support ongoing scientific work.</p>', '2025-12-25 21:50:02', '2025-12-25 21:50:02'),
(41, 9, 'Collaboration and Compliance', '<p style=\"text-align: left;\">Coordinate research collaborations and ensure compliance with ethical, regulatory, and institutional requirements.</p>', '2025-12-25 21:50:18', '2025-12-25 21:50:18'),
(42, 9, 'Training and Knowledge Management', '<p>Develop skills, share knowledge, and train researchers to support capacity building and scientific advancement.</p>', '2025-12-25 21:50:34', '2025-12-25 21:50:34'),
(43, 9, 'Quality Assurance', '<p>Implement quality control processes to ensure research accuracy, reproducibility, and adherence to standards.</p>', '2025-12-25 21:50:51', '2025-12-25 21:50:51'),
(44, 10, 'Client Support and Advocacy', '<p data-start=\"221\" data-end=\"367\">Provide direct assistance and advocate for individuals and families to access essential services and support.</p>\n<p data-start=\"369\" data-end=\"509\">&nbsp;</p>', '2025-12-25 21:55:33', '2025-12-25 21:55:33'),
(45, 10, 'Mental Health and Counseling', '<p data-start=\"369\" data-end=\"509\">Deliver counseling and mental health services to support emotional wellbeing and personal development.</p>\n<p data-start=\"511\" data-end=\"640\">&nbsp;</p>', '2025-12-25 21:55:47', '2025-12-25 21:55:47'),
(46, 10, 'Community and Outreach Services', '<p>Engage communities and deliver programs that address social needs and promote inclusion.</p>', '2025-12-25 21:55:58', '2025-12-25 21:55:58'),
(47, 10, 'Employment and Housing Services', '<p>Support individuals in securing employment and stable housing to improve economic independence and stability.</p>', '2025-12-25 21:56:13', '2025-12-25 21:56:13'),
(48, 10, 'Health and Nutrition Services', '<p>Provide health, nutrition, and wellness support to improve quality of life and overall wellbeing.</p>', '2025-12-25 21:56:25', '2025-12-25 21:56:25'),
(49, 10, 'Education and Volunteer Coordination', '<p>Coordinate educational programs and manage volunteers to support service delivery and community engagement.</p>', '2025-12-25 21:56:38', '2025-12-25 21:56:38'),
(50, 10, 'Advocacy and Policy', '<p data-start=\"1087\" data-end=\"1224\">Advocate for policy changes and social initiatives that address systemic issues and improve social outcomes.</p>', '2025-12-25 21:56:50', '2025-12-25 21:56:50'),
(51, 11, 'Legal and Judicial Services', '<p>Provide legal representation, adjudication, and court services to uphold justice and the rule of law.</p>', '2025-12-25 22:03:46', '2025-12-25 22:03:46'),
(52, 11, 'Investigation and Enforcement', '<p>Conduct investigations and enforce laws to prevent crime and ensure public safety.</p>', '2025-12-25 22:03:57', '2025-12-25 22:03:57'),
(53, 11, 'Community and Rehabilitation Services', '<p>Deliver rehabilitation, reintegration, and support programs to reduce reoffending and promote community safety.</p>', '2025-12-25 22:04:15', '2025-12-25 22:04:15'),
(54, 11, 'Specialized Services and Training', '<p>Provide specialized legal, forensic, and justice-related training and services to support professional practice.</p>', '2025-12-25 22:04:50', '2025-12-25 22:04:50'),
(55, 11, 'Policy and Advocacy', '<p data-start=\"814\" data-end=\"942\">Develop and advocate for laws, policies, and reforms to improve justice systems and legal outcomes.</p>', '2025-12-25 22:05:02', '2025-12-25 22:05:02'),
(56, 12, 'Content and Editorial Management', '<p>Plan, create, and manage content to ensure accurate, relevant, and effective communication across media platforms.</p>', '2025-12-25 22:13:57', '2025-12-25 22:13:57'),
(57, 12, 'Production and Creative Services', '<p>Produce visual, audio, and digital media content through creative development and technical production processes.</p>', '2025-12-25 22:14:17', '2025-12-25 22:14:17'),
(58, 12, 'Broadcasting and Distribution', '<p data-start=\"548\" data-end=\"689\">Deliver media content through broadcast, digital, and distribution channels to reach target audiences.</p>', '2025-12-25 22:14:38', '2025-12-25 22:14:38'),
(59, 12, 'Audience Engagement and Development', '<p>Build and maintain audience relationships through strategic communication, marketing, and engagement initiatives.</p>', '2025-12-25 22:14:58', '2025-12-25 22:14:58'),
(60, 12, 'Talent and Media Relations', '<p>Manage relationships with media professionals, talent, and stakeholders to support content delivery and public presence.</p>', '2025-12-25 22:15:22', '2025-12-25 22:15:22'),
(61, 12, 'Analytics and Insights', '<p>Analyze media performance and audience data to inform content strategy and improve communication effectiveness.</p>', '2025-12-25 22:15:52', '2025-12-25 22:15:52'),
(62, 13, 'Environmental Research and Conservation', '<p>Conduct research and conservation activities to protect ecosystems, biodiversity, and natural environments.</p>', '2025-12-25 22:21:27', '2025-12-25 22:21:27'),
(63, 13, 'Sustainable Practices and Development', '<p>Develop and implement sustainable practices that balance environmental protection with economic and social development.</p>', '2025-12-25 22:21:48', '2025-12-25 22:21:48'),
(64, 13, 'Resource Management', '<p data-start=\"568\" data-end=\"687\">Manage natural resources efficiently to ensure long-term availability and responsible use.</p>', '2025-12-25 22:22:02', '2025-12-25 22:22:02'),
(65, 13, 'Environmental Policy and Advocacy', '<p data-start=\"689\" data-end=\"835\">Develop policies and advocate for regulations that promote environmental protection and sustainability.</p>', '2025-12-25 22:23:10', '2025-12-25 22:23:10'),
(66, 13, 'Restoration and Impact Assessment', '<p data-start=\"837\" data-end=\"979\">Assess environmental impacts and lead restoration efforts to repair and improve damaged ecosystems.</p>', '2025-12-25 22:23:47', '2025-12-25 22:23:47'),
(67, 13, 'Education and Outreach', '<p>Deliver education and outreach programs to raise awareness and promote sustainable behavior within communities.</p>', '2025-12-25 22:24:16', '2025-12-25 22:24:16'),
(68, 14, 'Design and Planning', '<p data-start=\"234\" data-end=\"362\">Develop architectural and design concepts through planning, analysis, and creative problem-solving.</p>', '2025-12-25 22:33:02', '2025-12-25 22:33:02'),
(69, 14, 'Sustainability and Engineering', '<p>Integrate sustainable design principles and engineering solutions to enhance building performance and efficiency.</p>', '2025-12-25 22:40:38', '2025-12-25 22:40:38'),
(70, 14, 'Visualization and Technical Services', '<p>Produce drawings, models, and technical documentation to support design development and project delivery.</p>', '2025-12-25 22:40:56', '2025-12-25 22:40:56'),
(71, 14, 'Materials and Site Management', '<p>Select materials and manage site coordination to ensure quality, safety, and construction feasibility.</p>', '2025-12-25 22:41:12', '2025-12-25 22:41:12'),
(72, 14, 'Client Engagement', '<p>Collaborate with clients to understand requirements, manage expectations, and deliver design solutions aligned with project goals.</p>', '2025-12-25 22:41:37', '2025-12-25 22:41:37'),
(73, 15, 'Guest Experience', '<p data-start=\"232\" data-end=\"356\">Deliver high-quality service and experiences that ensure guest satisfaction and repeat engagement.</p>', '2025-12-25 22:53:22', '2025-12-25 22:53:22'),
(74, 15, 'Hospitality Operations', '<p data-start=\"358\" data-end=\"492\">Manage daily operations of hospitality facilities to ensure efficiency, safety, and service standards.</p>', '2025-12-25 22:55:35', '2025-12-25 22:55:35'),
(75, 15, 'Food and Beverage', '<p>Plan, prepare, and manage food and beverage services to meet quality, safety, and customer expectations.</p>', '2025-12-25 22:55:55', '2025-12-25 22:55:55'),
(76, 15, 'Travel and Tours', '<p>Plan and manage travel services and tour operations to provide seamless and enjoyable travel experiences.</p>', '2025-12-25 22:57:00', '2025-12-25 22:57:00'),
(77, 15, 'Events and Programs', '<p data-start=\"627\" data-end=\"751\">Design and coordinate events and programs that enhance guest engagement and destination appeal.</p>', '2025-12-25 22:57:50', '2025-12-25 22:57:50'),
(78, 15, 'Wellness and Sustainability', '<p>Implement wellness offerings and sustainable practices to support guest wellbeing and environmental responsibility.</p>', '2025-12-25 22:58:24', '2025-12-25 22:58:24'),
(79, 15, 'Financial and Quality Control', '<p>Oversee budgeting, cost control, and quality standards to maintain operational performance and profitability.</p>', '2025-12-25 22:58:52', '2025-12-25 22:58:52'),
(80, 16, 'Agricultural Science and Research', '<p data-start=\"252\" data-end=\"390\">Conduct research to improve crop production, livestock management, and agricultural innovation.</p>', '2025-12-25 23:05:24', '2025-12-25 23:05:24'),
(81, 16, 'Sustainable Practices and Resource Management', '<p>Develop and implement sustainable farming practices to manage land, water, and natural resources responsibly.</p>', '2025-12-25 23:05:40', '2025-12-25 23:05:40'),
(82, 16, 'Food Science and Safety', '<p data-start=\"558\" data-end=\"698\">Ensure food quality, safety, and nutrition through scientific analysis, testing, and regulatory compliance.</p>', '2025-12-25 23:06:10', '2025-12-25 23:06:10'),
(83, 16, 'Extension and Education', '<p data-start=\"700\" data-end=\"832\">Provide education, training, and advisory services to support farmers, producers, and food systems.</p>', '2025-12-25 23:06:39', '2025-12-25 23:06:39'),
(84, 16, 'Policy and Advocacy', '<p>Develop and advocate for agricultural policies that support food security, sustainability, and industry growth.</p>', '2025-12-25 23:06:58', '2025-12-25 23:06:58'),
(85, 33, 'Patrol, Traffic, and Field Services', '<p>Conduct patrols, manage traffic, and respond to incidents to maintain public safety and order.</p>', '2025-12-27 08:46:49', '2025-12-27 08:46:49'),
(86, 33, 'Criminal Investigations and Special Operations', '<p>Investigate crimes and conduct specialized operations to prevent, detect, and resolve criminal activity.</p>', '2025-12-27 08:47:01', '2025-12-27 08:47:11'),
(87, 33, 'Community Policing and Engagement', '<p>Build relationships with communities to promote trust, cooperation, and crime prevention.</p>', '2025-12-27 08:47:27', '2025-12-27 08:47:27'),
(88, 33, 'Forensics and Crime Scene Investigation', '<p>Collect, analyze, and manage forensic evidence to support criminal investigations and legal proceedings.</p>', '2025-12-27 08:47:46', '2025-12-27 08:47:46'),
(89, 33, 'Corrections and Rehabilitation', '<p>Manage correctional facilities and rehabilitation programs to support offender management and reintegration.</p>', '2025-12-27 08:48:04', '2025-12-27 08:48:04'),
(90, 33, 'Public Safety Communications', '<p>Coordinate emergency communications and dispatch services to ensure timely response and information flow.</p>', '2025-12-27 08:48:16', '2025-12-27 08:48:16'),
(91, 33, 'Training and Internal Affairs', '<p data-start=\"1149\" data-end=\"1301\">Provide professional training and oversee internal accountability to maintain standards, ethics, and performance.</p>', '2025-12-27 08:48:30', '2025-12-27 08:48:30'),
(92, 32, 'Athlete and Fitness Development', '<p data-start=\"230\" data-end=\"377\">Support physical training, fitness improvement, and skill development for athletes and active individuals.</p>\n<p data-start=\"379\" data-end=\"530\">&nbsp;</p>', '2025-12-27 08:48:51', '2025-12-27 08:48:51'),
(93, 32, 'Event and Facility Management', '<p>Plan and manage sports events and facilities to ensure safety, efficiency, and positive participant experiences.</p>', '2025-12-27 08:49:04', '2025-12-27 08:49:04'),
(94, 32, 'Sports Medicine and Rehabilitation', '<p>Provide medical care, injury prevention, and rehabilitation services to support athlete health and recovery.</p>', '2025-12-27 08:49:21', '2025-12-27 08:49:21'),
(95, 32, 'Recreational and Youth Programs', '<p>Design and deliver recreational and youth-focused programs that promote physical activity and healthy development.</p>', '2025-12-27 08:49:33', '2025-12-27 08:49:33'),
(96, 32, 'Athlete and Community Engagement', '<p>Build relationships with athletes and communities to encourage participation, inclusion, and sports development.</p>', '2025-12-27 08:49:46', '2025-12-27 08:49:46'),
(97, 32, 'Support Services', '<p>Provide administrative, operational, and technical support to ensure effective sports and recreation programs.</p>', '2025-12-27 08:50:00', '2025-12-27 08:50:00'),
(98, 31, 'Engineering and Technology', '<p>Develop and maintain military technologies, systems, and infrastructure to support defense capabilities.</p>', '2025-12-27 08:52:30', '2025-12-27 08:52:30'),
(99, 31, 'Operations and Support', '<p>Plan and execute military operations while providing logistical and operational support to ensure mission readiness.</p>', '2025-12-27 08:52:42', '2025-12-27 08:52:42'),
(100, 31, 'Intelligence and Surveillance', '<p>Collect, analyze, and manage intelligence to support strategic decision-making and national security.</p>', '2025-12-27 08:52:53', '2025-12-27 08:52:53'),
(101, 31, 'Training and Medical Services', '<p>Provide training, healthcare, and medical support to maintain personnel readiness and wellbeing.</p>', '2025-12-27 08:53:07', '2025-12-27 08:53:07'),
(102, 31, 'Sustainable and Peacekeeping Operations', '<p>Conduct operations that support peacekeeping, stability, and responsible use of resources in defense activities.</p>', '2025-12-27 08:53:22', '2025-12-27 08:53:22'),
(103, 31, 'Contract and Resource Management', '<p>Manage contracts, procurement, and resources to ensure efficient and accountable defense operations.</p>', '2025-12-27 08:53:33', '2025-12-27 08:53:33'),
(104, 30, 'Skilled Labor and Field Services', '<p>Perform hands-on trade work and field services to install, repair, and maintain essential systems and infrastructure.</p>', '2025-12-27 08:53:49', '2025-12-27 08:53:49'),
(105, 30, 'Apprenticeship, Training, and Safety', '<p>Provide training, apprenticeships, and safety programs to develop skilled workers and ensure safe work practices.</p>', '2025-12-27 08:54:01', '2025-12-27 08:54:01'),
(106, 30, 'Quality Control and Inspection', '<p>Inspect work and materials to ensure compliance with standards, codes, and quality requirements.</p>', '2025-12-27 08:54:17', '2025-12-27 08:54:17'),
(107, 30, 'Tool, Equipment, and Maintenance', '<p>Manage tools, equipment, and maintenance processes to support efficient and reliable trade operations.</p>', '2025-12-27 08:54:30', '2025-12-27 08:54:30'),
(108, 30, 'Specialized Trade Services', '<p>Deliver specialized trade services requiring advanced skills and technical expertise across specific industries.</p>', '2025-12-27 08:54:41', '2025-12-27 08:54:41'),
(109, 29, 'Content Creation and Creative Direction', '<p data-start=\"242\" data-end=\"395\">Develop creative concepts and oversee content creation to ensure artistic vision and audience relevance.</p>\n<p data-start=\"397\" data-end=\"530\">&nbsp;</p>', '2025-12-27 08:55:24', '2025-12-27 08:55:24'),
(110, 29, 'Production and Post-Production', '<p data-start=\"397\" data-end=\"530\">Manage filming, editing, and post-production processes to deliver high-quality media content.</p>\n<p data-start=\"532\" data-end=\"667\">&nbsp;</p>', '2025-12-27 08:55:38', '2025-12-27 08:55:38'),
(111, 29, 'Editorial and Programming', '<p>Plan and curate content schedules and editorial strategies to align programming with audience needs.</p>', '2025-12-27 08:55:56', '2025-12-27 08:55:56'),
(112, 29, 'Broadcast Operations and Media Distribution', '<p data-start=\"669\" data-end=\"817\">Operate broadcast systems and manage distribution channels to deliver content across platforms.</p>\n<p data-start=\"819\" data-end=\"954\">&nbsp;</p>', '2025-12-27 08:56:16', '2025-12-27 08:56:16'),
(113, 29, 'Talent and Art Direction', '<p>Manage creative talent and visual direction to maintain consistent artistic and production standards.</p>', '2025-12-27 08:56:36', '2025-12-27 08:56:36'),
(114, 29, 'Audience Analytics and Content Performance', '<p>Analyze audience data and content performance to guide creative and distribution decisions.</p>', '2025-12-27 08:56:46', '2025-12-27 08:56:46'),
(115, 29, 'Sound and Music Production', '<p>Produce and manage audio and music content to enhance storytelling and audience experience.</p>', '2025-12-27 08:57:02', '2025-12-27 08:57:02'),
(116, 29, 'Licensing and Syndication', '<p data-start=\"1230\" data-end=\"1362\">Manage content rights, licensing, and syndication agreements to expand content reach and revenue.</p>', '2025-12-27 08:57:14', '2025-12-27 08:57:14'),
(117, 28, 'Policy Development, Analysis, and Regulatory Affairs', '<p data-start=\"246\" data-end=\"412\">Develop, analyze, and implement public policies and regulations to guide governance and decision-making.</p>\n<p data-start=\"414\" data-end=\"572\">&nbsp;</p>', '2025-12-27 08:57:48', '2025-12-27 08:57:48'),
(118, 28, 'Public Services and Infrastructure Management', '<p>Manage public services and infrastructure to ensure efficient delivery and long-term community support.</p>', '2025-12-27 08:58:03', '2025-12-27 08:58:03'),
(119, 28, 'Urban and Environmental Planning', '<p>Plan and regulate land use, urban development, and environmental initiatives to support sustainable communities.</p>', '2025-12-27 08:58:14', '2025-12-27 08:58:14'),
(120, 28, 'Public Health, Safety, and Emergency Services', '<p>Coordinate public health programs, safety services, and emergency response systems to protect citizens.</p>', '2025-12-27 08:58:25', '2025-12-27 08:58:25'),
(121, 28, 'Civic Engagement and Economic Development', '<p>Promote civic participation and economic development initiatives to strengthen communities and local economies.</p>', '2025-12-27 08:58:34', '2025-12-27 08:58:34'),
(122, 27, 'Clinical and Preclinical Development', '<p>Plan and conduct preclinical studies and clinical trials to evaluate the safety and effectiveness of therapies.</p>', '2025-12-27 08:59:24', '2025-12-27 08:59:24'),
(123, 27, 'Regulatory Affairs and Pharmacovigilance', '<p>Manage regulatory submissions and monitor drug safety to ensure compliance and patient protection.</p>', '2025-12-27 08:59:42', '2025-12-27 08:59:42'),
(124, 27, 'Medical Affairs and Communications', '<p>Provide scientific communication and medical expertise to support healthcare professionals and stakeholders.</p>', '2025-12-27 08:59:56', '2025-12-27 08:59:56'),
(125, 27, 'Quality Assurance and Control', '<p>Implement quality systems and testing procedures to ensure products meet safety and regulatory standards.</p>', '2025-12-27 09:00:12', '2025-12-27 09:00:12'),
(126, 27, 'Manufacturing and Process Development', '<p>Develop and manage production processes to manufacture pharmaceuticals efficiently and consistently.</p>', '2025-12-27 09:00:26', '2025-12-27 09:00:26'),
(127, 27, 'Laboratory and Research Operations', '<p>Conduct laboratory research and manage research operations to support drug discovery and development.</p>', '2025-12-27 09:00:46', '2025-12-27 09:00:46'),
(128, 27, 'Intellectual Property (IP) and Patents', '<p>Protect scientific innovations through patent management and intellectual property strategies.</p>', '2025-12-27 09:01:11', '2025-12-27 09:01:11'),
(129, 26, 'Vehicle Engineering and Design', '<p>Design and develop vehicle structures, systems, and components to meet performance, safety, and usability requirements.</p>', '2025-12-27 09:01:45', '2025-12-27 09:01:45'),
(130, 26, 'Powertrain and EV Systems Engineering', '<p>Develop internal combustion, hybrid, and electric powertrain systems to improve efficiency and vehicle performance.</p>', '2025-12-27 09:02:00', '2025-12-27 09:02:00'),
(131, 26, 'Autonomous Systems and Advanced Driver Assistance Systems (ADAS)', '<p>Design and integrate automated driving and driver assistance technologies to enhance safety and vehicle intelligence.</p>', '2025-12-27 09:02:21', '2025-12-27 09:02:21'),
(132, 26, 'Vehicle Testing and Validation', '<p>Test and validate vehicles and components to ensure compliance with safety, performance, and regulatory standards.</p>', '2025-12-27 09:02:34', '2025-12-27 09:02:34'),
(133, 26, 'Manufacturing and Assembly', '<p>Manage vehicle production and assembly processes to ensure efficiency, quality, and scalability.</p>', '2025-12-27 09:02:45', '2025-12-27 09:02:45'),
(134, 26, 'Quality Control and Performance Optimization', '<p>Monitor quality and optimize vehicle performance through testing, analysis, and continuous improvement.</p>', '2025-12-27 09:03:01', '2025-12-27 09:03:01'),
(135, 26, 'Sustainability and Environmental Engineering', '<p>Develop solutions to reduce environmental impact through sustainable materials, emissions control, and energy efficiency.</p>', '2025-12-27 09:03:19', '2025-12-27 09:03:19'),
(136, 17, 'Fleet and Vehicle Management', '<p>Manage vehicles and fleets to ensure operational efficiency, safety, and regulatory compliance.</p>', '2025-12-27 09:22:30', '2025-12-27 09:22:30'),
(137, 17, 'Logistics and Coordination', '<p>Coordinate transportation activities to ensure timely and accurate movement of goods and services.</p>', '2025-12-27 09:22:43', '2025-12-27 09:22:43'),
(138, 17, 'Planning and Optimization', '<p style=\"text-align: left;\">Plan routes and operations to improve efficiency, reduce costs, and optimize resource use.</p>', '2025-12-27 09:22:59', '2025-12-27 09:22:59'),
(139, 17, 'Sustainability and Safety', '<p>Implement safety standards and sustainability practices to reduce risk and environmental impact.</p>', '2025-12-27 09:23:15', '2025-12-27 09:23:15'),
(140, 17, 'Warehousing and Distribution', '<p data-start=\"784\" data-end=\"904\">Manage storage and distribution operations to support efficient supply chain flow.</p>', '2025-12-27 09:23:31', '2025-12-27 09:23:31'),
(141, 17, 'Support and Development', '<p>Provide operational support and workforce development to enhance transportation services.</p>', '2025-12-27 09:24:10', '2025-12-27 09:24:10'),
(142, 17, 'Data and Reporting', '<p>Analyze transportation data and produce reports to inform decision-making and performance improvement.</p>', '2025-12-27 09:24:24', '2025-12-27 09:24:24'),
(143, 18, 'Program Development and Service Delivery', '<p>Design and deliver programs that address social needs and support target communities effectively.</p>', '2025-12-27 09:25:35', '2025-12-27 09:25:35'),
(144, 18, 'Fundraising and Development', '<p>Plan and manage fundraising activities to secure financial resources and sustain organizational operations.</p>', '2025-12-27 09:25:55', '2025-12-27 09:25:55'),
(145, 18, 'Community and Volunteer Engagement', '<p>Engage communities and coordinate volunteers to support programs and organizational goals.</p>', '2025-12-27 09:26:15', '2025-12-27 09:26:15'),
(146, 18, 'Advocacy and Policy', '<p data-start=\"682\" data-end=\"810\">Advocate for social causes and policy changes to address systemic issues and promote social impact.</p>\n<p data-start=\"812\" data-end=\"935\">&nbsp;</p>', '2025-12-27 09:26:35', '2025-12-27 09:26:35'),
(147, 18, 'Communications and Outreach', '<p>Manage communications and outreach efforts to raise awareness and engage stakeholders.</p>', '2025-12-27 09:26:49', '2025-12-27 09:26:49'),
(148, 18, 'Research and Evaluation', '<p>Conduct research and evaluate programs to measure impact and improve service effectiveness.</p>', '2025-12-27 09:27:05', '2025-12-27 09:27:05'),
(149, 18, 'Emergency and Relief Services', '<p>Provide emergency response and relief services to support communities during crises and disasters.</p>', '2025-12-27 09:27:20', '2025-12-27 09:27:20'),
(150, 25, 'Aerospace Engineering, Design, and Systems Integration', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Design and integrate aerospace systems and components to meet performance, safety, and mission requirements.</span></p>', '2025-12-27 13:52:26', '2025-12-31 03:44:59'),
(151, 25, 'Flight and Space Operations', '<p><span style=\"font-size: 12pt; line-height: 115%; font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Plan and manage aircraft and space missions to ensure safe, efficient, and reliable operations</span></p>', '2025-12-27 13:52:27', '2025-12-31 03:45:19'),
(152, 25, 'Defense Systems and Cybersecurity', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Develop and secure defense technologies and digital systems to protect national and operational security.</span></p>', '2025-12-27 13:52:27', '2025-12-31 03:45:35'),
(153, 25, 'Manufacturing, Fabrication, and Propulsion', '<p><span style=\"font-size: 12pt; line-height: 115%; font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Manufacture aerospace components and propulsion systems to support aircraft and space vehicle performance.</span></p>', '2025-12-27 13:52:27', '2025-12-31 03:45:58'),
(154, 25, 'Quality Control and Certification', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Ensure aerospace systems comply with regulatory, safety, and certification standards through testing and validation.</span></p>', '2025-12-27 13:52:27', '2025-12-31 03:43:40'),
(155, 25, 'Satellite, Communication, and Weapon Systems', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Develop and manage satellite, communication, and defense systems to support surveillance, connectivity, and mission capability.</span></p>', '2025-12-27 13:52:27', '2025-12-31 03:43:22'),
(156, 24, 'Network Engineering and Infrastructure Management', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Design, build, and manage telecommunications networks and infrastructure to support reliable connectivity.</span></p>', '2025-12-27 14:04:23', '2025-12-31 03:43:03'),
(157, 24, 'Field Services and Network Maintenance', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Install, maintain, and repair network equipment to ensure continuous and efficient service delivery.</span></p>', '2025-12-27 14:04:23', '2025-12-31 03:42:45'),
(158, 24, 'Network Traffic and Data Management', '<p><span style=\"font-size: 12pt; line-height: 115%; font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Monitor and manage network traffic and data flow to optimize performance and reliability.</span></p>', '2025-12-27 14:04:23', '2025-12-31 03:28:32'),
(159, 24, 'Spectrum and Wireless Network Management', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Manage radio spectrum and wireless networks to ensure efficient and compliant signal transmission.</span></p>', '2025-12-27 14:06:24', '2025-12-31 03:42:19'),
(160, 24, 'Network Security and Risk Management', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Protect telecommunications networks from security threats and manage operational risks.</span></p>', '2025-12-27 14:06:24', '2025-12-31 03:41:57'),
(161, 24, 'Service Provisioning and Activation', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Configure and activate telecommunications services to deliver connectivity to customers and businesses.</span></p>', '2025-12-27 14:06:24', '2025-12-31 03:41:33'),
(162, 24, 'Infrastructure Planning and Deployment', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Plan and deploy network infrastructure to expand coverage and support future demand.</span></p>', '2025-12-27 14:06:24', '2025-12-31 03:40:51'),
(163, 24, 'Telecom Regulatory and Compliance Affairs', '<p><span style=\"font-size: 12pt; line-height: 115%; font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Ensure compliance with telecommunications regulations, standards, and licensing requirements.</span></p>', '2025-12-27 14:06:24', '2025-12-31 03:40:16'),
(164, 23, 'Architecture, Design, and Engineering', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Design and engineer buildings and infrastructure to meet functional, safety, and regulatory requirements.</span></p>', '2025-12-27 14:08:44', '2025-12-31 03:39:48'),
(165, 23, 'Construction Management and Safety', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Plan and oversee construction projects while ensuring safety, quality, and timely delivery.</span></p>', '2025-12-27 14:08:44', '2025-12-31 03:39:04'),
(166, 23, 'Urban Planning and Land Development', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Plan and manage land use and development to support organized, sustainable urban growth.</span></p>', '2025-12-27 14:08:44', '2025-12-31 03:38:34'),
(167, 23, 'Real Estate and Property Asset Management', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\',\'serif\'; mso-fareast-font-family: \'Times New Roman\'; color: black; mso-font-kerning: 0pt; mso-ligatures: none;\">Manage real estate assets and properties to maximize value, functionality, and long-term performance.</span></p>', '2025-12-27 14:08:44', '2025-12-27 14:08:44'),
(168, 23, 'Sustainability and Environmental Management', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Integrate sustainable practices to reduce environmental impact and improve building efficiency.</span></p>', '2025-12-27 14:08:44', '2025-12-31 03:38:01'),
(169, 23, 'Site Acquisition and Development Permitting', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Manage site acquisition and regulatory approvals to enable compliant and efficient project development.</span></p>', '2025-12-27 14:08:44', '2025-12-31 03:37:36'),
(170, 22, 'Merchandising, Inventory, and Category Management', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Plan product assortments and manage inventory to meet customer demand and optimize sales performance.</span></p>', '2025-12-27 14:10:15', '2025-12-31 03:37:06'),
(171, 22, 'E-commerce Platform and User Experience Management', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Manage online retail platforms and user experiences to ensure functionality, accessibility, and customer satisfaction.</span></p>', '2025-12-27 14:10:15', '2025-12-31 03:36:42'),
(172, 22, 'Fulfillment, Shipping, and Delivery', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Coordinate order fulfillment, shipping, and delivery operations to ensure timely and accurate order completion.</span></p>', '2025-12-27 14:10:15', '2025-12-31 03:35:54'),
(173, 22, 'Retail and Omnichannel Store Management', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Manage physical and digital retail channels to provide consistent customer experiences across platforms.</span></p>', '2025-12-27 14:10:15', '2025-12-31 03:35:34'),
(174, 22, 'Data Analytics and Consumer Insights', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Analyze sales and consumer data to inform pricing, marketing, and merchandising decisions.</span></p>', '2025-12-27 14:10:15', '2025-12-31 03:35:07'),
(175, 22, 'Vendor and Partnership Management', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Manage relationships with suppliers and partners to ensure product availability, quality, and cost efficiency.</span></p>', '2025-12-27 14:10:15', '2025-12-31 03:34:49'),
(176, 21, 'Manufacturing and Process Engineering', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Design and optimize manufacturing processes to improve efficiency, quality, and production capacity.</span></p>', '2025-12-27 14:12:01', '2025-12-31 03:34:11'),
(177, 21, 'Quality Control and Continuous Improvement', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Implement quality systems and improvement initiatives to enhance product consistency and operational performance.</span></p>', '2025-12-27 14:12:01', '2025-12-31 03:33:50'),
(178, 21, 'Production Planning and Maintenance', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Plan production schedules and manage equipment maintenance to ensure smooth and reliable operations.</span></p>', '2025-12-27 14:12:01', '2025-12-31 03:33:29'),
(179, 21, 'Logistics and Warehousing', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Manage material flow, storage, and distribution to support efficient production and supply chain operations.</span></p>', '2025-12-27 14:12:01', '2025-12-31 03:33:11'),
(180, 21, 'Health, Safety, and Environmental Management', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Ensure workplace safety and environmental compliance across manufacturing operations.</span></p>', '2025-12-27 14:12:01', '2025-12-31 03:32:52'),
(181, 21, 'Production Supervision and Monitoring', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Oversee production activities and monitor performance to meet output, quality, and efficiency targets.</span></p>', '2025-12-27 14:12:01', '2025-12-31 03:32:35'),
(182, 20, 'Environmental Sustainability and Compliance', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Ensure energy operations comply with environmental regulations and sustainability standards.</span></p>', '2025-12-27 14:13:41', '2025-12-31 03:32:15'),
(183, 20, 'Renewable and Alternative Energy Development', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Develop renewable and alternative energy projects to support clean and diversified energy production.</span></p>', '2025-12-27 14:13:41', '2025-12-31 03:24:04'),
(184, 20, 'Geological and Resource Management', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Assess and manage geological resources to support energy exploration and extraction activities.</span></p>', '2025-12-27 14:13:41', '2025-12-31 03:24:26'),
(185, 20, 'Land and Resource Permitting', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Manage land access and permitting processes to ensure compliant and efficient resource development.</span></p>', '2025-12-27 14:13:41', '2025-12-31 03:24:49'),
(186, 20, 'Energy Markets and Risk Management', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Analyze energy markets and manage financial and operational risks within the energy sector.</span></p>', '2025-12-27 14:13:41', '2025-12-31 03:25:46'),
(187, 20, 'Environmental Remediation and Site Reclamation', '<p><span style=\"font-size: 12pt; line-height: 115%; font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Plan and execute remediation and site reclamation efforts to restore impacted environments.</span></p>', '2025-12-27 14:13:41', '2025-12-31 03:26:14'),
(188, 19, 'Research and Behavioral Analysis', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Conduct research and analyze human behavior to understand social patterns and decision-making.</span></p>', '2025-12-27 14:14:31', '2025-12-31 03:29:09'),
(189, 19, 'Sociology and Sociocultural Studies', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\',\'serif\'; mso-fareast-font-family: \'Times New Roman\'; color: black; mso-font-kerning: 0pt; mso-ligatures: none;\">Study social structures, cultures, and relationships to explain how societies function and change.</span></p>', '2025-12-27 14:14:31', '2025-12-27 14:53:52'),
(190, 19, 'Policy and Ethical Governance', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Analyze social issues to inform ethical decision-making, governance, and public policy development.</span></p>', '2025-12-27 14:15:22', '2025-12-31 03:29:43'),
(191, 19, 'Community and Cultural Engagement', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Engage with communities and cultural groups to support social understanding and inclusive initiatives.</span></p>', '2025-12-27 14:15:22', '2025-12-27 14:54:40'),
(192, 19, 'Data Science and Communication Studies', '<p class=\"MsoNormal\" style=\"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto; line-height: normal;\"><span style=\"font-family: \'Times New Roman\', \'serif\'; color: #ffffff;\">Apply data analysis and communication research to study social trends and information exchange.</span></p>', '2025-12-27 14:15:22', '2025-12-27 14:54:57');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `industries`
--

CREATE TABLE `industries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` text NOT NULL,
  `name` varchar(255) NOT NULL,
  `modal_image` varchar(255) DEFAULT NULL,
  `modal_description` text DEFAULT NULL,
  `final_details` text DEFAULT NULL,
  `demo_status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `industries`
--

INSERT INTO `industries` (`id`, `title`, `name`, `modal_image`, `modal_description`, `final_details`, `demo_status`, `created_at`, `updated_at`) VALUES
(1, '<p>Improve Public Health And Well-Being,&nbsp;<br><span style=\"color: #98d4fd;\">Provide Medical Care To Those In Need,</span>&nbsp;And Advance Medical Knowledge?</p>', 'Healthcare and Medicine Industry', 'categories/F8fmgqBdvP2zicwQInDZxbLDgYMbjv5XwAKODBgs.jpg', '<p>Your work will involve mitigating challenges such as: <br><br><span style=\"color: #4d84ff;\"><strong>Global Health Security</strong></span><br>Strengthening health systems to <span style=\"font-family: helvetica, arial, sans-serif;\">prevent</span> and respond to global health threats. For example, you could work as a Public Health Officer helping control disease outbreaks and improve healthcare infrastructure.<br><br><strong><span style=\"color: #4d84ff;\">Mental Health and Wellness Coaching</span></strong><br>Providing support to enhance mental well-being and cope with life challenges. For example, you could work as a Counselor or Wellness Coach guiding people through stress, anxiety, and personal growth.<br><br><span style=\"color: #4d84ff;\"><strong>Elder Care and Gerontology</strong></span><br>Improving the quality of life and care for aging populations. For example, you could be a Geriatric Nurse or Care Coordinator ensuring elderly patients receive proper care and companionship.<br><br><strong><span style=\"color: #4d84ff;\">Child Welfare and Protection </span></strong><br>Ensuring the safety, health, and development of children in vulnerable situations. For example, you could work as a Child Welfare Officer or Social Worker protecting children and supporting families in need.<br><br><span style=\"color: #4d84ff;\"><strong>Refugee and Asylum Support</strong></span><br>Providing medical care and support services to refugees and asylum seekers. For example, you could be a Humanitarian Health Worker or Field Medic assisting refugees in crisis zones.<br><br><span style=\"color: #4d84ff;\"><strong>Public Health</strong></span><br>Promoting health and preventing disease through community-wide initiatives. For example, you could work as a Health Educator or Policy Analyst developing vaccination and awareness programs.<br><br><span style=\"color: #4d84ff;\"><strong>Regenerative Medicine</strong></span><br>Developing therapies to repair or replace damaged tissues and organs. For example, you could be a Biomedical Researcher working on stem cell therapy or artificial organ development.<br><br></p>\r\n<p><span style=\"color: #4d84ff;\"><strong>Disaster Psychiatry</strong><br></span>Addressing mental health needs following natural disasters and crises. For example, you could work as a Crisis Psychologist helping disaster survivors recover emotionally.</p>\r\n<p><span style=\"color: #4d84ff;\"><strong><br>Digital Health<br></strong></span>Leveraging technology to improve healthcare delivery and patient outcomes. For example, you could be a Health App Developer or Telemedicine Specialist designing platforms for remote care.</p>', '<p>You have shown interest to work for companies that aim to improve Public Health And Well-Being, Provide Medical Care To Those In Need, And Advance Medical Knowledge.</p>', 1, '2025-11-07 11:49:07', '2026-02-17 02:43:16'),
(2, '<h2 dir=\"auto\">Build Technology to Solve Real-World Problems, Drive Global Innovation and <span style=\"color: #98d4fd;\">Create Innovative Solutions That Shape the Future?</span></h2>', 'Information Technology and Computer Science Industry', 'categories/LCoMxtH5C1qeAocGXGWVwKwrcc4edjiimU3I0bN5.png', '<p>Your work will involve mitigating challenges such as:&nbsp;<br><br><strong><span style=\"color: #4d84ff;\">Quantum Computing</span><br></strong>Developing quantum technologies to solve complex computational problems.<br>For example, you could work as a Quantum Software Researcher designing algorithms for next-generation computers.<br><br><strong><span style=\"color: #4d84ff;\">Cybersecurity</span></strong><br>Protecting information systems from cyber threats and attacks.<br>For example, you could work as a Cybersecurity Analyst detecting and preventing hacking attempts and data breaches.<br><br><span style=\"color: #4d84ff;\"><strong>Digital Accessibility<br></strong></span>Ensuring that digital content and technologies are accessible to all individuals.<br>For example, you could be an Accessibility Designer making websites and apps usable for people with disabilities.<br><br><span style=\"color: #4d84ff;\"><strong>Digital Nomad Support <br></strong></span>Providing resources and support for individuals who work remotely while traveling.&nbsp;For example, you could manage online coworking communities or design digital tools for remote professionals.<br><br><span style=\"color: #4d84ff;\"><strong>Digital Ethics and Governance </strong></span><br>Ensuring ethical practices in the development and use of digital technologies.<br>For example, you could work as a Technology Policy Advisor developing ethical guidelines for AI and data privacy.<br><br><span style=\"color: #4d84ff;\"><strong>Ethical Hacking<br></strong></span>Identifying and fixing security vulnerabilities in digital systems.<br>For example, you could be a Penetration Tester hired by companies to find and fix security loopholes.<br><br><span style=\"color: #4d84ff;\"><strong>Smart Grid Technology</strong></span>&nbsp;<br>Enhancing energy distribution networks with advanced digital technologies.<br>For example, you could work as a Smart Grid Engineer optimizing how electricity is delivered across cities.<br><br><span style=\"color: #4d84ff;\"><strong>Autonomous Transportation Systems</strong></span><br>Developing self-driving vehicles and related technologies.<br>For example, you could be a Software Engineer working on navigation and sensor systems for driverless cars.<br><br><span style=\"color: #4d84ff;\"><strong>Advanced Manufacturing</strong></span> <br>Utilizing cutting-edge technologies to improve manufacturing processes.<br>For example, you could work as an Automation Engineer integrating robotics and AI into factory production.<br><br><span style=\"color: #4d84ff;\"><strong>Smart Agriculture</strong></span><br>Applying technology to increase agricultural efficiency and sustainability.<br>For example, you could be an AgriTech Developer creating drones and sensors to monitor crops and soil health.<br><br><span style=\"color: #4d84ff;\"><strong>Space Debris Mitigation</strong></span><br>Developing solutions to manage and reduce space debris.<br>For example, you could work as an Aerospace Data Analyst designing systems to track and remove orbital debris.<br><br><strong><span style=\"color: #4d84ff;\">Autonomous Vehicle Technicians</span></strong>&nbsp;<br>Supporting the maintenance and development of self-driving vehicles.<br>For example, you could be a Robotics Technician maintaining the hardware and AI systems in autonomous cars.</p>', '<p>You have shown interest to work for companies that Solve Real-World Problems, Drive Global Innovation and Create Innovative Solutions That Shape the Future.</p>', 1, '2025-11-07 11:50:53', '2025-12-29 19:51:13'),
(3, '<p><span style=\"color: #98d4fd;\">Drive Business Growth</span>, Strengthen Financial Performance, And Help Organizations Operate More Efficiently?</p>', 'Business & Finance Industry', 'categories/6SLsJFkek95wLssCViriEr44hmZY2jzWbrHMcdeI.png', '<p>Your work will involve mitigating challenges such as:&nbsp;<br><br><span style=\"color: #4d84ff;\"><strong>Social Entrepreneurship</strong></span><br>Creating businesses that address social issues while generating profit. For example, you could work as a Social Enterprise Founder or Program Manager developing sustainable businesses that uplift communities.<br><br><span style=\"color: #4d84ff;\"><strong>Ethical Investing</strong></span><br>Investing in companies and projects that prioritize environmental, social, and governance (ESG) criteria.&nbsp;For example, you could be an Investment Analyst helping investors choose socially responsible companies.<br><br><span style=\"color: #4d84ff;\"><strong>Environmental Finance</strong></span><br>Using financial instruments to promote environmental sustainability and conservation. For example, you could work as a Green Finance Consultant developing investment models for renewable energy projects.<br><br><span style=\"color: #4d84ff;\"><strong>Inclusive Finance</strong></span><br>Providing financial services to underserved populations to promote economic inclusion.&nbsp;For example, you could work as a Microfinance Officer helping rural entrepreneurs access loans and business support.<br><br><span style=\"color: #4d84ff;\"><strong>Circular Economy for Plastics</strong></span><br>Developing systems to recycle and reuse plastics, reducing waste. For example, you could work as a Sustainability Consultant or Project Manager partnering with manufacturers to build recycling systems.<br><br><span style=\"color: #4d84ff;\"><strong>Circular Economy for Electronics</strong></span><br>Promoting the recycling and reuse of electronic devices to reduce e-waste.&nbsp;For example, you could be a Supply Chain Analyst or Operations Manager helping companies refurbish and repurpose old electronics.</p>', '<p>You have shown interest in working for companies that Drive Business Growth, Strengthen Financial Performance, And Create Efficient, Impactful Operations.&nbsp;</p>', 1, '2025-11-07 12:40:27', '2025-12-29 10:21:45'),
(4, '<p><span style=\"color: #98d4fd;\">Design And Engineer Solutions</span> That Improve Infrastructure, Advance Technology, And Shape How Society Functions?</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>', 'Engineering Industry', 'categories/ob9H1pj1N8XFWgrrXfgklNlexx8wRP3W9uRf7WaC.png', '<p>Your work will involve mitigating challenges such as:&nbsp;<br><br><span style=\"color: #4d84ff;\"><strong>Renewable Energy and Sustainability</strong></span><br>Developing sustainable energy sources and technologies to reduce reliance on fossil fuels.&nbsp;For example, you could work as a Renewable Energy Engineer designing solar, wind, or hydroelectric power systems.<br><br><strong><span style=\"color: #4d84ff;\">Sustainable Water Solutions</span></strong><br>Ensuring access to clean and sustainable water resources. For example, you could be an Environmental Engineer developing water purification and wastewater recycling systems.</p>\r\n<p><br><strong><span style=\"color: #4d84ff;\">Renewable Energy Technicians</span></strong><br>Installing and maintaining renewable energy systems. For example, you could work as a Solar Panel Technician or Wind Turbine Technician ensuring energy systems run efficiently.</p>\r\n<p>&nbsp;</p>\r\n<p><strong style=\"color: #4d84ff;\">Disaster-Resilient Infrastructure</strong></p>\r\n<p>Building infrastructure that can withstand natural disasters and climate change impacts. For example, you could be a Civil Engineer designing earthquake-resistant buildings or flood-control systems.</p>\r\n<p>&nbsp;</p>\r\n<p><strong style=\"color: #4d84ff;\">Renewable Energy Storage Solutions</strong></p>\r\n<p>Creating technologies for storing renewable energy to ensure a stable supply. For example, you could work as a Battery Systems Engineer developing advanced energy storage solutions.</p>\r\n<p>&nbsp;</p>\r\n<p><strong style=\"color: #4d84ff;\">Renewable Energy Infrastructure</strong></p>\r\n<p>Developing and maintaining systems to support renewable energy adoption. For example, you could be an Electrical Engineer planning smart grids and power distribution networks.</p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"color: #4d84ff;\"><strong>Peace Technology</strong></span><br>Using technology to promote peace and prevent conflict.<br>For example, you could work as a Defense Systems Engineer creating non-lethal technologies for conflict prevention and disaster relief.</p>\r\n<p>&nbsp;</p>\r\n<p><strong style=\"color: #4d84ff;\">Space Exploration and Colonization</strong></p>\r\n<p>Advancing technologies for human exploration and habitation of space. For example, you could be an Aerospace Engineer developing spacecraft systems or life-support technology for Mars missions.</p>\r\n<p>&nbsp;</p>\r\n<p><strong style=\"color: #4d84ff;\">Disaster Preparedness and Response</strong></p>\r\n<p>Enhancing community resilience and response to natural and man-made disasters. For example, you could work as a Structural Engineer or Emergency Planning Specialist designing safe shelters and evacuation systems.</p>', '<p>You have shown interest in working for companies that Design And Build Solutions That Improve Infrastructure, Advance Technology, And Shape How Society Functions.</p>', 1, '2025-11-07 12:42:26', '2025-12-29 10:24:06'),
(6, '<p>Do You Care To Shape the Future by <span style=\"color: #98d4fd;\">Educating and Empowering the Next Generation?</span></p>', 'Education Industry', 'categories/GLAnDVevHV0olcMy5dI6VS8a3ylfeTI2rcc1Z4pb.png', '<p>Your work will involve mitigating challenges such as:<br><br><span style=\"color: #4d84ff;\"><strong>Youth Leadership Development</strong></span><br>Empowering young people to become leaders in their communities. For example, you could work as a Youth Program Coordinator helping students build confidence, leadership, and teamwork skills.</p>\r\n<p><strong><br><span style=\"color: #4d84ff;\">Education for All</span></strong><br>Ensuring access to quality education for everyone, regardless of background. For example, you could be an Educational Advocate designing programs that support underserved or marginalized students.</p>\r\n<p><strong><br><span style=\"color: #4d84ff;\">Renewable Energy Education</span></strong><br>Teaching individuals and communities about sustainable energy practices. For example, you could work as a Sustainability Educator teaching schools and communities how to adopt clean energy habits.</p>\r\n<p><strong><br><span style=\"color: #4d84ff;\">Inclusive Design</span></strong><br>Creating educational environments that accommodate all learners. For example, you could be an Inclusive Learning Designer developing accessible classroom tools and adaptive curricula.</p>\r\n<p><strong><br><span style=\"color: #4d84ff;\">Behavioral Science</span></strong><br>Studying human behavior to improve educational outcomes and methodologies. For example, you could be a Behavioral Research Assistant analyzing student behavior patterns to improve teaching methods.</p>\r\n<p><strong><br><span style=\"color: #4d84ff;\">Environmental Education</span></strong><br>Promoting awareness and understanding of environmental issues through education. For example, you could be an Environmental Educator leading workshops on climate change, conservation, and sustainability.</p>\r\n<p><strong><br><span style=\"color: #4d84ff;\">Cultural Competency Training</span></strong><br>Educating individuals to understand and respect cultural differences. For example, you could work as a Cultural Awareness Trainer helping organizations and schools build inclusive, culturally sensitive environments.</p>', '<p><span style=\"color: #ffffff;\">You have shown interest in working for companies that Shape the Future by Educating and Empowering the Next Generation.</span></p>', 1, '2025-12-11 23:21:50', '2025-12-29 10:24:52'),
(7, '<p class=\"MsoNormal\">Use <span style=\"color: #98d4fd;\">Creativity, Communication, And Cultural Understanding</span> To Inspire People And Shape How Society Thinks And Feels?</p>', 'Arts and Humanities Industry', 'categories/SHJJa1ScTeeDiwOhOWwYUlL8WxqmaCcLBC1sx5zb.png', '<p>Your work will involve mitigating challenges such as:&nbsp;<strong><br><br><span style=\"color: #4d84ff;\">Cultural Preservation</span></strong><br>Protecting and promoting cultural heritage and traditions. For example, you could work as a Museum Curator or Cultural Archivist preserving artifacts and documenting traditional practices.<br><br></p>\r\n<p><span style=\"color: #4d84ff;\"><strong>Language Preservation</strong></span><br>Safeguarding endangered languages and promoting linguistic diversity. For example, you could be a Linguistic Researcher or Language Educator creating programs to revive and teach native or minority languages.</p>\r\n<p><span style=\"color: #4d84ff;\"><strong><br>Public Art Initiatives</strong></span><br>Enhancing public spaces through artistic expression and community engagement. For example, you could work as a Public Art Coordinator organizing murals, installations, and community art projects.<br><br></p>\r\n<p><span style=\"color: #4d84ff;\"><strong>Cultural Heritage Preservation</strong></span><br>Conserving historical sites and artifacts for future generations. For example, you could be a Heritage Conservation Specialist restoring historic buildings and managing preservation projects.<br><br></p>\r\n<p><span style=\"color: #4d84ff;\"><strong>Cultural Diplomacy</strong></span><br>Using cultural exchange to strengthen international relations. For example, you could work as a Cultural Attach&eacute; organizing international cultural programs and collaborations.<br><br></p>\r\n<p><span style=\"color: #4d84ff;\"><strong>Arts and Cultural Heritage</strong></span><br>Promoting and preserving arts and culture as fundamental aspects of society. For example, you could be an Arts Administrator supporting exhibitions, creative programs, and community arts initiatives.<br><br></p>\r\n<p><span style=\"color: #4d84ff;\"><strong>Performing Arts</strong></span><br>Encouraging artistic performance as a means of cultural expression. For example, you could work as a Theatre Director, Choreographer, or Performer bringing stories and traditions to life on stage.<br><br></p>\r\n<p><span style=\"color: #4d84ff;\"><strong>Literature and Publishing</strong></span><br>Supporting the creation and distribution of literary works. For example, you could be an Editor, Author, or Literary Agent helping writers publish impactful stories and books.</p>', '<p>You have shown interest to work for companies that <span style=\"color: #ffffff;\">Use Creativity, Communication, And Cultural Understanding To Inspire People And Shape How Society Thinks And Feels?</span></p>', 1, '2025-12-11 23:44:10', '2025-12-29 10:25:26'),
(9, '<p><span style=\"color: #98d4fd;\">Expand Human Knowledge</span>, Explore The Natural World, And Make Discoveries That Advance Society?</p>', 'Science and Research Industry', 'categories/MYHwDEyx4GMBXwa1XA3MoSOiWu4XC0348s59yS3P.png', '<p class=\"MsoNormal\"><span lang=\"EN-CA\">Your work will involve mitigating challenges such as:&nbsp;</span></p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Scientific Ethics</strong></span><br>Ensuring ethical practices in scientific research and innovation.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Environmental Conservation</strong></span><br>Promoting sustainable practices to protect natural environments.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Advancing Scientific Frontiers</strong></span><br>Pushing the boundaries of knowledge through cutting-edge research.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>', '<p>You have shown interest to work for companies that&nbsp;<strong>Expands Human Knowledge</strong>, Explores The Natural World, And Makes Discoveries That Advance Society.</p>', 1, '2025-12-25 10:30:04', '2025-12-29 19:40:11'),
(10, '<p class=\"MsoNormal\"><span style=\"color: #98d4fd;\">Support Vulnerable Populations</span>, Improve Mental Health, And Create A More Just Society?</p>', 'Social Services Industry', 'categories/4CxOUpDa9yzKO70XtCuQ1DnrszmaWBH5GQyivqHb.png', '<p class=\"MsoNormal\"><span lang=\"EN-CA\">Your work will involve mitigating challenges such as:&nbsp;</span></p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Support for Vulnerable Populations</strong></span><br>Providing resources and services to those in need.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Improving Mental Health</strong></span><br>Addressing mental health issues and reducing stigma.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Promoting Social Justice</strong></span><br>Advocating for equal rights and opportunities for all individuals.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Reducing Poverty</strong></span><br>Implementing programs to alleviate poverty and improve living conditions.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>', '<p class=\"MsoNormal\"><span style=\"color: #ffffff;\">You have shown interest to work for companies that <strong>Support Vulnerable Populations</strong>, Improve Mental Health, And Create A More Just Society?</span></p>', 1, '2025-12-25 10:35:05', '2025-12-29 19:40:22'),
(11, '<p class=\"MsoNormal\">Uphold Justice, <span style=\"color: #98d4fd;\">Protect Individual Rights</span>, And Help Maintain Fairness And Safety In Society?</p>', 'Law and Criminal Justice Industry', 'categories/55TXh2J7zZvP2znN5JtZqDkxY33tQsVP0Ls8c7ap.png', '<p>Your work will involve mitigating challenges such as:&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Criminal Justice Reform</strong></span><br>Improving the fairness and effectiveness of the criminal justice system.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Human Rights Advocacy</strong></span><br>Protecting and promoting human rights for all individuals.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Ensuring Equal Access to Legal Services</strong></span><br>Making legal assistance available to underserved populations.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that&nbsp;Uphold Justice,<span class=\"apple-converted-space\">&nbsp;</span>Protect Individual Rights, And Help Maintain Fairness And Safety In Society.</p>', 1, '2025-12-25 10:47:04', '2025-12-29 19:40:36'),
(12, '<p>Create And Share Content That Informs People, Sparks Conversation, And <span style=\"color: #98d4fd;\">Influences How Society Thinks</span>?</p>', 'Media and Communication Industry', 'categories/Xl1MWkqCPuQyWMv17km1NaXUOcNUcsEOjGoIbXMG.png', '<p>Your work will involve mitigating challenges such as:&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"color: #4d84ff;\"><strong>Combating Misinformation</strong></span><br>Ensuring the accuracy and reliability of information.<br><br><span style=\"color: #4d84ff;\"><strong>Media Ethics</strong></span><br>Promoting ethical standards in journalism and media production.</p>\r\n<p>&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Digital Privacy</strong></span><br>Protecting individuals\' privacy in the digital age.</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Create And Share Content That Informs People, Sparks Conversation, And Influences How Society Thinks.</p>', 1, '2025-12-25 10:51:25', '2025-12-29 19:45:23'),
(13, '<p>Address Climate Challenges, Conserve Natural Resources, <span style=\"color: #98d4fd;\">And Protect Ecosystems For Future Generations?</span><br><br></p>', 'Environmental Science and Sustainability Industry', 'categories/SGMZtv3WJPz80BaBWzzNPKxmRQkzaYHTaCP66kcT.png', '<p>Your work will involve mitigating challenges such as:&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Climate Change Mitigation</strong></span><br>Develop strategies to reduce greenhouse gas emissions and combat global warming.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Environmental Remediation</strong></span><br>Clean up and restore polluted environments to ensure ecological and human health.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Biodiversity Conservation</strong></span><br>Protect and preserve diverse biological species and ecosystems.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Environmental Justice</strong></span><br>Ensure fair treatment and involvement of all people in environmental policies and practices.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Urban Heat Island Mitigation</strong></span><br>Implement solutions to reduce excessive heat in urban areas.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Water Scarcity</strong></span><br>Develop sustainable water management practices to address water shortages.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Wildlife Conservation</strong></span><br>Protect wildlife species and their habitats from threats such as poaching and habitat destruction.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Wildlife Corridors</strong></span><br>Create safe passages for wildlife to move between habitats, promoting biodiversity and ecosystem health.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Sustainable Fisheries</strong></span><br>Promote responsible fishing practices to ensure the long-term health of fish populations and marine ecosystems.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Eco-Architecture</strong></span><br>Design environmentally friendly and energy-efficient buildings and infrastructure.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Ocean and Marine Conservation</strong></span><br>Protect and preserve ocean and marine environments from pollution, overfishing, and climate change.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Forestry and Wildlife Management</strong></span><br>Manage forests and wildlife populations sustainably to maintain ecological balance.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Environmental Psychology</strong></span><br>Study the relationship between humans and their environments to promote well-being and sustainable behavior.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Zero Waste Initiatives</strong></span><br>Implement practices to reduce waste generation and promote recycling and reuse of materials.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Address Climate Challenges, Conserve Natural Resources, And Protect Ecosystems For Future Generations.</p>', 1, '2025-12-25 10:59:32', '2025-12-29 19:41:13'),
(14, '<p>Design Spaces And Environments That <span style=\"color: #98d4fd;\">Improve How People Live, Work, And Experience </span>The World Around Them?</p>', 'Architecture and Design Industry', 'categories/NCIdrzLSdPl7eBtWosrvG3iShVbboRUMgffdttBg.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Sustainable Design</strong></span><br>Creating environmentally friendly and energy-efficient buildings</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Accessibility</strong></span><br>Designing spaces that are accessible to all individuals, including those with disabilities.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Urban Planning for Growing Populations</strong></span><br>Developing urban areas that can accommodate increasing populations while maintaining quality of life.</p>', '<p>You have shown interest to work for companies that&nbsp;<strong>Design Spaces And Environments That Improve How People Live, Work, And Experience The World Around Them.</strong></p>', 1, '2025-12-25 19:11:10', '2025-12-29 19:41:23'),
(15, '<p class=\"MsoNormal\">Provide <span style=\"color: #98d4fd;\">Memorable Experiences For Travelers,</span> Support Local Economies, And Promote Cultural Exchange?</p>', 'Hospitality and Tourism Industry', 'categories/xk3AstpWgz30uOritFD5x6MjABFsvLKhiBk2pLyU.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Sustainable Tourism Practices</strong></span><br>Promoting tourism that conserves the environment and benefits local communities.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Cultural Sensitivity</strong></span><br>Ensuring that tourism practices respect and preserve local cultures and traditions.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Safety for Travelers</strong></span><br>Enhancing safety measures to protect travelers.</p>', '<p>You have shown interest to work for companies that Provide Memorable Experiences For Travelers, Support Local Economies, And Promote Cultural Exchange.</p>', 1, '2025-12-25 19:15:15', '2025-12-29 19:41:35'),
(16, '<p class=\"MsoNormal\">Ensure Food Security, <span style=\"color: #98d4fd;\">Develop Sustainable Agricultural Practices</span>, And Improve Nutrition?</p>', 'Agriculture and Food Sciences Industry', 'categories/bnw5BJvTfkZXy1cZVC0aVs6ps6KOixWpl3EdDjrS.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Sustainable Agriculture</strong></span><br>Develop farming practices that protect the environment and ensure long-term productivity.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Food Security</strong></span><br>Ensure a reliable supply of safe and nutritious food for all.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Urban Farming</strong></span><br>Promote local food production and reduce urban food deserts through sustainable agriculture in cities.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Food Sovereignty</strong></span><br>Empower communities to control their own food systems, promoting local and sustainable food production.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Aquaponics and Hydroponics</strong></span><br>Use aquaponic and hydroponic systems to grow food sustainably with minimal water and soil use.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Food Innovation and Technology</strong></span><br>Develop new food technologies to improve food security, nutrition, and sustainability.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Regenerative Agriculture</strong></span><br>Implement agricultural practices that restore soil health, increase biodiversity, and sequester carbon.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Fisheries and Aquaculture</strong></span><br>Promote responsible fishing and aquaculture practices to ensure the health of marine and freshwater ecosystems.</p>', '<p>You have shown interest to work for companies that Ensure Food Security, Develop Sustainable Agricultural Practices, And Improve Nutrition.</p>', 1, '2025-12-25 19:22:52', '2025-12-29 19:41:46'),
(17, '<p class=\"MsoNormal\">Move People And Goods Efficiently, <span style=\"color: #98d4fd;\">Improve Supply Chains</span>, And Keep Societies And Economies Connected?</p>', 'Transportation and Logistics Sciences Industry', 'categories/af8wW1mXtUYEYfkjm3bR235bzlY8PBZRn4g4TnDS.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Sustainable Transportation Solutions</strong></span><br>Promoting eco-friendly transportation methods to reduce emissions.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Infrastructure Development</strong></span><br>Building and maintaining transportation infrastructure to support efficient movement of people and goods.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Reducing Traffic Congestion</strong></span><br>Implementing measures to alleviate traffic congestion and improve urban mobility.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Move People And Goods Efficiently, Improve Supply Chains, And Keep Societies And Economies Connected.</p>', 1, '2025-12-25 19:30:22', '2025-12-29 19:42:05'),
(18, '<p class=\"MsoNormal\">Work On Social Issues, Strengthen Communities,&nbsp;And <span style=\"color: #98d4fd;\">Help Non-Profit Organizations Solve Problems?</span></p>', 'Nonprofit and Social Organizations Industry', 'categories/Mpi5bf1Fu7BopptIuA57gLyvZrVaSDZdene58BAB.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><strong><span style=\"color: #4d84ff;\">Access to Essential Services</span><br></strong>Improving access to education, healthcare, and food security for underserved communities.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><strong><span style=\"color: #4d84ff;\">Community Empowerment</span><br></strong>Engaging marginalized populations in programs that build skills, leadership, and self-sufficiency.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><strong><span style=\"color: #4d84ff;\">Social Justice Advocacy</span><br></strong>Addressing systemic inequalities and promoting inclusive policies through education and activism.</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Work On Social Issues, Strengthen Communities, And Create Lasting Impact Through Mission-Driven Work?</p>', 1, '2025-12-25 19:43:15', '2025-12-29 19:42:14'),
(19, '<p class=\"MsoNormal\">Understand <span style=\"color: #98d4fd;\">Social Patterns And Human Behavior</span> To Explain And Improve How Societies Work?</p>', 'Social Sciences Industry', 'categories/kH6BWSSz3S8SqSvl9KP5G5mc4sEEaIG6drtT5hE5.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Addressing Social Inequality</strong></span><br>Investigating and mitigating disparities in wealth, opportunities, and privileges within a society.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Improving Public Policy</strong></span><br>Conducting research to inform and enhance public policy decisions.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Fostering Community Development</strong></span><br>Promoting initiatives that enhance the social, economic, and cultural well-being of communities.</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Research Social Patterns And Human Behavior To Explain And Improve How Societies Work.</p>', 1, '2025-12-25 19:47:05', '2025-12-29 19:42:26'),
(20, '<p class=\"MsoNormal\">Provide Reliable Energy, <span style=\"color: #98d4fd;\">Manage Natural Resources Sustainably</span>, And Balance Development With Environmental Responsibility?</p>', 'Energy and Natural Resources Industry', 'categories/iZssRZV6RCeM3VLNyJ9bVo6hz5n7EaEROLoiobNE.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Transitioning to Renewable Energy</strong></span><br>Developing and promoting the use of renewable energy sources.<br><br><span style=\"color: #4d84ff;\"><strong>Managing Resource Depletion</strong></span><br>Ensuring the sustainable use of natural resources to prevent exhaustion.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Ensuring Energy Security</strong></span><br>Protecting the availability and reliability of energy supplies.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Reducing Environmental Impact</strong></span><br>Minimizing the environmental footprint of energy production and consumption.</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Provide Reliable Energy, Manage Natural Resources Sustainably, And Balance Development With Environmental Responsibility.</p>', 1, '2025-12-25 19:51:22', '2025-12-29 19:42:37'),
(21, '<p class=\"MsoNormal\">Improve Production Processes, Ensure Quality, And <span style=\"color: #98d4fd;\">Make Products Efficiently At Scale?</span></p>', 'Manufacturing and Production Industry', 'categories/M465qVUNkx3x7lPCeqNMTUPoGeXSxrfvu5QoLdZM.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Reducing Production Costs</strong></span><br>Innovating processes to lower the cost of manufacturing goods.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Improving Product Quality</strong></span><br>Ensuring high standards and consistency in manufacturing outputs.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Adopting Sustainable Manufacturing Practices</strong></span><br>Implementing eco-friendly processes to reduce environmental impact.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Integrating Automation and Robotics</strong></span><br>Utilizing advanced technologies to enhance manufacturing efficiency and precision.</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Improve Production Processes, Ensure Quality, And Make Products Efficiently At Scale.</p>', 1, '2025-12-25 19:54:57', '2025-12-29 19:42:58'),
(22, '<p class=\"MsoNormal\">Manage <span style=\"color: #98d4fd;\">Retail Operations And Digital Commerce Systems</span> That Connect Products, Businesses, And Consumers At Scale?</p>', 'Retail and E-commerce Industry', 'categories/ekwCgaXGUlufstph687kh00SnqKEZVbKLZYcWro4.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Managing Supply Chains</strong></span><br>Optimizing supply chain operations to ensure timely and efficient delivery of products.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Adapting to E-commerce Trends</strong></span><br>Embracing digital transformation to meet the demands of online consumers.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Ensuring Customer Satisfaction</strong></span><br>Providing excellent service and products to meet customer expectations.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Promoting Ethical Retail Practices</strong></span><br>Ensuring fair labor practices, sustainable sourcing, and ethical business conduct.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Manage Retail Operations And Digital Commerce Systems That Connect Products, Businesses, And Consumers At Scale.</p>', 1, '2025-12-25 19:59:18', '2025-12-29 19:43:25'),
(23, '<p class=\"MsoNormal\">Develop Sustainable Communities, Build Infrastructure, Manage Real Estate Assets And <span style=\"color: #98d4fd;\">Provide Housing Solutions?&nbsp;</span></p>', 'Real Estate and Construction Industry', 'categories/oEYnNRJhLCMsRQhfzoaQ5r3eMSggXCqCvAl54Grp.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Addressing Housing Shortages</strong></span><br>Developing affordable housing solutions to meet growing demand.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Promoting Green Building Practices</strong></span><br>Designing and constructing buildings with sustainability in mind.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Managing Urban Development</strong></span><br>Planning and executing urban projects that balance growth with livability.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Ensuring Construction Safety</strong></span><br>Implementing standards and practices to protect workers and occupants during and after construction.</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Develop Sustainable Communities, Build Infrastructure, Manage Real Estate Assets And Provide Housing Solutions.</p>', 1, '2025-12-25 20:09:21', '2025-12-29 19:43:42'),
(24, '<p class=\"MsoNormal\">Enable Communication, <br>Connect People, And <br><span style=\"color: #98d4fd;\">Advance Telecommunications Technologies?</span></p>', 'Telecommunications Industry', 'categories/EoJ8iV4Jk7Scbgj7d1TaMXkfpliuOYstWWh7GL9M.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Expanding Network Coverage</strong></span><br>Ensuring reliable telecommunications access in urban and rural areas.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Improving Communication Infrastructure</strong></span><br>Developing advanced infrastructure to support high-speed internet and connectivity.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Ensuring Data Privacy</strong></span><br>Protecting user data and ensuring secure communication channels.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Promoting Affordable Access</strong></span><br>Making telecommunications services accessible and affordable for all.</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Enable Communication, Connect People, And Advance Telecommunications Technologies.</p>', 1, '2025-12-25 20:13:11', '2025-12-29 19:43:59'),
(25, '<p class=\"MsoNormal\">Develop Advanced Aerospace Technologies, Ensure National Security, And <span style=\"color: #98d4fd;\">Explore Space?&nbsp;</span></p>', 'Aerospace and Defense Industry', 'categories/bDAWF00cAr655jeyUADtpPzpSUOnO3uzsBqFHwrV.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Innovating Aerospace Engineering</strong></span><br>Advancing technologies for aircraft, spacecraft, and related systems.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Enhancing Defense Systems</strong></span><br>Developing cutting-edge defense technologies to protect national security.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Promoting Space Exploration</strong></span><br>Facilitating the exploration of space and the development of space technologies.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Ensuring Safety in Aviation</strong></span><br>Maintaining high safety standards in air travel and aerospace operations.</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Develop Advanced Aerospace Technologies, Ensure National Security, And Explore Space.</p>', 1, '2025-12-25 20:21:22', '2025-12-29 19:44:14'),
(26, '<p class=\"MsoNormal\"><span style=\"color: #98d4fd;\">Develop Advanced Vehicles</span>, Improve Transportation, And Promote Automotive Innovation?&nbsp;</p>', 'Automotive Industry', 'categories/qmrZ74ZtyITNaaLvWwv6HJmxFfbD3yN9j3gis49X.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Advancing Electric Vehicle Technology</strong></span><br>Developing electric vehicles to reduce reliance on fossil fuels and decrease emissions.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Ensuring Vehicle Safety</strong></span><br>Enhancing safety features and technologies to protect drivers and passengers.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Reducing Emissions</strong></span><br>Implementing technologies and practices to lower vehicle emissions.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Enhancing Fuel Efficiency</strong></span><br>Innovating to improve the fuel efficiency of vehicles.</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Develop Advanced Vehicles, Improve Transportation, And Promote Automotive Innovation.</p>', 1, '2025-12-25 20:25:33', '2025-12-29 19:44:24'),
(27, '<p class=\"MsoNormal\">Develop Medicines And <span style=\"color: #98d4fd;\">Biotechnologies That Improve Health</span>, Treat Disease, And Advance Medical Science?</p>', 'Biotechnology and Pharmaceuticals Industry', 'categories/pEBByGQALtoFrYAFxdnw4A7uXF85cEvQMgCBUrxp.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Discovering New Drugs</strong></span><br>Conducting research to develop new medications and therapies.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Ensuring Drug Safety and Efficacy</strong></span><br>Testing and regulating drugs to ensure they are safe and effective for public use.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Addressing Regulatory Challenges</strong></span><br>Navigating complex regulations to bring new drugs and biotechnologies to market.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Promoting Biotechnological Innovation</strong></span><br>Encouraging advancements in biotechnology to improve healthcare.</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Develop Medicines And Biotechnologies That Improve Health, Treat Disease, And Advance Medical Science.</p>', 1, '2025-12-25 20:31:49', '2025-12-29 19:44:36'),
(28, '<p class=\"MsoNormal\">Work Within Government Systems To <span style=\"color: #98d4fd;\">Plan, Regulate, And Administer Public Services?</span></p>', 'Government and Public Administration Industry', 'categories/RiBxAAjNfZK9x3TVeVS0mdN0nGd4sjqrKC92ZFpt.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Ensuring Good Governance</strong></span><br>Promoting transparency, accountability, and ethical practices in government operations.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Promoting Transparency</strong></span><br>Making government actions and decisions open and accessible to the public.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Managing Public Funds</strong></span><br>Ensuring the efficient and effective use of public resources.</p>\r\n<p class=\"MsoNormal\">&nbsp;</p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Addressing Public Needs</strong></span><br>Developing and implementing policies to meet the needs of the population.</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Work Within Government Systems To Plan, Regulate, And Administer Public Services.</p>', 1, '2025-12-25 20:37:33', '2025-12-29 19:44:52');
INSERT INTO `industries` (`id`, `title`, `name`, `modal_image`, `modal_description`, `final_details`, `demo_status`, `created_at`, `updated_at`) VALUES
(29, '<p class=\"MsoNormal\">Create And Distribute Content That Entertains Audiences, Informs The Public, And <span style=\"color: #98d4fd;\">Shapes Cultural Trends?</span></p>', 'Entertainment and Media Industry', 'categories/Q8heIKxYW2WVce7x35dch5pqt1dOyFEyC3FWq3M3.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Creating Engaging Content</strong></span><br>Producing movies, television shows, music, and other forms of entertainment to captivate audiences.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Navigating Changing Media Landscapes</strong></span><br>Adapting to new technologies and platforms in the media industry.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Ensuring Content Diversity</strong></span><br>Promoting diverse perspectives and stories in media and entertainment.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Managing Intellectual Property</strong></span><br>Protecting the rights of creators and managing the use of intellectual property.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Promoting Ethical Journalism</strong></span><br>Upholding ethical standards in news reporting and media production.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Entertaining Masses</strong></span><br>Using various creative forms such as acting, music, and performance arts to entertain the public.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Influencing Public Opinion</strong></span><br>Leveraging celebrity status and media presence to shape societal views and trends.</p>\r\n<p>&nbsp;</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Create And Distribute Content That Entertains Audiences, Informs The Public, And Shapes Cultural Trends.</p>', 1, '2025-12-25 20:41:10', '2025-12-29 19:45:40'),
(30, '<p class=\"MsoNormal\">Provide <span style=\"color: #98d4fd;\">Essential Services And Skilled Labor</span> In Various Fields Such As Construction, Electrical Work, And Plumbing?&nbsp;</p>', 'Skilled Trades Industry', 'categories/XstQyzfrYmwQHIiH6rSQ5IDgE2KN3fjUALbZNQTq.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Providing Essential Services and Skilled Labor</strong></span><br>Offering crucial services in construction, electrical work, plumbing, and other trades.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Ensuring Workforce Training</strong></span><br>Providing education and training to develop skilled workers.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Maintaining Safety Standards</strong></span><br>Implementing safety protocols to protect workers in various trades.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Adapting to New Technologies</strong></span><br>Integrating advanced tools and technologies into skilled trade practices.<br><br></p>\r\n<p>&nbsp;</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Provide Essential Services And Skilled Labor In Various Fields Such As Construction, Electrical Work, And Plumbing.</p>', 1, '2025-12-25 20:43:45', '2025-12-29 19:45:55'),
(31, '<p class=\"MsoNormal\">Defend National Security, Protect Sovereignty, And <span style=\"color: #98d4fd;\">Support Peace And Stability </span>Through Military Service?</p>', 'Military Forces Industry', 'categories/JkT5wHj6Vtg1p3MINJ8b2u6OreaeJSPV3Bruj20P.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Protecting National Security</strong></span><br>Defending the nation against external threats.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Supporting Peacekeeping Missions</strong></span><br>Participating in international peacekeeping and conflict resolution efforts.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Providing Disaster Relief and Humanitarian Assistance</strong></span><br>Assisting in disaster response and humanitarian aid efforts.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Ensuring Troop Readiness and Welfare</strong></span><br>Maintaining the readiness and well-being of military personnel.<br><br></p>\r\n<p>&nbsp;</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Defend National Security, Protect Sovereignty, And Support Peace And Stability Through Military Service.</p>', 1, '2025-12-25 20:47:11', '2025-12-29 19:46:06'),
(32, '<p class=\"MsoNormal\"><span style=\"color: #98d4fd;\">Encourage Active Lifestyles </span>And Bring People Together Through Organized Sports And Recreation?</p>', 'Sports and Recreation Industry', 'categories/dbcrqTfSmxdF26piNkUFXKSWKI8vZFdlXBEXilus.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Promoting Physical Activity</strong></span><br>Encouraging individuals to engage in sports and physical exercise.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Enhancing Athletic Performance</strong></span><br>Supporting athletes in achieving peak performance.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Providing Recreational Opportunities</strong></span><br>Offering recreational activities and facilities for public enjoyment.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Ensuring Athlete Safety</strong></span><br>Implementing measures to protect athletes from injuries and health risks.</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Encourage Active Lifestyles And Bring People Together Through Organized Sports And Recreation.</p>', 1, '2025-12-25 20:50:21', '2025-12-29 19:46:15'),
(33, '<p class=\"MsoNormal\">Protect Public Safety, <span style=\"color: #98d4fd;\">Enforce Laws</span>, And Help Maintain Order And Trust Within Communities?</p>', 'Public Safety and Law Enforcement industry', 'categories/W4UPaUztPYm9lhvULrSzh6vsvHeV1MPvxTXcZJ33.png', '<p class=\"MsoNormal\">Your work will involve mitigating challenges such as:&nbsp;<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Protecting Citizens</strong></span><br>Ensuring the safety and security of individuals and communities.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Enforcing Laws</strong></span><br>Upholding laws and regulations to maintain public order.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Maintaining Public Order</strong></span><br>Managing emergencies and preventing crime.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Reducing Crime Rates</strong></span><br>Developing strategies to prevent and reduce crime in communities.<br><br></p>\r\n<p class=\"MsoNormal\"><span style=\"color: #4d84ff;\"><strong>Ensuring Community Trust</strong></span><br>Building positive relationships between law enforcement and the communities they serve.</p>', '<p class=\"MsoNormal\">You have shown interest to work for companies that Protect Public Safety, Enforce Laws, And Help Maintain Order And Trust Within Communities.</p>', 1, '2025-12-25 20:53:38', '2025-12-29 19:46:31');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_09_24_040409_create_personal_access_tokens_table', 1),
(5, '2025_09_28_072546_create_permission_tables', 1),
(6, '2025_10_21_025407_create_industries_table', 1),
(7, '2025_10_21_031025_create_departments_table', 1),
(8, '2025_10_23_094257_create_user_challenge_data_table', 1),
(9, '2025_10_23_180222_create_user_questionnaire_answers_table', 1),
(10, '2025_10_23_191834_create_user_submitted_answers_table', 1),
(11, '2025_10_28_151545_create_common_departments_table', 1),
(12, '2025_11_01_075129_create_sub_departments_table', 1),
(13, '2025_11_17_103832_create_password_reset_tokens_table', 2),
(14, '2026_02_17_000000_create_admin_allowed_ips_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('a@gmail.com', '$2y$12$keGWPHpMc2D9gEpClgSdIecLnWZPzu4WpYaYxdomZaR5iRa05WSGu', '2025-12-27 13:53:57'),
('abirak386@gmail.com', '$2y$12$yevSlyJ2iB14luNg/Pp1MOIwSZfFlFXgZuRNSNfTygV2aaGn8C.kO', '2026-01-13 05:34:35'),
('admin@gmail.com', '$2y$12$K8HhTsDLHOh7B8WylfF8O.r.nV0GmHrCBJzFTwVEXOoh7clEtjDGy', '2025-12-23 02:02:53'),
('alfahimbillah@gmail.com', '$2y$12$aUnuPsSCOY6/I5X37C8KlurpeX.Vxi/AIfwgyRq8DGE4vPEgAWY0K', '2026-01-21 00:54:48'),
('connected@gmail.com', '$2y$12$PeJkrKid93f0fSOV/Nqd0.iXEYZaoQqlrE9GMwgqqoeQXHURcJxYW', '2025-12-29 22:35:27'),
('connectedinquiries@gmail.com', '$2y$12$2XE43n77v0Qz0OnPB7Pgsu.IZYe2XF9qdSMYDdqGKc3hujEAYS/I6', '2025-12-19 03:38:32'),
('faijunnesapuspita@gmail.com', '$2y$12$czMYCwSi6rVfLxarhD0uHOs/ZBjxwNnaTJvNEv3JYiWnH.XJzX7kq', '2025-12-30 04:20:06'),
('hispidi4555@gmail.com', '$2y$12$TUDW1FZEUWasJKBQQXiMruPqib1Ps4zc5b3q5lSDLOCoh7A5FjZwa', '2026-01-26 22:47:54'),
('iffatakher@gmail.com', '$2y$12$xw1czX5AssWofwDxlVpgcOcoe6LR5LzMaCNH6UZwwTRn0QLFaADmC', '2026-02-18 21:16:18'),
('israfilsami85@gmail.com', '$2y$12$eiMvcjJyrI.l2bYr6H1N3eCp0hSirWBx/1SrW3rgPylN3Bb0Cl0oC', '2026-01-17 06:54:04'),
('maisha01connected@gmail.com', '$2y$12$bJ1RjDh1Ufw9tcGoHbFvJuDD4B0gbWCXJ0bs.2XmjSlP4lj6FRscm', '2026-01-19 21:43:50'),
('mondol242408@gmail.com', '$2y$12$pF0llkqO9IcrMnMp68oWtegvJmyTgCPIPzB5zVwtRiawHN.ahUtlC', '2026-01-18 23:37:44'),
('msrohan32@gmail.com', '$2y$12$OAXNC8VvlNq7TJxMvn2MXO2CodWxCGKN.ydZxzBCweSn0cqx77e/.', '2026-01-13 05:37:12'),
('muniaakhtar59@gmail.com', '$2y$12$cER1ucMuWST.4HEimMAohOExGjoynkAdw6.wXVzRQ5dUFKF.9s6vO', '2026-02-10 07:16:21'),
('nuzhattabassumakher@gmail.com', '$2y$12$P3I0gQc7NW9w8LTG0uANkOs.ukbtRAt6f3e5Na2M0UhfLyHxIUHlm', '2026-02-18 21:15:01'),
('ohedul.connected@gmail.com', '$2y$12$Lo5WoRP2LUJ3.gvwo1fjdegvqqupm89eKCgG6nMcsNMfkVTIgyWqm', '2025-12-19 04:05:18'),
('rjritubd@gmail.com', '$2y$12$pvD2cxIARKX5ne1hOnmyWuubeGM8Oa2soMkYsD4wn6Sg3pqNq3Fiy', '2026-01-19 22:38:14'),
('sameenirham248@gmail.com', '$2y$12$6IL0wVgQAtB0GkTKwCpVeeI9WSM6RCPJB9ThQtL4wdSn9VO19Qy5m', '2026-01-13 05:31:39'),
('shubhrodavid40@gmail.com', '$2y$12$FGfQh1faGBI9nfM/1c9zMuaq1BkMsIQZB4IT8QcbZnIgmQkTB5j5C', '2026-02-08 02:11:43'),
('siam.bin004@gmail.com', '$2y$12$0a1hbK85ypkwiITNnO0RBOG6dsCd7dhXk1.RzGxACdofxtj3P968m', '2026-01-17 07:58:55'),
('smdsulaiman6076@gmail.com', '$2y$12$IbZQk0Gv9QJ3OGRjiCH10e5uLjvzKxD0BAN6a.kFWYly4QOafVgXa', '2025-12-30 00:34:26'),
('syed.zeehad@connectededucation.ca', '$2y$12$4WbdtFUobWNCwgfAM15ibu5wNMDDhIwjkuEN1RjMwvaaT3rWOYyJi', '2025-12-05 23:10:36'),
('syed.zeehad@gmail.com', '$2y$12$Cxo.gyQHt3/CET1v7kUrv.W678GsB9ZQSid1pXQr2j0HVWBYqCpHq', '2025-12-27 09:14:14'),
('t@gmail.com', '$2y$12$1x/.OMc7s/aXT6MXs.AokuFQpg/ug/DnpWwlpKytggRYTx/w.mkk6', '2025-12-19 23:32:56'),
('test@gmail.com', '$2y$12$QaptHcSpVVnkp3eRfc7vq.WtxABljgtLSA.c5fM5sUIYiABVRb8Cy', '2026-01-17 08:20:41'),
('test2@gmail.com', '$2y$12$qKofTKk9aTuW8nX5fdiPP.mO6NBY/v9bzWfX/IixuEt5Iti8esJUK', '2026-02-17 02:45:21'),
('turnat0719@gmail.com', '$2y$12$L1.pHmSiIW7hqv40RT2lueV0IS5AKxyRnxbe8Y6PseUt3pDJj2nJ.', '2025-12-30 01:04:49'),
('user@gmail.com', '$2y$12$j6aA8.YYgWfk/RET2g8nCuvUzPk9UZUs.IZLBW9BK8fQlLnCsck0C', '2025-12-12 21:28:51'),
('users@gmail.com', '$2y$12$KcDgvUcBmEnOdvqVLytU/uMKCgVJzq4TmzxSjQ9PYrLrbGrihEoTW', '2025-12-08 05:31:24'),
('zebarezwana77@gmail.com', '$2y$12$zT0gLcTGUGLNw0qH49UjgubX2NdQEAlerH.lvYwN4pRSveNVlLZ32', '2026-01-21 00:50:19');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', '78e1d03903ab6c2be134e33de111347e3aa6adc6b643a67bc5a4d6abf5543d68', '[\"*\"]', '2025-11-07 13:07:53', NULL, '2025-11-07 11:39:56', '2025-11-07 13:07:53'),
(2, 'App\\Models\\User', 3, 'auth_token', '8534feacca0ffb7000d08d8fff2e0382c0df58808acebf6d5f6842441407630c', '[\"*\"]', '2025-11-07 13:08:28', NULL, '2025-11-07 13:05:32', '2025-11-07 13:08:28'),
(3, 'App\\Models\\User', 3, 'auth_token', '433a6ee105aefce70b68e18334bb8436e3f8b448f313981cf31dd839dc428b38', '[\"*\"]', '2025-11-09 05:21:09', NULL, '2025-11-09 05:20:02', '2025-11-09 05:21:09'),
(4, 'App\\Models\\User', 3, 'auth_token', 'c8dc53bee4c159965848c87646b635f40859b65ed8074746dad8d07a94de634a', '[\"*\"]', '2025-11-10 06:59:19', NULL, '2025-11-10 06:54:56', '2025-11-10 06:59:19'),
(5, 'App\\Models\\User', 3, 'auth_token', '584426677fd707ce5b73ce33342384b11cfd3a0fb898546b17c09bb58817987b', '[\"*\"]', '2025-11-10 07:03:31', NULL, '2025-11-10 07:00:48', '2025-11-10 07:03:31'),
(6, 'App\\Models\\User', 3, 'auth_token', '2faf18200ba3880530814e67d9fadd37380102e2932dbaa00c978239edb5693e', '[\"*\"]', '2025-11-10 07:04:18', NULL, '2025-11-10 07:04:13', '2025-11-10 07:04:18'),
(7, 'App\\Models\\User', 1, 'auth_token', 'd2dc993b70f06954436d8e3268040cc7c3f3e72ab831ad5073c071edc97dbd3b', '[\"*\"]', '2025-11-15 12:05:32', NULL, '2025-11-10 07:04:57', '2025-11-15 12:05:32'),
(8, 'App\\Models\\User', 3, 'auth_token', '12a2f2d7d40d2f78b4a4cdaf76e5e78010a151c42016f4e50a27937837cd7322', '[\"*\"]', '2025-11-11 13:19:52', NULL, '2025-11-10 07:15:46', '2025-11-11 13:19:52'),
(9, 'App\\Models\\User', 1, 'auth_token', '8eaf5beabfe785ad656b24d810133bd0532dce4a1cf0fdb4f7cc1e0b5c197537', '[\"*\"]', '2025-11-12 01:38:12', NULL, '2025-11-10 07:17:03', '2025-11-12 01:38:12'),
(10, 'App\\Models\\User', 3, 'auth_token', '46a479021abd83780e3d90a0bcd3106b9be86963bfb232a807804902896b5ddc', '[\"*\"]', '2025-11-10 22:32:39', NULL, '2025-11-10 22:31:00', '2025-11-10 22:32:39'),
(11, 'App\\Models\\User', 3, 'auth_token', 'b682d2945bfa28e175e8f69199058401f63dcfd665973da42b88a9b6cd6a11f8', '[\"*\"]', '2025-11-13 05:03:00', NULL, '2025-11-13 01:50:18', '2025-11-13 05:03:00'),
(12, 'App\\Models\\User', 3, 'auth_token', 'c0b05f633b16e024ce83aabdbbebbc34b9a100bd57a8cb5c92680cb062eceee3', '[\"*\"]', '2025-11-13 23:36:50', NULL, '2025-11-13 23:35:41', '2025-11-13 23:36:50'),
(13, 'App\\Models\\User', 3, 'auth_token', 'c05a65a415727b4747efa1019c21eb3d2939253791486cc32715817a78067132', '[\"*\"]', '2025-11-15 12:06:02', NULL, '2025-11-15 12:05:39', '2025-11-15 12:06:02'),
(14, 'App\\Models\\User', 3, 'auth_token', 'cd0ac02cde94c7a122fd1ccf1c45d21cd7939abe188ead1800969c988961eb9c', '[\"*\"]', '2025-11-16 02:33:22', NULL, '2025-11-16 02:33:06', '2025-11-16 02:33:22'),
(16, 'App\\Models\\User', 1, 'auth_token', 'bffd8e76c0d6d28ea596ce7cbb5e1d8d29c99457d88186b69e781ebd3134e504', '[\"*\"]', '2025-11-17 02:48:03', NULL, '2025-11-16 05:58:09', '2025-11-17 02:48:03'),
(17, 'App\\Models\\User', 3, 'auth_token', 'd3da87b0ee5c9f8191e16d8ba34e25ca849bb8179f7c1522c83317ac3aab80c0', '[\"*\"]', '2025-11-16 06:30:51', NULL, '2025-11-16 06:29:04', '2025-11-16 06:30:51'),
(18, 'App\\Models\\User', 3, 'auth_token', 'e73cdf3818769f0593766f0a3f00b5b6a3e0611091a78315264dba63b02772b7', '[\"*\"]', '2025-11-16 06:52:23', NULL, '2025-11-16 06:29:46', '2025-11-16 06:52:23'),
(19, 'App\\Models\\User', 3, 'auth_token', '06359078c3e1b0e5718529ee55ff029a9f3a603864b7ea3de4ad3527f3a6b500', '[\"*\"]', '2025-11-16 06:40:08', NULL, '2025-11-16 06:32:49', '2025-11-16 06:40:08'),
(20, 'App\\Models\\User', 1, 'auth_token', 'c43d7ddf5b9d3a42e35a35e16595b23e392ea3626ae47d758840b76136855e16', '[\"*\"]', '2025-11-16 06:41:53', NULL, '2025-11-16 06:41:09', '2025-11-16 06:41:53'),
(21, 'App\\Models\\User', 1, 'auth_token', '4211a5194a074da4bd0c8e4c2d422a24e6e52f133e8b84437d2b99fe10d7e229', '[\"*\"]', '2025-11-16 06:51:36', NULL, '2025-11-16 06:44:32', '2025-11-16 06:51:36'),
(22, 'App\\Models\\User', 3, 'auth_token', '97e969e4d6101f6713e9905e37dd51cf1690afff29c6b21768cd656b832e085e', '[\"*\"]', '2025-11-16 06:50:10', NULL, '2025-11-16 06:48:31', '2025-11-16 06:50:10'),
(24, 'App\\Models\\User', 1, 'auth_token', '07307db6de6fcd945acb83e54e7728c9a32e8a9255a50dbb3f828a9a28f5bd8b', '[\"*\"]', '2025-11-16 22:07:06', NULL, '2025-11-16 21:48:17', '2025-11-16 22:07:06'),
(25, 'App\\Models\\User', 1, 'auth_token', '0d341330980c94a6ee4b2809adef659a44ff8ca91b10577bb38222e4bc2c5fc6', '[\"*\"]', '2025-11-16 22:04:29', NULL, '2025-11-16 22:03:23', '2025-11-16 22:04:29'),
(26, 'App\\Models\\User', 1, 'auth_token', '5e70f467755c8c9babe26e36d2ff085f0cd742371eca2dd2db047ad637561d00', '[\"*\"]', '2025-11-16 22:07:12', NULL, '2025-11-16 22:07:11', '2025-11-16 22:07:12'),
(27, 'App\\Models\\User', 1, 'auth_token', 'e8d21085cbff2d1803d3c72baa42432002c093c06c361ad99c0590b4b4019d73', '[\"*\"]', '2025-11-16 22:08:16', NULL, '2025-11-16 22:07:53', '2025-11-16 22:08:16'),
(28, 'App\\Models\\User', 4, 'auth_token', 'bf96c30fba743bc46162c0f8a3f790799180944c49e9ab8b0b4d2b5401014ffd', '[\"*\"]', '2025-11-16 22:32:58', NULL, '2025-11-16 22:09:38', '2025-11-16 22:32:58'),
(29, 'App\\Models\\User', 1, 'auth_token', '2ed55fa2e598867e7ab37ac2970a682aca4c4129c210c2b03ccf0a821c65aa8c', '[\"*\"]', '2025-11-17 02:22:58', NULL, '2025-11-17 02:22:11', '2025-11-17 02:22:58'),
(30, 'App\\Models\\User', 1, 'auth_token', 'b3429a107bac32ab287407b0a8f422a3cb0a33a41625bc02dcb4d9d4ac0daf7e', '[\"*\"]', '2025-11-19 10:44:10', NULL, '2025-11-19 10:43:41', '2025-11-19 10:44:10'),
(31, 'App\\Models\\User', 5, 'auth_token', 'fb07f683608e9bfa8d672b238101db9e3bbc6db12f355d1340d2e8b0d0bea0e7', '[\"*\"]', '2025-11-19 10:44:39', NULL, '2025-11-19 10:44:29', '2025-11-19 10:44:39'),
(32, 'App\\Models\\User', 5, 'auth_token', '04854ba5cc7dceafb2dd563e1e659934ef3f4b1b436b46df2aca31f38fa8d213', '[\"*\"]', '2025-11-19 22:57:45', NULL, '2025-11-19 22:25:03', '2025-11-19 22:57:45'),
(33, 'App\\Models\\User', 4, 'auth_token', 'f0782b0bc886861b022b98188978f43fda2d8a62a8b3ef90ad6ba563e41e5fd7', '[\"*\"]', '2025-11-25 12:22:44', NULL, '2025-11-25 12:22:25', '2025-11-25 12:22:44'),
(34, 'App\\Models\\User', 4, 'auth_token', '0e1b5417f28bde8524a930e25a1a0ddb6a906146f0de9f1ad35119115166d257', '[\"*\"]', '2025-11-27 02:28:45', NULL, '2025-11-27 02:27:10', '2025-11-27 02:28:45'),
(35, 'App\\Models\\User', 4, 'auth_token', 'b4abfce00a6f694e7ebb7de2b0ea6d04b5aeffe409975ba4055ef5bde28b328a', '[\"*\"]', '2025-11-27 23:47:21', NULL, '2025-11-27 23:47:06', '2025-11-27 23:47:21'),
(36, 'App\\Models\\User', 1, 'auth_token', '093371566a86dfbe6cb708dd5c50fdbefda0736a8a407649bb95a4aa6a28b205', '[\"*\"]', '2025-11-28 04:45:20', NULL, '2025-11-28 04:15:07', '2025-11-28 04:45:20'),
(37, 'App\\Models\\User', 5, 'auth_token', 'd762d97fd4f9558914c8f4ef15279bff3f744ed9b08bbe99cc3b03c6c92a99ca', '[\"*\"]', '2025-11-28 04:45:20', NULL, '2025-11-28 04:15:27', '2025-11-28 04:45:20'),
(38, 'App\\Models\\User', 1, 'auth_token', '12b6c0aea86e36d43c42e3adefb9ebcd8a1ad4d4e56e6533d1d7c1e5fddf28ab', '[\"*\"]', '2025-11-28 08:30:43', NULL, '2025-11-28 04:56:10', '2025-11-28 08:30:43'),
(39, 'App\\Models\\User', 5, 'auth_token', 'fd6722c9588958ccd253d9fb7df9ec1657a0441db447273a80d46a8967b52f8b', '[\"*\"]', '2025-11-28 04:57:23', NULL, '2025-11-28 04:56:26', '2025-11-28 04:57:23'),
(40, 'App\\Models\\User', 1, 'auth_token', 'db3cfb455c16f4b96087b59d7bf6b0cf60f0cedc15098126e9926822fe3a109b', '[\"*\"]', '2025-11-28 08:06:21', NULL, '2025-11-28 08:06:08', '2025-11-28 08:06:21'),
(41, 'App\\Models\\User', 5, 'auth_token', 'fe9bc83d4b19085a58975e6b2cb69f7351c9f14c26a54bcac931ac1a2b2482f8', '[\"*\"]', '2025-11-28 08:11:42', '2025-12-01 08:06:54', '2025-11-28 08:06:54', '2025-11-28 08:11:42'),
(42, 'App\\Models\\User', 4, 'auth_token', '8f2a8cbde91f0faea324b6cabdcb6b37fd9368e08f4e9b672dcec38ccf46f6f5', '[\"*\"]', '2025-11-28 22:48:53', '2025-12-01 22:46:30', '2025-11-28 22:46:30', '2025-11-28 22:48:53'),
(43, 'App\\Models\\User', 5, 'auth_token', '41aa885eae6dcc17789370ee06e5f6f447fb57077abc222e12da97e775f5d56b', '[\"*\"]', '2025-11-29 21:04:18', '2025-12-02 20:49:46', '2025-11-29 20:49:46', '2025-11-29 21:04:18'),
(44, 'App\\Models\\User', 1, 'auth_token', '20158264c79b5e4cf6f3f67901fc4b9dfbe4402f7fd6a8dbf15283dc94f96ff8', '[\"*\"]', '2025-12-02 05:25:41', NULL, '2025-12-02 05:24:49', '2025-12-02 05:25:41'),
(45, 'App\\Models\\User', 1, 'auth_token', 'dcd9a77250e381d6fdf4456e46aa5d9adbbd5b0f6bb2c4c13eee6b4336c1533b', '[\"*\"]', NULL, NULL, '2025-12-04 21:25:19', '2025-12-04 21:25:19'),
(46, 'App\\Models\\User', 1, 'auth_token', 'e176431d60886112664fb29b0de0f22e498e73c6af967414f77e8789b7a28dce', '[\"*\"]', NULL, NULL, '2025-12-04 21:25:26', '2025-12-04 21:25:26'),
(47, 'App\\Models\\User', 1, 'auth_token', '2503bd0fcb4a76c66eeee05d8ad529e98046d8e5f7d6c260de581e58880d85eb', '[\"*\"]', NULL, NULL, '2025-12-04 21:25:29', '2025-12-04 21:25:29'),
(48, 'App\\Models\\User', 1, 'auth_token', '314076607db4c112473f57f5bc4a928dce0b117ab7224609618f5516419dd7e1', '[\"*\"]', '2025-12-04 21:26:19', NULL, '2025-12-04 21:26:18', '2025-12-04 21:26:19'),
(49, 'App\\Models\\User', 1, 'auth_token', '30d7838cf5b495be9cfd6daa7a0e8053ff733ac8bb778408dc2ffc84a579a990', '[\"*\"]', '2025-12-05 02:13:27', NULL, '2025-12-04 21:26:18', '2025-12-05 02:13:27'),
(50, 'App\\Models\\User', 1, 'auth_token', 'cf4d5213dce2ac0de61240bcbc5de2c81d6858c7814b27b0d61155c650389250', '[\"*\"]', '2025-12-05 02:12:22', NULL, '2025-12-05 02:11:21', '2025-12-05 02:12:22'),
(51, 'App\\Models\\User', 6, 'auth_token', '1b5f42a5a2ca55763e8662cd86eb6a0da1e3fde91a5d5f95ed00d82d48b42127', '[\"*\"]', '2025-12-05 03:41:10', '2025-12-08 02:13:50', '2025-12-05 02:13:50', '2025-12-05 03:41:10'),
(52, 'App\\Models\\User', 6, 'auth_token', 'ff31f5521d415ae22f39a0a4343691f26199e4e81fb4ed11c2e989895289d6f6', '[\"*\"]', '2025-12-05 06:26:46', '2025-12-08 04:38:33', '2025-12-05 04:38:33', '2025-12-05 06:26:46'),
(53, 'App\\Models\\User', 6, 'auth_token', '65bd88a79f0770438428ab7caf4ea39b587c0ee9e2f7ea9a24a907c6d76c316d', '[\"*\"]', '2025-12-05 04:48:40', '2025-12-08 04:44:53', '2025-12-05 04:44:53', '2025-12-05 04:48:40'),
(54, 'App\\Models\\User', 1, 'auth_token', 'e8f53f5ce20eb030492d18283c72509002f6a4e520345a553ee84dbe9c0ae04c', '[\"*\"]', '2025-12-05 07:31:06', NULL, '2025-12-05 05:40:14', '2025-12-05 07:31:06'),
(55, 'App\\Models\\User', 2, 'auth_token', '5a95d6ce35554ecbadaf6182ffa08d71e96d29e9bc8337dba8750aa7a6cbb5b5', '[\"*\"]', '2025-12-05 07:30:36', NULL, '2025-12-05 06:55:48', '2025-12-05 07:30:36'),
(56, 'App\\Models\\User', 1, 'auth_token', 'ca22c5ef94444421414f5e785dc47fd1cf56253f22e694f8b176b8dae8599121', '[\"*\"]', '2025-12-05 23:04:53', NULL, '2025-12-05 23:03:31', '2025-12-05 23:04:53'),
(57, 'App\\Models\\User', 1, 'auth_token', '1260fd050e54ef3c856705b5ce345b17cc5531de6d0ce9ac5cda000420a515e9', '[\"*\"]', '2025-12-05 23:10:37', NULL, '2025-12-05 23:08:06', '2025-12-05 23:10:37'),
(58, 'App\\Models\\User', 7, 'auth_token', 'b36b6469cd370ba624a80ce4280cb34b67561021fbebb7aabc6ce4fab2086137', '[\"*\"]', '2025-12-06 01:58:50', '2025-12-08 23:13:08', '2025-12-05 23:13:08', '2025-12-06 01:58:50'),
(59, 'App\\Models\\User', 2, 'auth_token', 'a270c32d1b16c733c89f9cd71cd34bf3d0365f8c399f79c025a86569cfb3cb0e', '[\"*\"]', '2025-12-05 23:16:11', NULL, '2025-12-05 23:16:09', '2025-12-05 23:16:11'),
(61, 'App\\Models\\User', 1, 'auth_token', 'c38f9892e18b3cc5e69afdc4fc14577c98173e3841e8d9bf0607b6a5ceab0c6b', '[\"*\"]', '2025-12-08 01:38:52', NULL, '2025-12-07 01:49:59', '2025-12-08 01:38:52'),
(62, 'App\\Models\\User', 7, 'auth_token', '1193dac054fa2daff2ec122f381a4ea32b270ffbf464d0e783734d02e564aa1c', '[\"*\"]', '2025-12-08 05:16:10', '2025-12-11 05:07:29', '2025-12-08 05:07:29', '2025-12-08 05:16:10'),
(63, 'App\\Models\\User', 1, 'auth_token', 'dc21a63098686b6a8c6b02233a35914168905ce35fb189172d5ad73f0df7a03d', '[\"*\"]', '2025-12-08 05:13:51', NULL, '2025-12-08 05:13:51', '2025-12-08 05:13:51'),
(64, 'App\\Models\\User', 1, 'auth_token', '1b0644a8d3cc2b876561d2edd48fc893c532551a222dca513145718977ccc210', '[\"*\"]', '2025-12-08 05:17:07', NULL, '2025-12-08 05:16:32', '2025-12-08 05:17:07'),
(65, 'App\\Models\\User', 1, 'auth_token', 'aaff790affaaf0844111e10ded9724ed88c7fb4dd732a523083431cbdb744f53', '[\"*\"]', '2025-12-09 23:22:15', NULL, '2025-12-08 05:30:38', '2025-12-09 23:22:15'),
(66, 'App\\Models\\User', 8, 'auth_token', '6c6da5106e91230f8e12ee0112912e4be1dbf911c76ce6be1f8d9e190ab35690', '[\"*\"]', '2025-12-08 05:50:50', '2025-12-11 05:31:45', '2025-12-08 05:31:45', '2025-12-08 05:50:50'),
(67, 'App\\Models\\User', 8, 'auth_token', 'ce882d0a97e358d91a047cd3a2864a29e529a53dc069ea008d8536db0fb390a4', '[\"*\"]', '2025-12-08 05:41:03', '2025-12-11 05:38:30', '2025-12-08 05:38:30', '2025-12-08 05:41:03'),
(68, 'App\\Models\\User', 1, 'auth_token', 'a5a11d466c32b5b9589ba48990ecdef47f65c7861d616547fc8927cf4e1a8261', '[\"*\"]', '2025-12-09 05:51:21', NULL, '2025-12-09 05:51:08', '2025-12-09 05:51:21'),
(69, 'App\\Models\\User', 1, 'auth_token', 'ec1ae47a1f5d324e33f38843883eaace87762056911f1a27e11732d69199161c', '[\"*\"]', '2025-12-10 07:17:54', NULL, '2025-12-10 07:17:51', '2025-12-10 07:17:54'),
(70, 'App\\Models\\User', 1, 'auth_token', '795b8de2e8afadce709cfb66d648adb84744ad508d19e0dc0dc559769d5e428d', '[\"*\"]', '2025-12-11 23:53:37', NULL, '2025-12-11 21:48:49', '2025-12-11 23:53:37'),
(71, 'App\\Models\\User', 9, 'auth_token', '6b9a536e68fb287c6b12b4048dcce005096ca63a7f5ed80cbf7137f5b149490c', '[\"*\"]', '2025-12-11 23:51:44', '2025-12-14 21:53:57', '2025-12-11 21:53:57', '2025-12-11 23:51:44'),
(72, 'App\\Models\\User', 9, 'auth_token', '9ef658e5ecda248793ef8abc9119298560640c52e6fa67d45a111df5c82cc6ea', '[\"*\"]', '2025-12-11 23:52:35', '2025-12-14 23:51:52', '2025-12-11 23:51:52', '2025-12-11 23:52:35'),
(73, 'App\\Models\\User', 9, 'auth_token', '66dca9e59a3a50294b2b7d5a4206c55bd4d75095f5d9f857e1a3fe5e5f003249', '[\"*\"]', '2025-12-12 00:44:00', '2025-12-15 00:41:10', '2025-12-12 00:41:10', '2025-12-12 00:44:00'),
(74, 'App\\Models\\User', 1, 'auth_token', '923d3a3c2ee7a95916d60da008c47752e94f131c0dde5a1959924416a04d6cc9', '[\"*\"]', '2025-12-12 21:28:52', NULL, '2025-12-12 09:15:32', '2025-12-12 21:28:52'),
(75, 'App\\Models\\User', 2, 'auth_token', 'a2c935eba419a6c2f25eacd50e7f8bfc94ae8ee37c3ec82295f381c51329cb83', '[\"*\"]', '2025-12-12 21:25:59', NULL, '2025-12-12 21:25:34', '2025-12-12 21:25:59'),
(76, 'App\\Models\\User', 10, 'auth_token', '39134e1d36b42898c84e36cdd9aec19d188f4957e00891515af59950e52b1e2a', '[\"*\"]', '2025-12-12 21:34:40', '2025-12-15 21:32:21', '2025-12-12 21:32:21', '2025-12-12 21:34:40'),
(77, 'App\\Models\\User', 9, 'auth_token', 'd4f746858ace91edd3705623fb73aa14888b8019644d625f912993ef0702d463', '[\"*\"]', '2025-12-13 01:37:51', '2025-12-16 01:36:40', '2025-12-13 01:36:40', '2025-12-13 01:37:51'),
(78, 'App\\Models\\User', 1, 'auth_token', '1f5c0a91c0daf82f0edc59e971f5699baf0357ac6dc99e39a50a813236295180', '[\"*\"]', '2025-12-13 01:52:40', NULL, '2025-12-13 01:37:58', '2025-12-13 01:52:40'),
(79, 'App\\Models\\User', 1, 'auth_token', '1d7d72106950c485e496ed3484705493776575a2734cfa33494de639210577ad', '[\"*\"]', '2025-12-13 02:40:38', NULL, '2025-12-13 02:39:01', '2025-12-13 02:40:38'),
(80, 'App\\Models\\User', 1, 'auth_token', 'df01ace00968f05202dcf8540f0283aee999088c2a6eef6e89451451a920e57f', '[\"*\"]', '2025-12-13 05:40:35', NULL, '2025-12-13 05:40:30', '2025-12-13 05:40:35'),
(81, 'App\\Models\\User', 10, 'auth_token', '8615075b815469a58c74c1978a67ad7e40e8004345a56e0cd48a7845c0263d42', '[\"*\"]', '2025-12-13 05:41:09', '2025-12-16 05:40:57', '2025-12-13 05:40:57', '2025-12-13 05:41:09'),
(82, 'App\\Models\\User', 1, 'auth_token', '689ad3d56eb245e4ab6ef3081fef01ac474beae6b52cb65e9cc1012d3f1d0787', '[\"*\"]', '2025-12-13 09:01:05', NULL, '2025-12-13 08:31:19', '2025-12-13 09:01:05'),
(83, 'App\\Models\\User', 1, 'auth_token', '8a6122d8a4bf447e6887ce7776668a0b6c7ae7e63d1f68df7d6858b4412b2f48', '[\"*\"]', '2025-12-13 08:37:53', NULL, '2025-12-13 08:37:53', '2025-12-13 08:37:53'),
(84, 'App\\Models\\User', 9, 'auth_token', 'cd167bd0e5a311d3930ee8fab77884bc5ec77e51b9a75f695afc3d232fd2816c', '[\"*\"]', '2025-12-13 08:38:01', '2025-12-16 08:38:01', '2025-12-13 08:38:01', '2025-12-13 08:38:01'),
(85, 'App\\Models\\User', 9, 'auth_token', 'f3ab01885c60ef29e6b908a91a937965eff72b8eefdcbc53327ab7cc7263779e', '[\"*\"]', '2025-12-13 09:18:17', '2025-12-16 08:38:01', '2025-12-13 08:38:01', '2025-12-13 09:18:17'),
(86, 'App\\Models\\User', 10, 'auth_token', '353e7c969fad3b2e92104bbb53f6d720000a369a0f937d198117a0a6608ac992', '[\"*\"]', '2025-12-14 05:52:04', '2025-12-17 05:24:58', '2025-12-14 05:24:58', '2025-12-14 05:52:04'),
(87, 'App\\Models\\User', 1, 'auth_token', '28c7bea8f98ffd4a649d87e10e04ed225269e8d8bcc81e47b801e6a05a4b708d', '[\"*\"]', '2025-12-19 03:36:59', NULL, '2025-12-19 03:28:04', '2025-12-19 03:36:59'),
(88, 'App\\Models\\User', 1, 'auth_token', '1b125eca11f98dee662668e4c3889d0ed5904aa7d964705361562473c7c241d1', '[\"*\"]', '2025-12-19 04:21:39', NULL, '2025-12-19 03:28:41', '2025-12-19 04:21:39'),
(89, 'App\\Models\\User', 1, 'auth_token', '75cdeb45b66d92e620f9c528043b1f8d94d91550a5ac57f7d150bfdd2746cf9d', '[\"*\"]', '2025-12-19 03:38:32', NULL, '2025-12-19 03:37:52', '2025-12-19 03:38:32'),
(90, 'App\\Models\\User', 11, 'auth_token', '180379005e82175846826bb15e11cb4541f23d74d03e6a7d766d7c05423daf8a', '[\"*\"]', '2025-12-19 03:52:26', '2025-12-22 03:41:55', '2025-12-19 03:41:55', '2025-12-19 03:52:26'),
(91, 'App\\Models\\User', 1, 'auth_token', '0d1ea53e6b3c2dbc13dfedb133ed1036256e0e950f5e6d1193deb7f45dc08ea8', '[\"*\"]', '2025-12-19 03:48:07', NULL, '2025-12-19 03:43:17', '2025-12-19 03:48:07'),
(92, 'App\\Models\\User', 1, 'auth_token', '02060492df4ef70397f99cacfd306b487c027ea74dcb4b6d4623602fe4bcb40e', '[\"*\"]', '2025-12-19 04:15:47', NULL, '2025-12-19 04:04:39', '2025-12-19 04:15:47'),
(93, 'App\\Models\\User', 12, 'auth_token', '2786126555be5dda850f69e025c2116635a2ca391539cbe336539970a79561bc', '[\"*\"]', '2025-12-19 04:07:32', NULL, '2025-12-19 04:06:40', '2025-12-19 04:07:32'),
(94, 'App\\Models\\User', 12, 'auth_token', 'b0c567646e1cedeea6d179335cf46c089c5b030b279a4324da4d430880bb4874', '[\"*\"]', '2025-12-19 04:14:28', '2025-12-22 04:07:36', '2025-12-19 04:07:36', '2025-12-19 04:14:28'),
(95, 'App\\Models\\User', 11, 'auth_token', 'eab491befb3dc530c50802e3c6f995b7fa3c1b024192a0c70dca95dabc076ef4', '[\"*\"]', '2025-12-19 04:16:00', '2025-12-22 04:15:58', '2025-12-19 04:15:58', '2025-12-19 04:16:00'),
(96, 'App\\Models\\User', 1, 'auth_token', '30e32b0a6daf8def69d46edaaa53df157f13cdbaa909bc023b427d6bf9406dba', '[\"*\"]', '2025-12-19 04:16:15', NULL, '2025-12-19 04:16:14', '2025-12-19 04:16:15'),
(97, 'App\\Models\\User', 1, 'auth_token', 'aff1b7dd1e786bfe9bca431fdbba7de28516543c9d7d5416ac90bcb24a10bb7a', '[\"*\"]', '2025-12-19 04:17:26', NULL, '2025-12-19 04:17:15', '2025-12-19 04:17:26'),
(98, 'App\\Models\\User', 11, 'auth_token', 'c91c8cd0b796ae79da8dd7eb3abdebd439125165152352daa05fce972dd04464', '[\"*\"]', '2025-12-19 04:20:08', '2025-12-22 04:18:15', '2025-12-19 04:18:15', '2025-12-19 04:20:08'),
(99, 'App\\Models\\User', 1, 'auth_token', 'ba3413022ce7242a7d6f8cf0bb8153408c82b870ff1105da0d88602563d87955', '[\"*\"]', '2025-12-19 23:36:39', NULL, '2025-12-19 23:32:02', '2025-12-19 23:36:39'),
(100, 'App\\Models\\User', 13, 'auth_token', '60558ee8764c0b7898331e5efce4eb4342d0671698960ddb51b87583e32c9f9a', '[\"*\"]', '2025-12-19 23:35:09', '2025-12-22 23:33:02', '2025-12-19 23:33:02', '2025-12-19 23:35:09'),
(101, 'App\\Models\\User', 1, 'auth_token', '03ad64f7d218fdc8f1f25fc4d0f453ad4cebca45fadcb8d9de4aad27804c5213', '[\"*\"]', '2025-12-23 02:02:54', NULL, '2025-12-23 02:02:00', '2025-12-23 02:02:54'),
(102, 'App\\Models\\User', 14, 'auth_token', '44221ae47d50465b8b43c88af14e0c359db648286fc7d859ef244ad27b5ee233', '[\"*\"]', '2025-12-23 02:03:16', NULL, '2025-12-23 02:03:16', '2025-12-23 02:03:16'),
(103, 'App\\Models\\User', 14, 'auth_token', '94de93f7e245b47e535c948cbdaa776e497da1225f1bf5d1afe762f53061c124', '[\"*\"]', '2025-12-23 03:49:34', NULL, '2025-12-23 03:49:33', '2025-12-23 03:49:34'),
(104, 'App\\Models\\User', 14, 'auth_token', 'ccc0f52e11bca4a8f53378d48e1d4ea1a569a62fdcdcb9639a01c677abc1b088', '[\"*\"]', '2025-12-23 03:52:13', NULL, '2025-12-23 03:52:11', '2025-12-23 03:52:13'),
(105, 'App\\Models\\User', 14, 'auth_token', '8a58d5c293abce46bdd49ee60edca33e42c645ea818d823ce41e8ab90d9d19bd', '[\"*\"]', '2025-12-23 04:07:40', NULL, '2025-12-23 03:53:54', '2025-12-23 04:07:40'),
(106, 'App\\Models\\User', 1, 'auth_token', 'c3edd2ebb9bd7d9a174383ff1d51bc553d880313616ffce884bfa41b1b077089', '[\"*\"]', '2025-12-23 04:58:35', NULL, '2025-12-23 04:55:34', '2025-12-23 04:58:35'),
(107, 'App\\Models\\User', 1, 'auth_token', 'a6627c3228599349438392c71c493120563fc233202b9f61606982b44f0471a9', '[\"*\"]', '2025-12-23 06:10:10', NULL, '2025-12-23 04:57:25', '2025-12-23 06:10:10'),
(108, 'App\\Models\\User', 1, 'auth_token', '96c5b0a1ddc376fee735a32501369ce79568e0a16bb2b996b7835e7c7e099725', '[\"*\"]', '2025-12-23 04:59:49', NULL, '2025-12-23 04:59:10', '2025-12-23 04:59:49'),
(109, 'App\\Models\\User', 1, 'auth_token', '4a3fab78d84d8c448039e3e39160c3313817115631e9d8fe3e833b4bb539870e', '[\"*\"]', '2025-12-23 05:00:16', NULL, '2025-12-23 05:00:07', '2025-12-23 05:00:16'),
(110, 'App\\Models\\User', 1, 'auth_token', '63dccbb9a4cc191d51e6ceea1f071e1fd43f66daf78869d055ddbe5c158930e4', '[\"*\"]', '2025-12-23 05:00:30', NULL, '2025-12-23 05:00:28', '2025-12-23 05:00:30'),
(111, 'App\\Models\\User', 14, 'auth_token', '5026cd0d401b336d560eff118ac819f92c67aff1132188fe558faffb82f6bbb2', '[\"*\"]', '2025-12-23 05:00:43', NULL, '2025-12-23 05:00:38', '2025-12-23 05:00:43'),
(112, 'App\\Models\\User', 1, 'auth_token', '03f8e9aab9fd814c36ae1a54c8714b8ae4e3dcfc4bbe03ed919c0f6dc968f87f', '[\"*\"]', '2025-12-23 05:00:55', NULL, '2025-12-23 05:00:51', '2025-12-23 05:00:55'),
(113, 'App\\Models\\User', 14, 'auth_token', 'd13abf7b625e8dd1733c73710fdcace41881247c133d985143d0d57af4a766c9', '[\"*\"]', '2025-12-23 05:03:17', NULL, '2025-12-23 05:01:02', '2025-12-23 05:03:17'),
(114, 'App\\Models\\User', 1, 'auth_token', '14d23e430c50f1fee73cac9dd1905de6c23959f5f338660e400c02ef3f87161f', '[\"*\"]', '2025-12-25 23:07:49', NULL, '2025-12-25 10:10:03', '2025-12-25 23:07:49'),
(115, 'App\\Models\\User', 14, 'auth_token', '48c83784c5c60df5c5bf56f57c3072e838997da54935a883ff77e22ec8f82914', '[\"*\"]', '2025-12-25 21:38:58', NULL, '2025-12-25 10:38:13', '2025-12-25 21:38:58'),
(116, 'App\\Models\\User', 1, 'auth_token', '3a3c2deaf739554c6f8b4f12828de03491f5529699c880a589b6529a7c6bb2d0', '[\"*\"]', '2025-12-26 08:06:57', NULL, '2025-12-26 07:45:37', '2025-12-26 08:06:57'),
(117, 'App\\Models\\User', 1, 'auth_token', '36161f350607a848fcff93ed1fa0d284c7818248b6806c6240ac43c233ae72ab', '[\"*\"]', '2025-12-26 23:48:07', NULL, '2025-12-26 08:30:57', '2025-12-26 23:48:07'),
(118, 'App\\Models\\User', 1, 'auth_token', '6ae422d41c94aafd0a84eb9274a1cec6788d97b4c15f8ff7d9358ba266fe381e', '[\"*\"]', '2025-12-26 23:53:57', NULL, '2025-12-26 23:53:48', '2025-12-26 23:53:57'),
(119, 'App\\Models\\User', 1, 'auth_token', 'b04a95b282ba3a787591e6a3ab8fa4535561f641d54f7597c13d30398feb6939', '[\"*\"]', '2025-12-27 09:12:17', NULL, '2025-12-27 08:40:58', '2025-12-27 09:12:17'),
(120, 'App\\Models\\User', 1, 'auth_token', '815f146fde572436ff6d81793df0029357c09b613f2356b07c4768596b192809', '[\"*\"]', '2025-12-27 09:14:17', NULL, '2025-12-27 09:12:58', '2025-12-27 09:14:17'),
(121, 'App\\Models\\User', 16, 'auth_token', 'f80843d5d49e9091909236e1495d3ed595e2d25b24abdb3d585f9481413e1495', '[\"*\"]', '2025-12-27 09:14:38', NULL, '2025-12-27 09:14:26', '2025-12-27 09:14:38'),
(122, 'App\\Models\\User', 1, 'auth_token', '33695c860d87827065c5a7d6bb6793ba70215173dcce45961b9f459e4f7b881f', '[\"*\"]', '2025-12-29 20:08:21', NULL, '2025-12-27 09:22:04', '2025-12-29 20:08:21'),
(123, 'App\\Models\\User', 1, 'auth_token', '2bf93983422d4d5bb7ca2c4e53b71ed2bb5ffdb0bf03a4e3bf133e9cbea1eec8', '[\"*\"]', '2025-12-27 13:06:02', NULL, '2025-12-27 13:05:18', '2025-12-27 13:06:02'),
(124, 'App\\Models\\User', 1, 'auth_token', 'ebd3c9ddbd86f1aefb4286db296d89d9bb9a8287ebd973f6db698c3479bfca12', '[\"*\"]', '2025-12-27 16:20:28', NULL, '2025-12-27 13:40:57', '2025-12-27 16:20:28'),
(125, 'App\\Models\\User', 17, 'auth_token', '7abbd80f870a29abab374b548236aee1a7f8026de798479afd3ef95853d21e0d', '[\"*\"]', '2025-12-27 14:02:17', '2025-12-30 13:54:27', '2025-12-27 13:54:27', '2025-12-27 14:02:17'),
(126, 'App\\Models\\User', 1, 'auth_token', '23730ebe4d7d7a8dfebb2b1f8865abe710715ac601a03b801e1fbad8bde8e5d2', '[\"*\"]', '2025-12-27 16:23:34', NULL, '2025-12-27 16:22:39', '2025-12-27 16:23:34'),
(127, 'App\\Models\\User', 16, 'auth_token', '2af3db8a83b06804d7b8c61203ceb5e48c7a5a59a87913473aac557e55da2a7c', '[\"*\"]', '2025-12-28 21:42:55', NULL, '2025-12-28 21:28:50', '2025-12-28 21:42:55'),
(128, 'App\\Models\\User', 16, 'auth_token', '24c050697fc921487b4eb94185dd36cc3a96ae2cfa9cb209b48a736b80b6204a', '[\"*\"]', '2025-12-28 23:13:42', NULL, '2025-12-28 21:48:03', '2025-12-28 23:13:42'),
(129, 'App\\Models\\User', 1, 'auth_token', '213ea52c2c677bbdbe9ff81e36ad463be0104fa7595c8e5459b78afb4c2d3105', '[\"*\"]', '2025-12-29 07:19:21', NULL, '2025-12-28 21:52:22', '2025-12-29 07:19:21'),
(130, 'App\\Models\\User', 1, 'auth_token', 'cdc221ef29590cf57811addaa79c95caf21ce6bba08d55c06e16c1633f6e5fee', '[\"*\"]', '2025-12-28 23:17:04', NULL, '2025-12-28 23:15:37', '2025-12-28 23:17:04'),
(131, 'App\\Models\\User', 18, 'auth_token', '0a593cb198da838062b62e51df052b5db34b2009ecd3b15a8a9884fbe117fe83', '[\"*\"]', '2025-12-28 23:20:03', '2025-12-31 23:17:23', '2025-12-28 23:17:23', '2025-12-28 23:20:03'),
(132, 'App\\Models\\User', 18, 'auth_token', '2235dffbdb8ba83a91898a32d596ad4ac157537727c431afadf8a6af0d17e780', '[\"*\"]', '2025-12-29 07:11:23', '2026-01-01 07:03:12', '2025-12-29 07:03:12', '2025-12-29 07:11:23'),
(133, 'App\\Models\\User', 1, 'auth_token', '02c7e60fd85eba63f12c84e205a6e3348f693719eec369c3030f7b9c1147594c', '[\"*\"]', '2025-12-29 07:14:02', NULL, '2025-12-29 07:10:31', '2025-12-29 07:14:02'),
(134, 'App\\Models\\User', 16, 'auth_token', '5bdfb958894c042bf3ba0ccfe5423c4a7c376bda6b6a28ac71255180ce1ae5f7', '[\"*\"]', '2025-12-29 07:19:33', NULL, '2025-12-29 07:15:43', '2025-12-29 07:19:33'),
(135, 'App\\Models\\User', 16, 'auth_token', 'f3bc5b4481cba281489100e26772eca2f32bd1607b1315e80025d1410e623c76', '[\"*\"]', '2025-12-29 20:01:29', NULL, '2025-12-29 10:19:38', '2025-12-29 20:01:29'),
(136, 'App\\Models\\User', 16, 'auth_token', '4c718954e2a71bef6ffebf88f4b0daad4bc45592ccfa39859f93b576c5295c00', '[\"*\"]', '2025-12-29 20:01:50', NULL, '2025-12-29 19:54:48', '2025-12-29 20:01:50'),
(137, 'App\\Models\\User', 1, 'auth_token', '6a5dddf0822d009207490a709568eda1c416daba4549e567da22d2c1054b704d', '[\"*\"]', '2025-12-30 00:34:26', NULL, '2025-12-29 22:33:05', '2025-12-30 00:34:26'),
(138, 'App\\Models\\User', 20, 'auth_token', '1feef00eb03d66e21ffa92e9a5ec679baa7c08e785f513a79f56c55d877e2bd7', '[\"*\"]', '2025-12-29 23:01:34', '2026-01-01 22:37:23', '2025-12-29 22:37:23', '2025-12-29 23:01:34'),
(139, 'App\\Models\\User', 21, 'auth_token', '13aecfbf29a33da13caabe345f6072ef8ced94e26d776b72059cdced5f57c07f', '[\"*\"]', '2025-12-30 00:34:56', '2026-01-02 00:34:44', '2025-12-30 00:34:44', '2025-12-30 00:34:56'),
(140, 'App\\Models\\User', 21, 'auth_token', 'ddc2f97734338b672633529a452f92f487b46764292d65edd0b7b9c52723e213', '[\"*\"]', '2025-12-30 02:32:01', '2026-01-02 00:36:59', '2025-12-30 00:36:59', '2025-12-30 02:32:01'),
(141, 'App\\Models\\User', 20, 'auth_token', 'dc3428dd6de440a66f16d96b37c74584f1673b1821e27a710ba4098115b040b6', '[\"*\"]', '2025-12-30 00:37:41', '2026-01-02 00:37:41', '2025-12-30 00:37:41', '2025-12-30 00:37:41'),
(142, 'App\\Models\\User', 1, 'auth_token', '8bbbe87e8067a11ec4dd9bebb28451d393e2b3f3db119cddcab857a74e3a5260', '[\"*\"]', '2025-12-30 01:04:49', NULL, '2025-12-30 01:03:34', '2025-12-30 01:04:49'),
(143, 'App\\Models\\User', 22, 'auth_token', '539f66eafff031269a7b43022394a77e62317c698230987e9ca588186ffa5bb9', '[\"*\"]', '2025-12-30 01:08:26', '2026-01-02 01:05:32', '2025-12-30 01:05:32', '2025-12-30 01:08:26'),
(144, 'App\\Models\\User', 22, 'auth_token', 'c02f5f18bc9baca65e42554e52eec5a655e9ee204dcfe5d5b9dc9e5e3a074dd8', '[\"*\"]', '2025-12-30 01:51:10', '2026-01-02 01:08:05', '2025-12-30 01:08:05', '2025-12-30 01:51:10'),
(145, 'App\\Models\\User', 18, 'auth_token', 'a52648923944d76c36174eae26a4920c0b23f055f7453e62423d8633e76c0169', '[\"*\"]', '2025-12-30 07:06:31', '2026-01-02 01:39:55', '2025-12-30 01:39:55', '2025-12-30 07:06:31'),
(146, 'App\\Models\\User', 1, 'auth_token', '0996408d712a9f097abddc3c51caed131ef811bd9914177fcbeaf34b3bd20b32', '[\"*\"]', '2025-12-30 04:23:53', NULL, '2025-12-30 01:40:18', '2025-12-30 04:23:53'),
(147, 'App\\Models\\User', 20, 'auth_token', 'cdd6c3e2a661869929648bf19a716ab662378e27d30a7eb8840f9e9484ed8d13', '[\"*\"]', '2025-12-30 01:56:39', '2026-01-02 01:51:21', '2025-12-30 01:51:21', '2025-12-30 01:56:39'),
(148, 'App\\Models\\User', 22, 'auth_token', '824c67d28a7eec4bb1b94665dff61d606aeeda2078ab68c6c28261df79286c91', '[\"*\"]', '2025-12-30 01:52:22', '2026-01-02 01:52:22', '2025-12-30 01:52:22', '2025-12-30 01:52:22'),
(149, 'App\\Models\\User', 22, 'auth_token', '1fa03e7266650d52f43dae9fb6de1608ab917fc4bfc5d417a63acef36f955877', '[\"*\"]', '2025-12-30 01:53:57', '2026-01-02 01:53:57', '2025-12-30 01:53:57', '2025-12-30 01:53:57'),
(150, 'App\\Models\\User', 1, 'auth_token', 'a10d7c6b74b164b1ea56b15ca2c2d000f887b307269bbe5c97242dab87446277', '[\"*\"]', '2025-12-30 04:24:34', NULL, '2025-12-30 03:09:36', '2025-12-30 04:24:34'),
(151, 'App\\Models\\User', 1, 'auth_token', '752bd9755061b05fd06e5bda30af4c3172c61625a0374db200d6087a12917bcd', '[\"*\"]', '2025-12-30 04:20:21', NULL, '2025-12-30 04:18:44', '2025-12-30 04:20:21'),
(152, 'App\\Models\\User', 23, 'auth_token', '306a98d4d5fe3899a4ec7ad95998775911be3c206ce25e2a958c4679a260672f', '[\"*\"]', '2025-12-30 04:20:56', '2026-01-02 04:20:34', '2025-12-30 04:20:34', '2025-12-30 04:20:56'),
(153, 'App\\Models\\User', 20, 'auth_token', 'f3b68bc452656c80a07b56fe546102a2a4cb6c231fe08edc389ccd5487404b88', '[\"*\"]', '2025-12-30 04:27:31', '2026-01-02 04:25:54', '2025-12-30 04:25:54', '2025-12-30 04:27:31'),
(154, 'App\\Models\\User', 20, 'auth_token', 'be053a583cd520c336a4028aab6d240e92a9421b130286244bc889cf2074d873', '[\"*\"]', '2025-12-30 04:29:17', '2026-01-02 04:29:16', '2025-12-30 04:29:16', '2025-12-30 04:29:17'),
(155, 'App\\Models\\User', 18, 'auth_token', 'ace38752dbbf65a582448e2e2694d715fb895e6015c6269533b2700f277d7d2d', '[\"*\"]', '2025-12-30 04:29:52', '2026-01-02 04:29:43', '2025-12-30 04:29:43', '2025-12-30 04:29:52'),
(156, 'App\\Models\\User', 23, 'auth_token', 'd8224407ca3aed0bc55d7dbe18f00af0562390eab76245d79ca924a353ecfc17', '[\"*\"]', '2025-12-30 05:26:32', '2026-01-02 04:34:09', '2025-12-30 04:34:09', '2025-12-30 05:26:32'),
(157, 'App\\Models\\User', 1, 'auth_token', '8bb7164a9309c288591b0c7f5a4c93e59582427dfa0556d6595aa098ebcef529', '[\"*\"]', '2025-12-30 05:27:15', NULL, '2025-12-30 05:27:10', '2025-12-30 05:27:15'),
(158, 'App\\Models\\User', 1, 'auth_token', '86ef011e017c0a967626e637ca012b140e45976ebeca94838a7ce1122558b437', '[\"*\"]', '2025-12-30 06:54:18', NULL, '2025-12-30 06:26:21', '2025-12-30 06:54:18'),
(159, 'App\\Models\\User', 1, 'auth_token', '3ac16bb9043163b69abff324338e7c7dedc9a171d8f54f5c335a452256c359b3', '[\"*\"]', '2025-12-30 07:50:01', NULL, '2025-12-30 07:48:59', '2025-12-30 07:50:01'),
(160, 'App\\Models\\User', 22, 'auth_token', 'e4754463fb9c4cd5872d30197eef9194da77ccc1fc16b7511d3a6b89d10f4f37', '[\"*\"]', '2025-12-30 07:56:48', '2026-01-02 07:50:09', '2025-12-30 07:50:09', '2025-12-30 07:56:48'),
(161, 'App\\Models\\User', 16, 'auth_token', '03ff527a196e8012760bff3d2b6017e4f4243661037f25776d6014995fa58f4f', '[\"*\"]', '2025-12-30 07:59:08', NULL, '2025-12-30 07:50:44', '2025-12-30 07:59:08'),
(162, 'App\\Models\\User', 22, 'auth_token', '15a8ea22bbc71a34fcea7b829d7e73865d75362d6fce13252e33afc10f7da096', '[\"*\"]', '2025-12-31 01:05:55', '2026-01-03 01:03:37', '2025-12-31 01:03:37', '2025-12-31 01:05:55'),
(163, 'App\\Models\\User', 1, 'auth_token', 'a5a267929a6ddb095bcd2f9762c584fb143f59c019196e7f26c2dcb9ab643cb1', '[\"*\"]', '2025-12-31 03:53:01', NULL, '2025-12-31 03:23:06', '2025-12-31 03:53:01'),
(164, 'App\\Models\\User', 18, 'auth_token', 'c0f335e32c1f0102c4da3cd24accd32c65ad6e6eb2a20d02eeb64c30eed85766', '[\"*\"]', '2025-12-31 03:54:01', '2026-01-03 03:51:21', '2025-12-31 03:51:21', '2025-12-31 03:54:01'),
(165, 'App\\Models\\User', 1, 'auth_token', '25e849562e3206e0e07764e25d58514cee82b88bf4a30bc6464c40662f90d2f4', '[\"*\"]', '2026-01-04 04:04:07', NULL, '2026-01-04 04:04:04', '2026-01-04 04:04:07'),
(166, 'App\\Models\\User', 1, 'auth_token', '750ce4f96711435a7d1376c870bb26e26379fe23d9cbe9e7edef5735d03949b5', '[\"*\"]', '2026-01-12 06:24:52', NULL, '2026-01-12 06:24:04', '2026-01-12 06:24:52'),
(167, 'App\\Models\\User', 1, 'auth_token', '64a43b71adee34ddcc136d76babfb79307c30db3383a37022386b8dd8b23f8ab', '[\"*\"]', '2026-01-12 09:45:46', NULL, '2026-01-12 09:45:31', '2026-01-12 09:45:46'),
(168, 'App\\Models\\User', 1, 'auth_token', 'b1953cd84eec3d090942bb62e2e7161511706c915f25b6fea26b65641bc35289', '[\"*\"]', '2026-01-13 05:31:39', NULL, '2026-01-13 05:31:11', '2026-01-13 05:31:39'),
(169, 'App\\Models\\User', 25, 'auth_token', '9619f5237f5bc26dae256a6af547321063db146909eb50df5e7d28206f363e3d', '[\"*\"]', '2026-01-13 05:32:23', '2026-01-16 05:31:49', '2026-01-13 05:31:49', '2026-01-13 05:32:23'),
(170, 'App\\Models\\User', 1, 'auth_token', '6f6b11ef94abe69aa8bbdb3b1b071f1ff6020e8e248f5bcf1e6db1c1156b0707', '[\"*\"]', '2026-01-13 05:34:35', NULL, '2026-01-13 05:33:57', '2026-01-13 05:34:35'),
(171, 'App\\Models\\User', 26, 'auth_token', '9d03efc08d2920b132af7b8b680be6d72ef1adf4f0f2070753968b1c1200b56a', '[\"*\"]', '2026-01-13 05:35:32', '2026-01-16 05:35:26', '2026-01-13 05:35:26', '2026-01-13 05:35:32'),
(172, 'App\\Models\\User', 25, 'auth_token', '8c7009b73e3bbd6b4ffecf55807b6d66c60822c9237cdde24b9730056f99a64b', '[\"*\"]', '2026-01-13 05:43:26', '2026-01-16 05:36:45', '2026-01-13 05:36:45', '2026-01-13 05:43:26'),
(173, 'App\\Models\\User', 1, 'auth_token', '15663162d8d5fb373796e56e91686747a0f58764f513f45fb753d4ed442d16ab', '[\"*\"]', '2026-01-13 05:37:12', NULL, '2026-01-13 05:36:50', '2026-01-13 05:37:12'),
(174, 'App\\Models\\User', 26, 'auth_token', '98a6d21c55107daffc26bd7de9fac023056cb4b10add8d4e0c6544affe623ae0', '[\"*\"]', '2026-01-13 06:05:45', '2026-01-16 05:37:38', '2026-01-13 05:37:38', '2026-01-13 06:05:45'),
(175, 'App\\Models\\User', 27, 'auth_token', 'b72361017a528e7dc4f75711259cfbe0cea075ba1b50b90db70dbf213b82636a', '[\"*\"]', '2026-01-13 05:37:50', '2026-01-16 05:37:38', '2026-01-13 05:37:38', '2026-01-13 05:37:50'),
(176, 'App\\Models\\User', 27, 'auth_token', '0375aa9a4905ccc00a2e6f40d1bea97b90e4210e2ebd9765413e2d023f69ee35', '[\"*\"]', '2026-01-13 07:46:27', '2026-01-16 05:40:40', '2026-01-13 05:40:40', '2026-01-13 07:46:27'),
(177, 'App\\Models\\User', 1, 'auth_token', '80ef1e83fd1bafc4b5538c0d24799feb7f43bbb2935a4e3923340d42bd4410e4', '[\"*\"]', '2026-01-13 05:48:27', NULL, '2026-01-13 05:48:12', '2026-01-13 05:48:27'),
(178, 'App\\Models\\User', 25, 'auth_token', 'bbad76479e1172660b5d8fd187725f3ba5403bbd42843f8b403ae6fa32438468', '[\"*\"]', '2026-01-13 07:06:11', '2026-01-16 05:49:44', '2026-01-13 05:49:44', '2026-01-13 07:06:11'),
(179, 'App\\Models\\User', 1, 'auth_token', 'a2e49cdf7c7af8e4cce432a6ff728ccea0d38100a78032a5eb4decdaf7fd57c3', '[\"*\"]', '2026-01-13 06:10:56', NULL, '2026-01-13 06:10:25', '2026-01-13 06:10:56'),
(180, 'App\\Models\\User', 1, 'auth_token', 'f1b25c8fe97d5ff028a2154f9bc1dc4cf1669061ddc345f3878a22ad4069a7e3', '[\"*\"]', '2026-01-13 07:06:41', NULL, '2026-01-13 06:57:45', '2026-01-13 07:06:41'),
(181, 'App\\Models\\User', 1, 'auth_token', 'd302a82f8750a60d372a9fbcdcd9676f1d6a214113ea0bef0f5372e1d84b6381', '[\"*\"]', '2026-01-14 00:34:29', NULL, '2026-01-14 00:34:22', '2026-01-14 00:34:29'),
(182, 'App\\Models\\User', 1, 'auth_token', 'a1460c59d97a7a6894153abd98b4b22f929b07320462b8e1a2dc55ff28485a0b', '[\"*\"]', '2026-01-14 00:59:05', NULL, '2026-01-14 00:58:49', '2026-01-14 00:59:05'),
(183, 'App\\Models\\User', 1, 'auth_token', '9514dc5012d8d6e81230ee4efe34c794af4efadea6fc03083eef857c61c042fc', '[\"*\"]', '2026-01-14 09:33:56', NULL, '2026-01-14 09:19:58', '2026-01-14 09:33:56'),
(184, 'App\\Models\\User', 1, 'auth_token', '2ce12298c007ecc78d120e81fdbed0594a27eb26575afb403dbd3936d1f7b9bf', '[\"*\"]', '2026-01-17 06:54:04', NULL, '2026-01-17 06:44:06', '2026-01-17 06:54:04'),
(185, 'App\\Models\\User', 28, 'auth_token', '1f445d3d440ec9354bf4cb26ae2fd3b9cf333b6332d883d8488698bc9494a09f', '[\"*\"]', '2026-01-17 06:54:46', '2026-01-20 06:54:38', '2026-01-17 06:54:38', '2026-01-17 06:54:46'),
(186, 'App\\Models\\User', 28, 'auth_token', '8740c240bfa51358b4e7d33e7b1ae47641ce9b84d8eb66a16b3ab0ef10869001', '[\"*\"]', '2026-01-17 07:11:12', '2026-01-20 07:08:54', '2026-01-17 07:08:54', '2026-01-17 07:11:12'),
(187, 'App\\Models\\User', 28, 'auth_token', 'a80636792c15f56dea092b4092de3f2dfa8b6deb0291419d42139401a57491a0', '[\"*\"]', '2026-01-17 07:57:42', '2026-01-20 07:48:18', '2026-01-17 07:48:18', '2026-01-17 07:57:42'),
(188, 'App\\Models\\User', 1, 'auth_token', '5068ee8674feb816b85e4d20af8a86ececcbd739926b3bf81e852bd227fde289', '[\"*\"]', '2026-01-17 08:28:04', NULL, '2026-01-17 07:57:51', '2026-01-17 08:28:04'),
(189, 'App\\Models\\User', 1, 'auth_token', '14d94928277c61702d2bef96e5f7306fd96a3ca70421749a6fbc848c24bdf33a', '[\"*\"]', '2026-01-17 08:21:21', NULL, '2026-01-17 08:20:01', '2026-01-17 08:21:21'),
(190, 'App\\Models\\User', 30, 'auth_token', '22e91dacc74921b45c3bbfff3f55e2d88dee9e32c55ecccd5d9220bd23ea4c14', '[\"*\"]', '2026-01-17 08:21:35', '2026-01-20 08:21:34', '2026-01-17 08:21:34', '2026-01-17 08:21:35'),
(191, 'App\\Models\\User', 28, 'auth_token', 'e2938803c01725ce581eabffb061347c784f47c3522a2133957616794a7a510e', '[\"*\"]', '2026-01-17 08:28:40', '2026-01-20 08:28:24', '2026-01-17 08:28:24', '2026-01-17 08:28:40'),
(192, 'App\\Models\\User', 1, 'auth_token', 'facb4255d5b55a0e96fe512bba72e51250380993f98bbbdaec0b5f7d92b7f6fa', '[\"*\"]', '2026-01-17 08:28:58', NULL, '2026-01-17 08:28:45', '2026-01-17 08:28:58'),
(193, 'App\\Models\\User', 29, 'auth_token', '95e9d4f6168feda1b8ca0d800387c422bfdfa90ce401704a2992e54ddfc88c41', '[\"*\"]', '2026-01-17 11:58:42', '2026-01-20 11:58:41', '2026-01-17 11:58:41', '2026-01-17 11:58:42'),
(194, 'App\\Models\\User', 28, 'auth_token', '48ff87f08b921a334f932d7e5dbe21245441868b8a074fba30ccc8028bc86bb2', '[\"*\"]', '2026-01-17 23:05:17', '2026-01-20 22:49:27', '2026-01-17 22:49:27', '2026-01-17 23:05:17'),
(195, 'App\\Models\\User', 29, 'auth_token', '173c4dfe69d12bf99a8b105978f921b258f89e6e7f864839999defe0c8d3024e', '[\"*\"]', '2026-01-18 02:50:48', '2026-01-21 02:31:07', '2026-01-18 02:31:07', '2026-01-18 02:50:48'),
(196, 'App\\Models\\User', 1, 'auth_token', '797fc3bc608e648838e0145f8bd51c5533bedadc4c564504cfb3ef53c9fa4226', '[\"*\"]', '2026-01-18 23:37:44', NULL, '2026-01-18 23:37:06', '2026-01-18 23:37:44'),
(197, 'App\\Models\\User', 31, 'auth_token', '18649b6b64b5feb953e9d52c2fc82864c2127258c18ca3f66ebb0e4a92a82bd3', '[\"*\"]', '2026-01-18 23:44:39', '2026-01-21 23:39:55', '2026-01-18 23:39:55', '2026-01-18 23:44:39'),
(198, 'App\\Models\\User', 31, 'auth_token', '45fdf71709d49660fdfe2f6434f5c1bbe1ff49db1576f8b455b42d9a8b07f4e6', '[\"*\"]', '2026-01-18 23:48:59', '2026-01-21 23:48:40', '2026-01-18 23:48:40', '2026-01-18 23:48:59'),
(199, 'App\\Models\\User', 31, 'auth_token', '460800767cd1d764c8e2612a7791058021d8e55cc0ca407c37cc1a5f3425a94c', '[\"*\"]', '2026-01-19 00:54:14', '2026-01-21 23:49:16', '2026-01-18 23:49:16', '2026-01-19 00:54:14'),
(200, 'App\\Models\\User', 29, 'auth_token', '5df156012d5ffdd773964c307247d4d1d55aedb01e90df657aee7abbf60beabc', '[\"*\"]', '2026-01-19 00:53:39', '2026-01-22 00:34:58', '2026-01-19 00:34:58', '2026-01-19 00:53:39'),
(201, 'App\\Models\\User', 31, 'auth_token', '9461ad50e9c71d672afead8040cccbb62410e611273fb6cfd03831045491b234', '[\"*\"]', '2026-01-19 03:33:28', '2026-01-22 03:33:25', '2026-01-19 03:33:25', '2026-01-19 03:33:28'),
(202, 'App\\Models\\User', 31, 'auth_token', 'a2cbd24cdd19d7fa2e785a971f712dbd8b0d68eda3ba74712082c817d14fbc02', '[\"*\"]', '2026-01-19 04:52:30', '2026-01-22 04:04:32', '2026-01-19 04:04:32', '2026-01-19 04:52:30'),
(203, 'App\\Models\\User', 1, 'auth_token', 'b5869c03bf1fe2142d3e63a2df29ac38db3e2f52bea1187fb6beded979f4ad2c', '[\"*\"]', '2026-01-19 21:43:50', NULL, '2026-01-19 21:27:16', '2026-01-19 21:43:50'),
(204, 'App\\Models\\User', 32, 'auth_token', 'ec68d8844bbfd7143d071a25709851507d4b05d5f3e2ad44050c86ce8fd867c9', '[\"*\"]', '2026-01-19 21:44:20', NULL, '2026-01-19 21:44:16', '2026-01-19 21:44:20'),
(205, 'App\\Models\\User', 32, 'auth_token', '66ef746997ca754c7f18043f6e3a3a71be3c45eb6bf451e6c8f435028a01cc76', '[\"*\"]', '2026-01-19 21:44:42', NULL, '2026-01-19 21:44:30', '2026-01-19 21:44:42'),
(206, 'App\\Models\\User', 1, 'auth_token', '19a79298c26c2a2e1d40498f30fda848565863fa000862d1ba139c26a36b8bef', '[\"*\"]', '2026-01-19 21:44:58', NULL, '2026-01-19 21:44:51', '2026-01-19 21:44:58'),
(207, 'App\\Models\\User', 32, 'auth_token', '020825cff09726559cd7c953abbffcf246188c32d0c76851c2d969d893777c4d', '[\"*\"]', '2026-01-19 21:45:35', NULL, '2026-01-19 21:45:10', '2026-01-19 21:45:35'),
(208, 'App\\Models\\User', 32, 'auth_token', '30bec523ecfe513d58b8530355372729b0b05c4faebe65f09037611cc058574d', '[\"*\"]', '2026-01-19 21:46:17', NULL, '2026-01-19 21:45:38', '2026-01-19 21:46:17'),
(209, 'App\\Models\\User', 32, 'auth_token', 'fb7736b101d032364bd2d9ce623905df5bf076568cb03dd7dc7824bb2f0e2ded', '[\"*\"]', '2026-01-19 22:38:14', NULL, '2026-01-19 22:27:48', '2026-01-19 22:38:14'),
(210, 'App\\Models\\User', 33, 'auth_token', '779ef80bbc2102f05d9bb1e97caf64427e49389efc2145eab8ebd583df4adf5b', '[\"*\"]', '2026-01-20 10:37:00', '2026-01-23 10:30:57', '2026-01-20 10:30:57', '2026-01-20 10:37:00'),
(211, 'App\\Models\\User', 33, 'auth_token', '2bc94bded1f56345cd21443a07e70719ac9046370b83f67a9c7ce4887736770d', '[\"*\"]', '2026-01-21 00:18:52', '2026-01-24 00:18:23', '2026-01-21 00:18:23', '2026-01-21 00:18:52'),
(212, 'App\\Models\\User', 33, 'auth_token', '822ad7046dcecd9fbfa177807696ed137f7d385a477e17e564fd544ec8ad1484', '[\"*\"]', '2026-01-21 00:34:38', '2026-01-24 00:34:35', '2026-01-21 00:34:35', '2026-01-21 00:34:38'),
(213, 'App\\Models\\User', 33, 'auth_token', 'b67672f6a99a9659ea587a6f7f179feb8a9e2b9e5807c1c9a820f25dbc0066aa', '[\"*\"]', '2026-01-21 01:03:16', '2026-01-24 00:36:46', '2026-01-21 00:36:46', '2026-01-21 01:03:16'),
(214, 'App\\Models\\User', 32, 'auth_token', '1a78a49deea853846da9c7b8a911c79d16feec4419722fb3c7b910a76eadfec0', '[\"*\"]', '2026-01-21 01:11:54', NULL, '2026-01-21 00:48:49', '2026-01-21 01:11:54'),
(215, 'App\\Models\\User', 32, 'auth_token', '92158fc53e783089c7fa952aca88ea7e16fec2e0d0cd00527956fc9d106211c3', '[\"*\"]', '2026-01-21 01:40:08', NULL, '2026-01-21 01:39:06', '2026-01-21 01:40:08'),
(216, 'App\\Models\\User', 35, 'auth_token', 'ea694109e355fb64cf332715b4c0efa29c1efb4739ccee170a1571cacdd64301', '[\"*\"]', '2026-01-21 01:43:25', '2026-01-24 01:43:24', '2026-01-21 01:43:24', '2026-01-21 01:43:25'),
(217, 'App\\Models\\User', 35, 'auth_token', 'a71d8c53512f745d332a4c2c8abb8fdad1f545caf9097106067ac1cc4f535973', '[\"*\"]', '2026-01-21 04:12:16', '2026-01-24 02:12:30', '2026-01-21 02:12:30', '2026-01-21 04:12:16'),
(218, 'App\\Models\\User', 34, 'auth_token', '9a5b046fc4741e27dde935cbb2c22d4472be2e344cffcac173ff750502366374', '[\"*\"]', '2026-01-21 03:13:15', '2026-01-24 03:13:14', '2026-01-21 03:13:14', '2026-01-21 03:13:15'),
(219, 'App\\Models\\User', 34, 'auth_token', '87b2882de30de16ad83227965faabc3f59fdf82df299a04573f39fe45aee2d45', '[\"*\"]', '2026-01-21 03:14:17', '2026-01-24 03:14:17', '2026-01-21 03:14:17', '2026-01-21 03:14:17'),
(220, 'App\\Models\\User', 34, 'auth_token', 'dcaa25d35eb9e4a1f0e7d7593c068ad9fe81e3435b15fd8c6ff7b0c243678785', '[\"*\"]', '2026-01-21 03:15:40', '2026-01-24 03:15:06', '2026-01-21 03:15:06', '2026-01-21 03:15:40'),
(221, 'App\\Models\\User', 34, 'auth_token', '192793448e3c382a7b86ca8bc3a5214c5ec73dcd0f7260e4dae4d79c5ca0d111', '[\"*\"]', '2026-01-21 03:18:05', '2026-01-24 03:17:58', '2026-01-21 03:17:58', '2026-01-21 03:18:05'),
(222, 'App\\Models\\User', 34, 'auth_token', '1bb4a806eddeecedcac0b8b2bcb37628744b96499d4ddc1b64c666c43d8d24bc', '[\"*\"]', '2026-01-21 03:34:20', '2026-01-24 03:20:50', '2026-01-21 03:20:50', '2026-01-21 03:34:20'),
(223, 'App\\Models\\User', 35, 'auth_token', 'ecc950abb6fc61c662f81052272f278b513bdc04f08fc22c59495ce9df8ae9aa', '[\"*\"]', '2026-01-21 09:42:25', '2026-01-24 09:42:25', '2026-01-21 09:42:25', '2026-01-21 09:42:25'),
(224, 'App\\Models\\User', 1, 'auth_token', '54e86882f74d17f84da335d945b7d38ea6375c27425151147471a2c0925df426', '[\"*\"]', '2026-01-21 23:43:39', NULL, '2026-01-21 22:50:38', '2026-01-21 23:43:39'),
(225, 'App\\Models\\User', 1, 'auth_token', '7733e7683019e553c81ce3f50af253dade8d22d62823e555b2b22002c22bbf96', '[\"*\"]', '2026-01-26 22:47:55', NULL, '2026-01-26 22:46:34', '2026-01-26 22:47:55'),
(226, 'App\\Models\\User', 1, 'auth_token', '968f8b5af59167faa98b49bd64bcb2dde9930078a1c4df849be47fb2f861df35', '[\"*\"]', '2026-01-27 01:36:56', NULL, '2026-01-27 01:36:20', '2026-01-27 01:36:56'),
(227, 'App\\Models\\User', 1, 'auth_token', 'ef7d397513be93a8967bbdf5d5cc584a2453eb685e3416186ab692fd4c1fd408', '[\"*\"]', '2026-02-01 03:54:43', NULL, '2026-02-01 03:54:41', '2026-02-01 03:54:43'),
(228, 'App\\Models\\User', 32, 'auth_token', '0a3d363cd26b4edf4da0d25f2a7644dd3e9f0d755c5c7f85a3648b1c0a537d10', '[\"*\"]', '2026-02-08 02:11:43', NULL, '2026-02-08 02:10:42', '2026-02-08 02:11:43'),
(229, 'App\\Models\\User', 37, 'auth_token', 'fac4145c7a973ba1d0cf41c7519097c95a1b187dadedef99a0cd91164313f4e7', '[\"*\"]', '2026-02-08 02:49:05', '2026-02-11 02:14:35', '2026-02-08 02:14:35', '2026-02-08 02:49:05'),
(230, 'App\\Models\\User', 1, 'auth_token', '6230dd58f410a884ca3d1344e86ba375542a08c61247b677aad4ab273c2b4a84', '[\"*\"]', '2026-02-10 07:16:21', NULL, '2026-02-10 07:15:53', '2026-02-10 07:16:21'),
(231, 'App\\Models\\User', 38, 'auth_token', '565bc0131e661f207f702317cfe515e524d798f79662c59aeaf872632800087e', '[\"*\"]', '2026-02-10 15:05:34', '2026-02-13 11:50:45', '2026-02-10 11:50:45', '2026-02-10 15:05:34'),
(232, 'App\\Models\\User', 1, 'auth_token', 'de346c907a918d2b70d53d352d0413ede2749b66d1c61fb0057d866cbf8f03ee', '[\"*\"]', '2026-02-12 21:15:10', NULL, '2026-02-12 21:15:09', '2026-02-12 21:15:10'),
(233, 'App\\Models\\User', 1, 'auth_token', 'e4abef067a3c9b2b5f9d14d9cd664c2378bdd5a2d9cefcf7d1d4be4ad87fcb46', '[\"*\"]', '2026-02-13 11:55:13', NULL, '2026-02-13 11:55:08', '2026-02-13 11:55:13'),
(234, 'App\\Models\\User', 1, 'auth_token', 'f4a8b8ef67c8c1b9ba8506f72b4523ed620ff003ff55bac47326d87db7134d60', '[\"*\"]', '2026-02-14 11:41:08', NULL, '2026-02-14 11:41:03', '2026-02-14 11:41:08'),
(235, 'App\\Models\\User', 1, 'auth_token', '9a103fb6092602fe23a45279b42037c46f331c0dc629e2bde57c3283f91f2848', '[\"*\"]', '2026-02-17 02:53:24', NULL, '2026-02-17 02:43:00', '2026-02-17 02:53:24'),
(236, 'App\\Models\\User', 39, 'auth_token', 'f328d59c910b384ea2e8ad22d65f67753fa42cb53613fd86dabb569e5e5d5156', '[\"*\"]', '2026-02-17 02:45:45', '2026-02-20 02:45:37', '2026-02-17 02:45:37', '2026-02-17 02:45:45'),
(237, 'App\\Models\\User', 32, 'auth_token', '60e3da47f21305d8d22d8113bde2a4419e10c70b7328f7d76836bfbbf7bbc4ca', '[\"*\"]', '2026-02-18 21:16:18', NULL, '2026-02-18 21:14:07', '2026-02-18 21:16:18'),
(238, 'App\\Models\\User', 1, 'auth_token', 'a783f07d52de574993128d62d6dcb5eedf3d62c64b9f9572665e53ea3768f7b4', '[\"*\"]', '2026-02-18 22:15:52', NULL, '2026-02-18 22:08:38', '2026-02-18 22:15:52'),
(239, 'App\\Models\\User', 32, 'auth_token', '4f08e5e95523ba5e6701707343b30f25f3da64738cf31e708e65724b46d06fc4', '[\"*\"]', NULL, NULL, '2026-02-18 22:13:17', '2026-02-18 22:13:17'),
(240, 'App\\Models\\User', 32, 'auth_token', '7a40011168dde5545b4fc542fa085fc8798dd7c5b2bc7580328f7918956c6a6f', '[\"*\"]', NULL, NULL, '2026-02-18 22:16:11', '2026-02-18 22:16:11'),
(241, 'App\\Models\\User', 1, 'auth_token', '909469c5751e6cede90aac4be617b879e0c59eb676e6d677163498ff7d226d79', '[\"*\"]', '2026-02-19 00:45:36', NULL, '2026-02-19 00:45:17', '2026-02-19 00:45:36'),
(242, 'App\\Models\\User', 1, 'auth_token', '4db81cabe9ab14112dc2d8ddd76121ebdee4bfda94a7d6c284751ec8fa2d85ca', '[\"*\"]', '2026-02-20 20:38:25', NULL, '2026-02-20 20:38:06', '2026-02-20 20:38:25'),
(243, 'App\\Models\\User', 1, 'auth_token', '519fa283fbce4ba52c0eddac5db19b5fe516ed93b70c2598fea9fe884be11876', '[\"*\"]', '2026-02-21 14:26:40', NULL, '2026-02-21 14:26:25', '2026-02-21 14:26:40'),
(244, 'App\\Models\\User', 1, 'auth_token', 'b7d7f89df97f3dbd844356f84ec3b5cfa2e8782757ff35f7cedc6497f86e19fd', '[\"*\"]', '2026-02-21 14:53:57', NULL, '2026-02-21 14:53:40', '2026-02-21 14:53:57'),
(245, 'App\\Models\\User', 1, 'auth_token', 'b0c676133e7be237f607d8ccfaa47e03152e75683bb6f1ed2df78883b4593a0e', '[\"*\"]', '2026-02-21 14:57:58', NULL, '2026-02-21 14:53:48', '2026-02-21 14:57:58'),
(246, 'App\\Models\\User', 1, 'auth_token', '23ee5b377da5241477bc18cac0f05df822dfec051cb7d7a5c21d9520dae19d35', '[\"*\"]', '2026-02-21 14:59:08', NULL, '2026-02-21 14:58:46', '2026-02-21 14:59:08'),
(247, 'App\\Models\\User', 1, 'auth_token', 'fe489d92bc2c175f4d6330ea4195d4d5cd85d3ff58a5a65a6e76a0fe00f7566c', '[\"*\"]', '2026-02-21 15:23:20', NULL, '2026-02-21 14:58:50', '2026-02-21 15:23:20'),
(248, 'App\\Models\\User', 1, 'auth_token', '1124387c42100549e8d8664929f5502bf60358b3f9c50d69460d5a62a56e85b3', '[\"*\"]', '2026-02-21 15:15:41', NULL, '2026-02-21 15:13:50', '2026-02-21 15:15:41'),
(249, 'App\\Models\\User', 1, 'auth_token', '4d37ea538eacf4f2cb18604cc107ad4b174bfe6a5b1ea92bbfb9f7860ca99dcc', '[\"*\"]', '2026-02-21 15:26:57', NULL, '2026-02-21 15:26:50', '2026-02-21 15:26:57');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(250, 'App\\Models\\User', 1, 'auth_token', '3692300c7c572712e8d520e99a0230a4806ff88d89d0da760c03d6d74f0279fa', '[\"*\"]', '2026-02-21 15:27:50', NULL, '2026-02-21 15:26:54', '2026-02-21 15:27:50'),
(251, 'App\\Models\\User', 1, 'auth_token', 'a1c2283b14aa7e2264cb5ef6c279b3e9a786647589b12b2b77735fa8828a32fb', '[\"*\"]', '2026-02-21 23:46:58', NULL, '2026-02-21 23:46:35', '2026-02-21 23:46:58');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'superadmin', NULL, '2025-11-07 11:28:55', '2025-11-07 11:28:55'),
(2, 'admin', NULL, '2025-11-07 11:28:55', '2025-11-07 11:28:55'),
(3, 'user', NULL, '2025-11-07 11:28:55', '2025-11-07 11:28:55');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('1mozzQoJPYLiuLO6CzSWw6mbbTB4MLCBj0ReoSMn', NULL, '147.185.133.9', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU0JWN2ZzOXJQSWlSdmxYZ3VKcGowb1prNkVBbjZJMkV3b1Q2Q3FyUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vNzYuMTMuMTg5LjExMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771634571),
('1p66cCGj3YkGEfaDKXCD15Nq8nbs4yV0U6p67fOI', NULL, '167.94.138.122', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaFlaMlRkTjM4ZVBhakIzQzNkckxDbnJZWTVXdVhOUzBRU2JVd0VQRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vNzYuMTMuMTg5LjExMS9zaXRlbWFwLnhtbCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771625014),
('2iClJP9j2aUids9h3iXCrRvqdhLQrds4r1wG7KNL', NULL, '103.204.211.24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ21vcXhYaENyZGlTQ2NPckp3RmFPclVUWUVGdzI4WFVQalFzVUdUTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDg6Imh0dHBzOi8vd3d3LnRydXN0Zm9saW9iZC54eXovZGFzaGJvYXJkL2lwLWFjY2VzcyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771478130),
('3empcJBdQOAawIIFIAirU5w0YYbJYVIW7r5cgic5', NULL, '172.70.240.7', 'http://trustfoliobd.xyz/wordpress/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiME5BRE9qTjF5dlRhVDJYeDI2STNuMjZZVHVLQ2dHOW1SdlRHRW9VUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTk6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3dvcmRwcmVzcy93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771199766),
('3tDJtqUBMrGbt6QpyYxJncjXHIjfn8qUW4W6kpW2', NULL, '45.251.228.224', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Safari/605.1.15', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV2ZPNVBIeDdocU95STk5OWdyR1B6RmVVVXMzTmR4b2FQUXJXNjRKdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771483514),
('4l1HnD7Vd2C5FYjMxR0pTRJADRQz8G30UOVQ4gbF', NULL, '45.251.228.224', 'com.apple.WebKit.Networking/21623.1.14.11.9 Network/5569.60.39.0.3 macOS/26.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY3ZTcVQ3SmZTNEJidDZ6Y1ZoMmhXc0s5eVZMMWFsZjh1SmhGeHpkdyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei9hcHBsZS10b3VjaC1pY29uLnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771483515),
('6Tfcii0IVR29Jvjpml4Bby8kPBqtxlZZqbQpI8Ce', NULL, '167.94.138.114', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU3IzUUtiSmsweG9QaXFHMXl3Wmx6WHlTWXl5UlA4VXl3ZVB6RWVqZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHBzOi8vNzYuMTMuMTg5LjExMS9lNjE3eGM0N3h6MzFnIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771714879),
('76XXIWRcfgQ8neufBuRfN7N5AWODurmCJRFmH1HL', NULL, '104.168.71.191', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/143.0.7499.151 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSzFITHBhYVhINEZuSW0xbkN3czBmTjIyVEcwODdha0E0djJiUWF3YyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vb3BzLmNvbm5lY3RlZGVkdWNhdGlvbi5jb20iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771695323),
('7fHgS0i9PFctT4PdCPBRB4NITpc04LVMx4KWlbcV', NULL, '106.117.110.125', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWXRIVXhscEkweVRKekpreXB5RWdraENzNHFlRVhDTE9yS1A1UHVrUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771440496),
('7t26Hnaw4wuNoI6pA2XjgOTeIuvt0BPZFtM4FhKa', NULL, '162.142.125.45', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibmFqMG1tVnVqOGx1T0I1cjhvMVBUVnBBNENYU1FOTVhmOE9jME14UCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vNzYuMTMuMTg5LjExMS9xYjhjb3k2Yl9sIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771700128),
('akWVw1iWQk8yKpWKSPz5nYG8Ygm1AqEqdSoaYNjZ', NULL, '2a06:98c0:3600::103', 'http://trustfoliobd.xyz/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVVRyaGxueUd2cnZsZFI2VHJhNDBIN0N4bmUwRERXdmdmZ0F1bnJNSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3dwLWFkbWluL3NldHVwLWNvbmZpZy5waHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771468639),
('ApyRq8jDZ4MGypGcN3ZTvSwXqgvvTl8DHUkRJSlC', NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN1BkWTVSeGJFTmdlbG1Ea0UzQWZoMVE5ZHFCVzFyendLTU4zOVNjUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771268061),
('Aw08OErPXDqCOJe7Rdk0dH2gDwRxOxE9Tpvp9cyJ', NULL, '205.210.31.53', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibTUzNXJVcUFsSWhzcmszRU5NU0xwSk11VmN6cDRKR3JHbEpzbk45QiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5eiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771400283),
('AZpflxWtgnEi2r0ClrRbQ0FI110MsnehhTrqaU7J', NULL, '167.94.138.122', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUWpPc0l2VDJnS3ZEV3dpZXpYSWdjWmgyZGVBUGg4c1lWTkRtV29ZdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vNzYuMTMuMTg5LjExMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771624797),
('BbFmcwNh2AifI0fAefeXxoXJJ6GC8u05GAozg6As', NULL, '106.75.164.76', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaFlLa1N6YUI5dWl6OFAzZWFiSmkzNXdObFNoWDlGaHFZalQ3NjAzayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3NpZ25pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771460145),
('BeGnWBmNM8f9HEm3l2tJJH4zhcfTlDvYbqIb30xX', NULL, '86.50.94.29', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV1p1T1E0ZVFLYmZKMWRDZTl1RXpLN2Y0bWRnN1NUbXBseWtmeTNpWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTY6Imh0dHBzOi8vYXBwLmNvbm5lY3RlZGVkdWNhdGlvbi5jb20vZGFzaGJvYXJkL2FkbWluLXVzZXJzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771619852),
('bLqfHzSndg1C2NMaHgx4eeJM2RFPgcrwNHXTEje3', NULL, '42.240.130.92', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVXMzQkxpRXVJSzgwcnFHb1ViamlZcE8yakRQb1ZDclVjSFo1ZXlLbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5eiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771460145),
('BNxg9d7JK9OfyxaXQ04e02hZkOU5HjwNPAigqcg6', NULL, '185.157.91.227', 'Mozilla/5.0 (Linux; Android 14; SM-S901B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.6099.280 Mobile Safari/537.36 OPR/80.4.4244.7786', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTUQzQXlIclVBT0FFYlhCMWJRWnY1M2h0a2xIdmQ0cThqeVFnaVg3eSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771160566),
('BXqcxdmkZzvRcZlrVT6bRhTzjmRJeWyEeanp3tj1', NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidkVpTVZVQUJGYlVUa0NBYzlMUndUWDhTYTdacTl3VllVam1IQmhXSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTk6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3dvcmRwcmVzcy93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771468629),
('BxrbQoSwLwQa3RYGXVoesAQgHSCQodVrcsZESrTi', NULL, '104.23.221.26', 'http://trustfoliobd.xyz/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicVM2Y0xnMXNxcVFFZEtKODZqSWVNOVFRQW8zN2dtME1IWnpCdXpVZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3dwLWFkbWluL3NldHVwLWNvbmZpZy5waHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771178371),
('c1OwTy0smX4guoK9wOYN65LJBTp3Hb3z0B5AIqRl', NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMjNSOWwwVktFd2E0MXFhWHRVZUw1a2NSWmJ0UEl1aGUzZllsUjFSYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei93b3JkcHJlc3Mvd3AtYWRtaW4vc2V0dXAtY29uZmlnLnBocCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771406633),
('cNrWSW3qBajIJc9tH0mD5m3fZ1JqiSL2nloJvDrx', NULL, '172.68.10.191', 'https://trustfoliobd.xyz/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM3FSZ1NIdWdKZWlZaHpJTXk3Y1ZQMG5lUnNQVzRvaGVvdHlTa1NqTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771385847),
('coH9lvT6kYtXVHY6mB0C4Mqbb6QS9VTLQZQDVgmj', NULL, '116.206.253.173', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOW9peHNsUTdlQ3hxWlBVQXlmMWZtNTBiQmpnelpCNXZqVmJwNnBkUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771158393),
('cqyjThmbMDW620uLg3X7OZ0ryat5mcZEN4Z66tIe', NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY0lIUXBkdFd1aHp1OFVzcUtrcEpZYmt0OERuM2NqcVk0bUZkcUViaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3dwLWFkbWluL3NldHVwLWNvbmZpZy5waHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771321855),
('CSniP9E8uNvKo7perLYnUHOu1aHQiW01yQ5uAfTN', NULL, '106.117.110.125', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYzBMbTlwYURLRlhycXpBRFI5MFVyYVJwUTlDUEYza2t3MlZnbnlNYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771440499),
('DmSBfy2g1leKPzf9ux4rmWesq1emILHdbrnp03SE', NULL, '34.1.31.56', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko; compatible; BW/1.3; rb.gy/qyzae5) Chrome/124.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidjBtdGc0b3JDMlNwSFB6dkRLTmY2SEg5RDNqdmJsQmNjZnZITTBjaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei9sbG1zLnR4dCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771300115),
('dpHyTzPXmGiXZTSynsvdYkc9uCupzeiM1yTAVRCC', NULL, '103.178.220.33', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZDRJSWlZbXRHZ1pKaGJkNmNuQVNVUWZSbHMzU1NPU0tLNjN5dWMzNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjI6Imh0dHBzOi8vYXBwLmNvbm5lY3RlZGVkdWNhdGlvbi5jb20vZGFzaGJvYXJkL2FkbWluLWFsbG93ZWQtaXBzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771686934),
('EdwMUY9xJvbLcKCvdPVdzY2buMLOxHYKZE6G1FxG', NULL, '103.178.220.33', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicTFOaGc2bktoek00RGNReVhHN2FNb3ZvelhLa2kweDUyWkZlOTNVVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vYXBwLmNvbm5lY3RlZGVkdWNhdGlvbi5jb20iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771687468),
('EOQddlRZIREAwA2lv3PK2Wrvk67feU8lkeMSsVid', NULL, '34.1.31.56', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko; compatible; BW/1.3; rb.gy/qyzae5) Chrome/124.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibFRSQ0F4SnlIVzB6eFljNGxBd0drUDBqQXlDa1BaMHliZHlab2RTbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3NpZ25pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771300100),
('f8tj8R53ftdA91ztdlKiUhB9tOflTfs0fNZmIlqd', NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidGFVa1l2dkRqQUdOWDVadXRZWVpYenFGdW8zN1ZycUx0SUNHTnlLWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771406623),
('f8xdOSANtD1XdKJpnLNVwtM8Q1QHd7fYUjXXi6Js', NULL, '192.71.25.214', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_1_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1.2 Mobile/15E148 Safari/604', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRVJVZmVOdFZHMVA0eGg2djlUZVNsNzdVNUc2WWVHN3N3UUpmMkZyWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3NpZ25pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771330844),
('FbZh4X9jLTr6LsSMyCQtRWDlWfPYqEeXPD7fTalv', NULL, '13.126.192.80', 'Go-http-client/1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYU9oa1FnaFl2dnprVEw2WDlkNEpFUWdxMnRmUmZCS0ZzNENvSno3aCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vNzYuMTMuMTg5LjExMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771678605),
('fda5KurdSpi6Ez0MPQIa3rSLVcZDQpe8NpwyEeHc', NULL, '101.91.110.131', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUzhwUDRnblh5Q2hJSnJmSldGZGJMeEdtcDVjRm05Y1B6S1Z3S2IxNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly93d3cudHJ1c3Rmb2xpb2JkLnh5eiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771461186),
('FMc1BjWk2LvAwRLeDLbuo9tieqVE3D1gNUFrN7aB', NULL, '13.126.192.80', 'Go-http-client/1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV0NZSXdWc2xjTmo2Tk9CWXZhdHp5RjNIUmNaZGRXemNRaWQzbnp0RiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vNzYuMTMuMTg5LjExMS9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771678608),
('FNQR118zTnkNyPowP2gHAmRMHNdgiyw8GYcovTID', NULL, '45.251.228.224', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY3EyWHdvVEhMbmpwbThPbTVMQ0RvdUduR2pleHVaNW9udVNiZ3BtdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3NpZ25pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771470843),
('G3M5Or8sN8w82VCGtJ5OQLUBSEZX8JM58fbnUEEY', NULL, '2a06:98c0:3600::103', 'http://trustfoliobd.xyz/wordpress/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUXcwSldINlNBak1rMmYyUmx0SE5jZDBkT3F4NlJGd2N6c1V6YmN5ZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTk6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3dvcmRwcmVzcy93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771406643),
('GBxk5OsEfS2wfF8RVYwqB4tKzzTIrz6kEyGZybme', NULL, '194.71.202.178', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:109.0) Gecko/20100101 Firefox/115', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWkpwM2xJSkNhSGRnWkpYNlhiUTNBZ3pSTHRualU4Rmh6N0NVN1hydyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771193610),
('GUNRA9wSIHwmN6SOSkzbA1cQhyZMVqZjKYEP8lWj', NULL, '217.21.79.39', 'Go-http-client/2.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiTmltWkE5ZnRGSzJwaWpKbjF4ZDYwUGs2Nmw4VmF2QlR3RE91QjVXMiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771654314),
('H7kDy6VoiMbRWHqNBdNvGl70F7WP1aajwnSgqiJq', NULL, '167.94.138.122', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ1FYSlhmV2haOEk0V1RpUmRxRlR6TzZvMThnVkVNclE0Tm90eEx6ZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDA6Imh0dHBzOi8vNzYuMTMuMTg5LjExMS91MHF2N3M2MDR1OWV1OWxsd3QiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771625030),
('H87X2EcggYfYuPZ67thxaH8uwcshf0rxsEJZVy7n', NULL, '2a06:98c0:3600::103', 'https://trustfoliobd.xyz/wordpress/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM2NLMVFFVkxHYnNtUFNlZ0lCajN1S3duVEFkaTc3V3l2ZXFVTkV0SyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei93b3JkcHJlc3Mvd3AtYWRtaW4vc2V0dXAtY29uZmlnLnBocCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771321682),
('H8EJrqfm8aX7aeQssOj2v5I9QEODDBM8TLLD3J69', NULL, '192.36.70.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.3', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZUFMTzhYMlc5ek9ZT0FwRHNoWXVNQThuOWdGRU9KTVptZ1pzV0NIeCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3NpZ25pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771363540),
('hamOB1kwBOzADonHKjdYS8nSMLcUX2Cb5OEaUxJx', NULL, '205.210.31.57', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRGM0OXBmZXNNNUUyRWNCWEpRYkFBanhhWEEzQnUwTzVyTGtYakR4bSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5eiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771334952),
('hlEuPdz3gn4zFTCoXK2gnvkMrEkqyBNpOSjpeKjD', NULL, '192.71.62.22', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:109.0) Gecko/20100101 Firefox/115', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibzVhb1RYMkZDSnByZWpiZHRKMVpiY0phdDJIelJtdXViQW56NndTZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3NpZ25pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771193610),
('HP9uDMjzITEcqhSYwXo9s3ihh0p92wHxRSFQ9ujE', NULL, '72.13.62.4', 'Mozilla/5.0 (compatible; ips-agent)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib0xsb0V6YTNTQ3BhZHlRWmZWNFEwaEZZbWRWa05JY2RiVnkxdUVHTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly93d3cudHJ1c3Rmb2xpb2JkLnh5ei9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771205717),
('hwyPfjhuPKsm9rjse5AnKAm3VdCI9GqQuv3wkq40', NULL, '34.1.31.56', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko; compatible; BW/1.3; rb.gy/qyzae5) Chrome/124.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieHlFYkNReGRqRDRGV0RwQTNnWk03cncxSU1nWkVYeFVmQ2k4bHJYeCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3NpZ25pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771299508),
('hypwh0Id1yy68hVqpXAeKKPYSt5JPpPPtK8OBXry', NULL, '104.23.223.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUjlLbldVOHRaNVFSWTI2cFcwMUtKMFRwWGVuOGFnVDNuMzVTa3VtNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei93b3JkcHJlc3Mvd3AtYWRtaW4vc2V0dXAtY29uZmlnLnBocCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771243103),
('IlN5VXhTxO7NG4EAR9zMCIMyni3EaCJWLPuR7cTc', NULL, '103.204.211.24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieFpBMld3R2tQd2d3d2JZWXh4NDhjd2JGMlFKRjVXSzhaVE5xZ0s0NCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTY6Imh0dHBzOi8vd3d3LnRydXN0Zm9saW9iZC54eXovZGFzaGJvYXJkL2FkbWluLWFsbG93ZWQtaXBzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771478189),
('IpkAylNKFoys5s0K9fCLvbdTclCcwuxaTCiDAGgT', NULL, '198.235.24.33', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUzU2WDZTakF6MFlBckR2elhIWDZnQWRGZ1NJSzhCU0U1QXBQM2Z3MyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei8vdHJ1c3Rmb2xpb2JkLnh5ei9zaWduaW4nIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771374110),
('IrKHHicaZogzsF21PQWVKttIcyUSEzjLdsVCYt4a', NULL, '45.251.228.224', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Safari', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTnk5bGE1TWlycTh2UXdINjA5ZXl2WVRRcFlabk9DQnV6bDQ4RDlMYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei9hcHBsZS10b3VjaC1pY29uLnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771483516),
('IyG0AoxBcOTEdQd1GoJMOISL1U0gpi9Mf0jPPkeb', NULL, '20.240.204.2', 'Python/3.11 aiohttp/3.8.4', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibGZGZ1Q1czJCT21aSjZNOU1EV2J1UVB0d2xydmNpamJVa0lOSndRRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vNzYuMTMuMTg5LjExMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771679040),
('j0O3Fita2LX6YKMHtVMtcS1W6zoG0fPHMVt4NvmZ', NULL, '147.185.132.37', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiekdzS3dzdGQxSEJVMWFNMTdhY2JucUszZDh2cGJwTk1WRloycTczVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei8vdHJ1c3Rmb2xpb2JkLnh5ei9zaWduaW4nIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771341081),
('jLmFiQ6DH8XumRVsWjjIdWqduFYcKUBjZ4DbcauW', NULL, '172.71.184.64', 'https://trustfoliobd.xyz/wordpress/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidk1EQlR4c0NsM3l6RUFKRko1d0loZ21GTXBWNTViY3dRWUt3dVFIdyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei93b3JkcHJlc3Mvd3AtYWRtaW4vc2V0dXAtY29uZmlnLnBocCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771385697),
('jlY5ROreqUdRAzVAecUwmb68C3go4SuuvbGze7BY', NULL, '205.210.31.53', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR2pzdWl2OGIySVVXQmFndjQ5dXlocFlhVFNRcDdQeGJUMU9UTWtYUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771400284),
('K3S2i8g4lbnou8gTpa35YhchDuP7z1Zquf01keG5', NULL, '86.50.94.29', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMHc5TXdQY3pGRjk4N2tEaFNnME1iZEdLUU8yem5QNmk4TXRjOVgyNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vYXBwLmNvbm5lY3RlZGVkdWNhdGlvbi5jb20iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771716121),
('K7zAYR80uwNotv7TZx4D5Wt7tDBZpB8YqUYeP4nX', NULL, '172.68.10.191', 'http://trustfoliobd.xyz/wordpress/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibEc2cVNNTkc4cHo1M0o4OXEzUkREVnBIMExVZUxPV05SSlloTjRIeCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTk6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3dvcmRwcmVzcy93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771385830),
('KG23V7ZxPYdOj5nbHWiTuN5w4iuMvf6CzpwqujGm', NULL, '2a06:98c0:3600::103', 'https://trustfoliobd.xyz/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN0NvbE5EZGxOUHppZkJkUU5sczJJVElBVkpBT2VTcWhac05ua3VXUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771468791),
('KHqkw8K4CyKL4iVZ806NaE2RfnKEt5dkIBXVESah', NULL, '13.221.176.159', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.7258.5 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiem8wN21KdGo0U3JjS2p3MXl1cWEwTEhLWXBadUxRRGQ1TDVLOVhIRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771212654),
('kIccfgBPf2gQZ8jBO7Ifbe5yFEAu7D4w5aDaqQXv', NULL, '2a06:98c0:3600::103', 'http://trustfoliobd.xyz/wordpress/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVGRaSEFSWEprQnlRRGJZZm5xSURnVzhOQzRZeXIxaGxtdmNEb1V2YyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTk6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3dvcmRwcmVzcy93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771267974),
('kjyAEZFibJQV7u6Oa5XzwQaNUy8AgszXkfLQvxmh', NULL, '101.91.110.153', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieUxjMldvOEpJSm5xMFViMkVKM1F4QURPb3o1RVp6QnZlUjNFVUhWOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vd3d3LnRydXN0Zm9saW9iZC54eXoiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771461183),
('KY657xGt2Er59TP8mvwBFoGD1CHpaecMPem0tQGk', NULL, '103.178.220.33', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUGlla2pOeW9Gb0Rsc3dXSXVRdGFhNUs2UUN0Y3lPaVFOSmp1Y01QVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjI6Imh0dHBzOi8vYXBwLmNvbm5lY3RlZGVkdWNhdGlvbi5jb20vZGFzaGJvYXJkL2FkbWluLWFsbG93ZWQtaXBzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771685876),
('kzh04qyogFDKaAxV0bDBbyeJPyVSjqm0HNdGKgxC', NULL, '193.203.166.193', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVjJnbklBVVNNRVplZFU0TmpSR1FvRUlHb0N5T1JDZGQ0ekRNNHFkWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Nzc6Imh0dHBzOi8vYXBwLmNvbm5lY3RlZGVkdWNhdGlvbi5jb20vLndlbGwta25vd24vaG9zdGluZ2VyLWNoYWxsZW5nZS9BclZCeFc1c0c0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771693611),
('L79SOEskouXyOykXbkTahG3a12ZzUC77qzfz4Rug', NULL, '104.23.221.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia015RW1oR05CZnY2Rmx5QnFZdHZ0QWZsd282eHZUSVR6amhsQ2dZciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTk6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3dvcmRwcmVzcy93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771178437),
('Lh6BkyD1DSRdGmpd3Ou6yGOYN0wyy32KK4uVAYyr', NULL, '167.94.138.114', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM2MzT1l1eTNSMWtRVFltRDNvSUhxUVpmRjRJMnBnZzF4N1EyaFFPZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vNzYuMTMuMTg5LjExMS93aWtpIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771714866),
('LUJOhe18OMskY5xXs0FOLFSBLEwDcriLOwCbOtBu', NULL, '188.241.249.212', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/143.0.7499.151 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYTNqMnN6NzU1YURQbFRJR1YxakMxRlhZZmd4dzhJT0dZS2t1bklNQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHBzOi8vb3BzLmNvbm5lY3RlZGVkdWNhdGlvbi5jb20vc2lnbmluIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771695327),
('lVZMoRP083AyhKIvKdaxwd2diJ2ImyHAvI94afp3', NULL, '86.50.94.29', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid3VXTE5hVmNtNXdITHZMWE9KNWRxblJyelA5UXJRaEVjVDVrYjN0cCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHBzOi8vYXBwLmNvbm5lY3RlZGVkdWNhdGlvbi5jb20vc2lnbmluIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771716134),
('MM38PqNU0JX0b5EbNf0aPc1pz43c31PdzmNWBt0M', NULL, '45.251.228.224', 'com.apple.WebKit.Networking/21623.1.14.11.9 Network/5569.60.39.0.3 macOS/26.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS0pkcTZaVFB6ZGw0NmtSYldJZ1RKbVZFSlRIQzJCdmp4ZVBtRlNrRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei9hcHBsZS10b3VjaC1pY29uLXByZWNvbXBvc2VkLnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771483515),
('MUbuP1bHUq1MIRYD193lhePwMqvAblzquss2S14q', NULL, '185.142.231.238', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_1_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1.2 Mobile/15E148 Safari/604', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieTgwWVlHcTFQaTFoWkg4V0c0UGwwMGxjWEJMUXZESGFjNW1lMnU3YyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771330843),
('n1itcq9ZfQH1hry9QTxMLWXntOqGHXU4nRztN5hL', NULL, '58.19.77.190', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVkpTWjBiVHJNb204UE9YT1dCc2Q4UUhlcHdWWE1yeUdjOE9acEFiQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5eiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771351470),
('nG486ZUCJWpP3qkszSLRMztI44qsxMqAWFEiM2m9', NULL, '103.204.211.24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidXNnYjRMUFp3VnVRT2d1TjVXMmFyc05rTHNSYVZkT3lyeHJqWDJLaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTY6Imh0dHBzOi8vd3d3LnRydXN0Zm9saW9iZC54eXovZGFzaGJvYXJkL2FkbWluLWFsbG93ZWQtaXBzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771474195),
('nk4YqAeSOQtOxkHAYp5IVzAUYbSwYYy9M3azd1le', NULL, '34.207.99.114', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.7258.5 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSVhKQjRLa05tYlhiTDBIOXNMQ1c2V3pYR1I4Q3Z0ZHlTZlVleHlmOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHBzOi8vd3d3LnRydXN0Zm9saW9iZC54eXovc2lnbmluIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771212638),
('NOQ8fCwNpxlpiuF5JLIcaYNy07g6GXkNRg5DZBfb', NULL, '35.203.211.87', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOFBXbmlnanVVNU04eFhCbHpjVlA4d1RGNk95dDFMZ0RRbzM4RDdHOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vNzYuMTMuMTg5LjExMS9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771702935),
('O1a2J3LyEAT2ZLHfxAOib7lttnr6ObHsjKAkI3aw', NULL, '172.68.10.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQk5nTzJFV1JHOTlTVlc3V1FTS3VZeXNIalc0NTFDQmlZRXJqTzZscyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3dwLWFkbWluL3NldHVwLWNvbmZpZy5waHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771199516),
('p6y9KXVv6ri9yLPbwtLO8Vc0mXzifdKd5AwtW22y', NULL, '20.240.204.2', 'Python/3.11 aiohttp/3.8.4', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicWtIVTI1M0o0V3ZnNnk3V0p1bDJUT1hIaWs5eVhzVUdvY1RlV1YwSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vNzYuMTMuMTg5LjExMS9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771679044),
('P7xHpcWmS3yikbnZLNLKGVPOXuEJlm5lim4oj3R6', NULL, '104.23.223.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoick92a2M3dWRPMmRUdjREaU84b0c1MW1zWXVxS054V0dpM1lraWpwVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771243054),
('pwpNU9hoBEaK09IGMNpRVDze5jD7Gh3s7yrS3rSs', NULL, '174.138.58.252', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWlVjRDV1ekx5Y0t0Z0RhTGVsV25jSVNIVlQ5RHQ3NzN1U1VFeWVOdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3NpZ25pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771228860),
('Q0gRyhDj9vjSXiWdqc0NduU4PPFsnq1idj7jcqQq', NULL, '42.240.130.22', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM2ZXeklvMjExMTZFZlZ5WXFmb05mcjZNbzZkeDJ0cXJoUDBPTDh4WSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHBzOi8vd3d3LnRydXN0Zm9saW9iZC54eXovc2lnbmluIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771460132),
('QY6vO9SACVRH3rSq4U8rPirQHNdYRJX9VFPfTPMa', NULL, '217.21.79.39', 'Go-http-client/2.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiTW96c040eklveU5Db2xCMkVaR2RSS2Q1djhzOGJJajZickJHandtQiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771654319),
('R7NEvodzVcdH0iAUakIlgh0sZaDUYYmI7P0FYi2F', NULL, '172.68.10.59', 'https://trustfoliobd.xyz/wordpress/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidmx6aWlyaDhkMmNYNFcxVXgwNkxqSlVNdXY2am9CakpUOUNVdG9uMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei93b3JkcHJlc3Mvd3AtYWRtaW4vc2V0dXAtY29uZmlnLnBocCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771199621),
('Rf3tSp2pvd3AMOg85t3EK81gwx438JQ9VFOKxoEi', NULL, '172.71.184.65', 'http://trustfoliobd.xyz/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUFIwbk5SVnRSTDJEeVJ3RVBLcUJlWldhMmFuejUzNDVLbHNGU1g3eCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3dwLWFkbWluL3NldHVwLWNvbmZpZy5waHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771385834),
('RjABzxjAZv8V6I4QB9CzON8REuuET3yniXKal2t2', NULL, '103.204.211.24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN2hsbXgyZjJ3OUtLbXhMNFB4ZndRalk2dGw4b0VlcXRQMEJaNkdqWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vd3d3LnRydXN0Zm9saW9iZC54eXovY2hvb3NlLWRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771478550),
('RJrOvLdUrZjbtWWVlGUNtGKjSGg3jl9M3WETMEnG', NULL, '167.94.138.114', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR2djcnBKVWUwNGJoTlVjQzRWZlVBbGd6TExOU0lENm9vS3dLclRrViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vNzYuMTMuMTg5LjExMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771714673),
('Rsi4MvzpFIyZ4GbsvocPnFFvIl1BbGfLSTSiNwv0', NULL, '103.178.220.33', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicklsdU9TUmpXTjMyY3Bic0ozTW1zOFN3SWRMZ0tyM0NPNnJMZ0o1NSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjI6Imh0dHBzOi8vYXBwLmNvbm5lY3RlZGVkdWNhdGlvbi5jb20vZGFzaGJvYXJkL2FkbWluLWFsbG93ZWQtaXBzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771691717),
('RssROhaIQarp0OoUWwYAEPWjAHRklBG9mcHZytPz', NULL, '34.1.31.56', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko; compatible; BW/1.3; rb.gy/qyzae5) Chrome/124.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid2hFSjVrcnFzTHFVZ1hqVzB1VHFyeHNCbjFZU0FHdFdPaERyZkFVaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei9sbG1zLnR4dCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771299521),
('SABxkLAfcKRxDguUDZC707M0MkVhLWUPtDTzUNf6', NULL, '42.240.130.22', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS0xqaHdjYWNJcm9BSlBUUkFwRG1MSms4aGF5ZTBXd1B1NFo0WGVrNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vd3d3LnRydXN0Zm9saW9iZC54eXoiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771460130),
('SmL847sr8eP9eAh2lfBUo6VwzEW4xJip7AVBkVVz', NULL, '192.121.184.87', 'Mozilla/5.0 (Linux; Android 14; SM-S901B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.6099.280 Mobile Safari/537.36 OPR/80.4.4244.7786', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRm1WTTVySU5Yd1pzNWZCUHJSdW9xOUVpeXY2MDhIMHhROWREdXpLbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3NpZ25pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771160567),
('swaMoVImlhzQ2rqNDzKLy630XhcoEkYygwkKZuTq', NULL, '172.71.184.212', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibnNkVmVXR29zNXRKTUhVb2NDNm5zZVFsalRNV1ZXV0R5MFVwWTVzViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771199550),
('SzJBN4YU0ZbhUtlwKMIFAPMa1sAgRTiapzSgAGRH', NULL, '174.138.58.252', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS1FXYWlJcElJdWJQcHlKdE16bnY0SHFuQUJld3FSMnpRcEFPSUg5ayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771228870),
('sZXevMPK7bw9V12VKeXPeRs5hjdGhjYeGBzwP1Kx', NULL, '162.158.87.18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRTJKVWI3cmI1Q0RsVEhlUk1QMW1rT0hUWExEQkp4M0hjd3c4aFYyeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3dwLWFkbWluL3NldHVwLWNvbmZpZy5waHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771243132),
('T40ujtsMiIpTclNDcebkovB7SGiOfBEInr9GID0W', NULL, '2a06:98c0:3600::103', 'http://trustfoliobd.xyz/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQXZyNWIzbTEyeVdkRURVWjM2bVMyWXJQNmY2R1Rwd0JLbnZTMUxIMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3dwLWFkbWluL3NldHVwLWNvbmZpZy5waHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771268127),
('T7iClRjczmXfN5Devq7009DpsueRs8vpIMgsZbdw', NULL, '167.94.138.122', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUmhyTXFtUXZ2dmlyNFNSWlhwWkZDalZ6V3hZMDFQZnRNQjVWQ0dvMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vNzYuMTMuMTg5LjExMS9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771624817),
('TbfbDWEQDmR0JlazSGwe0ZCHzYCSwJXKhGKUx4wJ', NULL, '42.240.130.92', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaTZHVFU0NFI3VkFyd1dDb21ieW9VaDB3S1JZek5Yd2tPbzZTS1oyUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771460147),
('TdfrXY6yA2fKLKjCV0PJbF1nzAEyazgsAlly9yWw', NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib0szN09YaGpucVFLOTNhTlRCZjUxcHdEVkdxa1pSNkpPVVRRak1KOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771321752),
('tsgbHr0OY1NhomM156ka02sHTMpkKOCIVwuUlv82', NULL, '2a06:98c0:3600::103', 'https://trustfoliobd.xyz/wordpress/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRzZoZWJBbzFlWlpCV2Fvb0RDWmdKTHlqRGRNREZvd2lDMjFUQjFSYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei93b3JkcHJlc3Mvd3AtYWRtaW4vc2V0dXAtY29uZmlnLnBocCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771468863),
('twZKwBhVjp4AL9PdkRvj6LHRcncCTbsITHALdvpf', NULL, '42.240.130.92', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOG94N3ZKZHFsaVU3eGFNWHgwdG1hSnhiNm5BT0tuZkFTYVQwMVh2dCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly93d3cudHJ1c3Rmb2xpb2JkLnh5ei9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771460129),
('u5Ju7WKLHrBLLYZhJ1xgG0Tz9is26P8Vbvdd5Omh', NULL, '116.206.253.173', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNWxkM25RcWNoMlhsNmQwejNzd1BycUhBNzVqVDUwY3cxa2lvMDYzbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHBzOi8vd3d3LnRydXN0Zm9saW9iZC54eXovc2lnbmluIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771158209),
('uedRkJnwLUi9hREj9hj77eUigXWSueDUI78eISuW', NULL, '157.245.108.208', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNGxscVJnc1FTMDJqdndQdnFvWnNpOWpQTXR1cGhkQ2s0MG1EcjVVViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3NpZ25pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771401528),
('uFQoxEDft2BvVKpbp0Yu0CFIl4UWMZuJkA4AJBvW', NULL, '115.127.218.189', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Safari/605.1.15', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSjlhYlAwS2dhbFl0QkFPRmJheXdySU9Ua29pNVBKY1BUa3VSdExtRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHBzOi8vYXBwLmNvbm5lY3RlZGVkdWNhdGlvbi5jb20vc2lnbmluIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771687588),
('UMUGsCkQUTZicraz3jP42Rxmq7X5VNmBumOML7cN', NULL, '106.75.164.76', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWDJJUG5tQ3BQb0N2RUZKVksyR3cxb0Y0cjRZdlJyT0xJRkZ6UFlTTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771460144),
('uW8seyb5b3uQ8Zu5TQRn0EwYYu2ydgkXo4G3j7np', NULL, '103.204.211.24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNWkwVGlvRmRDOHVhQmh1b1pEWG1KTGg2Q0pETGI0eDFINEpGbWZseiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHBzOi8vd3d3LnRydXN0Zm9saW9iZC54eXovc2hvdy1pcCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771338797),
('uZKyAVsduBxUDIZeb8iHj66x631OsGKirAb3IGey', NULL, '2a06:98c0:3600::103', 'https://trustfoliobd.xyz/wordpress/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicHdPdTZ6emVyd0E4RHJQaVJ1blpnUVpFRXVCNmRrM0w4WEtDb3hvSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei93b3JkcHJlc3Mvd3AtYWRtaW4vc2V0dXAtY29uZmlnLnBocCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771268162),
('v2SyPa6OY2kGMvsBaFLheS5P65f4TOFxCMLwIkJq', NULL, '35.203.211.87', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieGplVDNlRFdyd1ZQVVN1QUdWOUppSjk5d0poelQySVNPMW5vN1NYTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vNzYuMTMuMTg5LjExMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771702931),
('v3mq3cdMw11SagrnKADXjLApwLO9XLVYzhWwzVMq', NULL, '157.245.108.208', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVkV2cm5TYzVoRG42QTdmU0o3YXU5YXZWS3FRb1pkWGZYT21yeVlvWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771401530),
('V3rH4nTeHZvlFb0nLmoaDEP1d7C7BROJ4UylT9cY', NULL, '27.115.124.6', 'Mozilla/5.0 (Linux; Android 10; HUAWEI P30 Pro) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.105 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN2xXSzZualFZd0M4cTB5V3NrVGpCTm93MXVOckJZaGYyeG1yNzhKUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly93d3cudHJ1c3Rmb2xpb2JkLnh5ei9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771460198),
('VapFR4c3H7wWrYGicWzLsNQcCWEXpWzynx9E1GHP', NULL, '104.28.117.2', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/601.2.4 (KHTML, like Gecko) Version/9.0.1 Safari/601.2.4 facebookexternalhit/1.1 Facebot Twitterbot/1.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibEhlZU1qY1p1MVpKTWhmQkNpdGxmSVNNYzNxZ0FSbTNFOEpHVDZFZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771405393),
('VTr6XROOelUNX96Hl67VN2ykfvvRBHYS0t6Zx9Px', NULL, '103.204.211.24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVUFQS2FKWTIySFhjZm91Y3ppeHVOaHBJRldZdnhRMnd2ZnpEU29OcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHBzOi8vd3d3LnRydXN0Zm9saW9iZC54eXovaW5zdHJ1Y3Rpb25zIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771317942),
('VxD7YUcO1W6X27wkidYSPn83NIofDqNrdJQAy0ru', NULL, '104.23.221.26', 'https://trustfoliobd.xyz/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiemkzWWY2WG1aSlpXeW00U3ZYMHZRQkpnYXd4TXp3Z0JYU01hNVZDUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771178380),
('vzNmvTIupPuL18Z9cEVHgZZqaxjyWlw74BgXCgcd', NULL, '192.71.36.158', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.3', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZXpPdXNuOVRBMThKdk9PMVhwQXpzdnNUQkNOUktMRktTM3oyWENDSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771363539),
('WgJtD7BgCJdcs4xZYbxFWCLXbw7KX0kBRMG8rfZI', NULL, '2a06:98c0:3600::103', 'http://trustfoliobd.xyz/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUEMyQTN0QWVnb0x5cXE1M29RSVkzb21kd2MxYjlLcm9PYmhFajVxdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3dwLWFkbWluL3NldHVwLWNvbmZpZy5waHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771406619),
('X3Vjw08P0ygN04vNXUwTvuzAIDEPHSWbYTX0DoYS', NULL, '103.120.189.68', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.2 Safari/605.1.15', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR0d4eFZidGdScXR1a3MxRGFGODdJbkhxbjVSbDdzSG5WNnMwelJrVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vNzYuMTMuMTg5LjExMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771693111),
('XymHlnXAb0qDfwDXtxGpniTJ0aJBqb9GxSfbW09J', NULL, '104.23.223.123', 'http://trustfoliobd.xyz/wordpress/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWVJVTFU4ejJ2MFByS2dFQUVLaFJqNmxvczdTbFdXa2FXUzNLNHNJNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTk6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3dvcmRwcmVzcy93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771243107),
('y0RZHlG59f2FZDcR1ynRm7LMMlaiIPmrdyIot7Xe', NULL, '2a06:98c0:3600::103', 'http://trustfoliobd.xyz/wordpress/wp-admin/setup-config.php', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid2lYZGp6RGllTEJGY3J2c05keTd4VFVxQlVyblZSSmV4emJ6c0R4ayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTk6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6L3dvcmRwcmVzcy93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771321817);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('ynnJwZj0ZP4HCVizF9i67PgKxSiaQXwmqTAzhOes', NULL, '167.94.138.114', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQkhPcVZZQVNKR0ZKeDlRem0wSHdMZUZZYjhxbTF1dDNzREV1aTJzeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vNzYuMTMuMTg5LjExMS9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771714688),
('YpzM0N1X0sJ7iYv5HNaChJe9xd54d6QOSo7TWtWC', NULL, '147.185.132.25', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQnBnRGhTaUVQUEJQblJpcWVlRnVDcDdEdUxpanpsUEZOWGQwdUVwYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly90cnVzdGZvbGlvYmQueHl6Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771363323),
('z8SR8ABUyAH2hxnjBFWwRwyozW6JAGsp00xu4Q8E', NULL, '104.23.223.123', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ1VsSzVzc0pyNld6MGhVYnNHSzBjeVlxdnk0U2FLUVpwSFFTRTdDRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjA6Imh0dHBzOi8vdHJ1c3Rmb2xpb2JkLnh5ei93b3JkcHJlc3Mvd3AtYWRtaW4vc2V0dXAtY29uZmlnLnBocCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771178544),
('ZCZYYZqzvwjhLdOFfMkRX3CPt5xv9CBv4WFuhkq7', NULL, '42.240.130.92', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ1NteEx5OGJEZ21IWlJTRnd0aXJxMG12ZTFkaUxsQnRYSGFXNXBxMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly93d3cudHJ1c3Rmb2xpb2JkLnh5eiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771460127),
('ZmAtSnfQgZxImjrro4VZ6S2y3Phfp5nBrnXZ0Y85', NULL, '147.185.133.9', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUk1MUHg4MnBNRVVycGs4UlpUZzlxU0xYMGNpbm1GY3hHdnVVU2ZraSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vNzYuMTMuMTg5LjExMS9zaWduaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771634575);

-- --------------------------------------------------------

--
-- Table structure for table `sub_departments`
--

CREATE TABLE `sub_departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `industry_id` bigint(20) UNSIGNED NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `details` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_departments`
--

INSERT INTO `sub_departments` (`id`, `industry_id`, `department_id`, `name`, `details`, `created_at`, `updated_at`) VALUES
(7, 1, 8, 'Clinical Services', 'Provide direct patient care, diagnose medical conditions, and develop treatment plans to improve patient health outcomes.', '2025-12-13 08:40:36', '2025-12-13 08:40:36'),
(8, 1, 8, 'Nursing', 'Offer comprehensive patient care, administer medications, and support recovery and rehabilitation efforts in various healthcare settings.', '2025-12-13 08:44:10', '2025-12-13 08:44:10'),
(9, 1, 8, 'Emergency Services', 'Deliver immediate medical care and life-saving interventions for patients experiencing acute health emergencies.', '2025-12-13 08:45:30', '2025-12-13 08:45:30'),
(10, 1, 8, 'Surgical Services', 'Perform surgical procedures to treat injuries, diseases, and deformities, ensuring patient safety and optimal outcomes.', '2025-12-13 08:45:47', '2025-12-13 08:45:47'),
(11, 1, 8, 'Anesthesiology', 'Provide anesthesia and pain management services for patients undergoing surgical and medical procedures.', '2025-12-13 08:46:01', '2025-12-13 08:46:01'),
(12, 1, 8, 'Rehabilitation Services', 'Assist patients in recovering and rehabilitating from physical injuries or surgeries, improving mobility and function.', '2025-12-13 08:46:13', '2025-12-13 08:46:13'),
(13, 1, 9, 'Cardiology', 'Diagnose and treat heart and vascular conditions, offering both non-invasive and interventional cardiology services.', '2025-12-13 08:46:39', '2025-12-13 08:46:39'),
(14, 1, 9, 'Oncology', 'Diagnose and treat various types of cancer, offering medical, surgical, and radiation oncology services.', '2025-12-13 08:46:50', '2025-12-13 08:46:50'),
(15, 1, 9, 'Pediatrics', 'Provide medical care and treatment for infants, children, and adolescents, focusing on their unique health needs and development.', '2025-12-13 08:47:02', '2025-12-13 08:47:02'),
(16, 1, 9, 'Geriatrics', 'Focus on the healthcare of elderly patients, addressing age-related conditions and promoting healthy aging.', '2025-12-13 08:47:13', '2025-12-13 08:47:13'),
(17, 1, 9, 'Dermatology', 'Diagnose and treat skin conditions, including medical, surgical, and cosmetic dermatology services.', '2025-12-13 08:47:24', '2025-12-13 08:47:24'),
(18, 1, 9, 'Ophthalmology', 'Provide eye care, including the diagnosis and treatment of eye diseases and vision correction.', '2025-12-13 08:47:40', '2025-12-13 08:47:40'),
(19, 1, 8, 'Orthopedics', 'Specialize in the treatment of musculoskeletal conditions, including surgical and non-surgical interventions.', '2025-12-13 08:47:51', '2025-12-13 08:47:51'),
(20, 1, 9, 'Pulmonology', 'Diagnose and treat respiratory conditions, offering services such as pulmonary function testing and bronchoscopy.', '2025-12-13 08:48:00', '2025-12-13 08:48:00'),
(21, 1, 9, 'Nephrology', 'Manage kidney-related conditions, providing treatments such as dialysis and kidney transplant care.', '2025-12-13 08:48:13', '2025-12-13 08:48:13'),
(22, 1, 9, 'Gastroenterology', 'Diagnose and treat digestive system disorders, offering procedures like endoscopy and colonoscopy.', '2025-12-13 08:48:27', '2025-12-13 08:48:27'),
(23, 1, 9, 'Neurology', 'Diagnose and treat neurological disorders, providing both medical and surgical interventions for conditions affecting the nervous system.', '2025-12-13 08:48:50', '2025-12-13 08:48:50'),
(24, 1, 9, 'Obstetrics and Gynecology (OB/GYN)', 'Provide care related to pregnancy, childbirth, and female reproductive health.', '2025-12-13 08:49:02', '2025-12-13 08:49:02'),
(25, 1, 9, 'Mental Health Services', 'Address mental health conditions through counseling, therapy, and psychiatric care, promoting mental well-being.', '2025-12-13 08:50:05', '2025-12-13 08:50:05'),
(26, 1, 9, 'Palliative Care', 'Offer supportive care to patients with serious illnesses, focusing on relieving symptoms and improving quality of life.', '2025-12-13 08:50:17', '2025-12-13 08:50:17'),
(27, 2, 12, 'Software Development', 'Design, develop, test, and maintain software applications to meet user requirements and business goals.', '2025-12-13 08:54:54', '2025-12-13 08:54:54'),
(28, 2, 12, 'Mobile Development', 'Design, develop, and maintain mobile applications for various platforms, ensuring functionality and performance.', '2025-12-13 08:55:05', '2025-12-13 08:55:05'),
(29, 2, 12, 'DevOps', 'Integrate development and operations processes to enhance collaboration, automate deployments, and improve system reliability.', '2025-12-13 08:55:21', '2025-12-13 08:55:21'),
(30, 2, 12, 'IT Architecture', 'Plan and design the IT infrastructure, ensuring it aligns with the company\'s strategic goals and supports business processes.', '2025-12-13 08:55:31', '2025-12-13 08:55:31'),
(31, 2, 13, 'Information Security (Cybersecurity)', 'Protect the company\'s data and IT infrastructure by implementing security measures and monitoring for threats.', '2025-12-13 08:55:54', '2025-12-13 08:55:54'),
(32, 2, 13, 'Network Administration', 'Manage and maintain the company\'s network infrastructure to ensure seamless connectivity and security.', '2025-12-13 08:56:08', '2025-12-13 08:56:08'),
(33, 2, 13, 'Systems Administration', 'Oversee and maintain IT systems and servers, ensuring optimal performance and reliability.', '2025-12-13 08:56:20', '2025-12-13 08:56:20'),
(34, 3, 17, 'Treasury', 'Oversee cash management, investment strategies, and financial risk management to ensure liquidity and optimize financial resources.', '2025-12-26 07:47:47', '2025-12-26 07:47:47'),
(35, 3, 17, 'Financial Planning and Analysis (FP&A)', 'Perform budgeting, forecasting, and financial analysis to support strategic decision-making and performance management.', '2025-12-26 07:49:48', '2025-12-26 07:49:48'),
(36, 3, 17, 'Tax', 'Ensure compliance with tax laws, manage tax planning and reporting, and optimize the company\'s tax position.', '2025-12-26 07:51:24', '2025-12-26 07:51:24'),
(37, 3, 18, 'Risk Management', 'Identify, assess, and mitigate financial and operational risks to protect the company\'s assets and ensure regulatory compliance.', '2025-12-26 07:56:38', '2025-12-26 07:56:38'),
(38, 3, 18, 'Internal Audit', 'Conduct independent evaluations of the company\'s internal controls, risk management, and governance processes to ensure effectiveness and compliance.', '2025-12-26 07:57:17', '2025-12-26 07:57:17'),
(39, 3, 18, 'Credit Analysis', 'Assess the creditworthiness of potential clients and manage the company\'s credit risk to maintain financial stability.', '2025-12-26 07:58:21', '2025-12-26 07:58:21'),
(40, 3, 19, 'Investor Relations', 'Manage communication between the company and its investors, providing transparency and maintaining investor confidence.', '2025-12-26 07:59:22', '2025-12-26 07:59:22'),
(41, 3, 19, 'Mergers and Acquisitions (M&A)', 'Identify, evaluate, and execute mergers, acquisitions, and divestitures to support the company\'s strategic growth objectives.', '2025-12-26 08:00:05', '2025-12-26 08:00:05'),
(42, 3, 19, 'Corporate Strategy', 'Formulate and implement strategic initiatives to achieve long-term business objectives and sustain competitive advantage.', '2025-12-26 08:00:53', '2025-12-26 08:00:53'),
(43, 3, 19, 'Investment Management', 'Manage the company\'s investment portfolio, aiming to achieve optimal returns while managing risk.', '2025-12-26 08:01:25', '2025-12-26 08:01:25'),
(44, 3, 19, 'Portfolio Management', 'Oversee investment portfolios, ensuring alignment with the company’s financial goals and risk tolerance.', '2025-12-26 08:02:08', '2025-12-26 08:02:08'),
(45, 3, 20, 'Financial Consulting', 'Provide expert advice on financial planning, investment strategies, and risk management to optimize the company\'s financial performance.', '2025-12-26 08:02:55', '2025-12-26 08:02:55'),
(46, 3, 20, 'Data Analytics', 'Analyze financial data to extract actionable insights, supporting decision-making and strategic planning.', '2025-12-26 08:03:19', '2025-12-26 08:03:19'),
(47, 3, 20, 'Economic Research', 'Conduct research and analysis on economic trends, providing insights to inform business strategies and financial decisions.', '2025-12-26 08:03:45', '2025-12-26 08:03:45'),
(48, 3, 21, 'Asset Management', 'Manage and optimize the company\'s physical and financial assets to maximize value and efficiency.', '2025-12-26 08:04:28', '2025-12-26 08:04:28'),
(49, 4, 22, 'Mechanical Engineering', 'Design, analyze, and manufacture mechanical systems and devices to solve engineering challenges and improve processes.', '2025-12-26 08:34:16', '2025-12-26 08:34:16'),
(50, 4, 22, 'Electrical Engineering', 'Develop and implement electrical systems, including power generation, transmission, and distribution, as well as electronic devices.', '2025-12-26 08:34:16', '2025-12-26 08:34:16'),
(51, 4, 22, 'Civil Engineering', 'Plan, design, and oversee the construction and maintenance of infrastructure projects such as roads, bridges, and buildings.', '2025-12-26 08:34:16', '2025-12-26 08:34:16'),
(52, 4, 22, 'Chemical Engineering', 'Design processes and equipment for large-scale manufacturing, plan and test production methods, and oversee the production of chemicals.', '2025-12-26 08:34:16', '2025-12-26 08:34:16'),
(53, 4, 23, 'Structural Engineering', 'Ensure the structural integrity and safety of buildings, bridges, and other structures through detailed analysis and design.', '2025-12-26 08:36:31', '2025-12-26 08:36:31'),
(54, 4, 23, 'Environmental Engineering', 'Develop solutions to environmental challenges, focusing on water and air pollution control, waste management, and sustainable design.', '2025-12-26 08:36:31', '2025-12-26 08:36:31'),
(55, 4, 23, 'Aerospace Engineering', 'Design and develop aircraft, spacecraft, and related systems and equipment, focusing on improving performance, safety, and efficiency.', '2025-12-26 08:36:31', '2025-12-26 08:36:31'),
(56, 4, 23, 'Biomedical Engineering', 'Combine principles of engineering and biological sciences to develop technologies and devices that improve healthcare and medical practices.', '2025-12-26 08:36:31', '2025-12-26 08:36:31'),
(57, 4, 23, 'Materials Engineering', 'Develop, process, and test materials used to create a wide range of products, ensuring they meet the necessary mechanical, electrical, and chemical requirements.', '2025-12-26 08:36:31', '2025-12-26 08:36:31'),
(62, 4, 24, 'Systems Engineering', 'Integrate various engineering disciplines and specialty groups into a unified, structured process to ensure the successful development and implementation of complex systems.', '2025-12-26 08:44:35', '2025-12-26 08:44:35'),
(63, 4, 24, 'Industrial Engineering', 'Optimize complex processes and systems, focusing on improving efficiency, productivity, and overall performance in manufacturing and service industries.', '2025-12-26 08:44:35', '2025-12-26 08:44:35'),
(64, 4, 24, 'Automation Engineering', 'Develop automated systems and processes to increase efficiency, reduce human error, and improve safety in production and operations.', '2025-12-26 08:44:35', '2025-12-26 08:44:35'),
(65, 4, 24, 'Manufacturing Engineering', 'Design and optimize manufacturing processes, equipment, and systems to improve production efficiency and product quality.', '2025-12-26 08:44:35', '2025-12-26 08:44:35'),
(66, 4, 25, 'Quality Assurance (QA)', 'Ensure that engineering projects meet specified quality standards through rigorous testing, inspection, and continuous improvement processes.', '2025-12-26 08:46:16', '2025-12-26 08:46:16'),
(67, 4, 25, 'Technical Writing', 'Create and maintain comprehensive documentation for engineering projects and processes to ensure clear communication.', '2025-12-26 08:46:16', '2025-12-26 08:46:16'),
(68, 6, 26, 'Academic Affairs', 'Oversee curriculum development, academic policies, and faculty support to ensure high-quality educational programs.', '2025-12-26 08:51:21', '2025-12-26 08:51:21'),
(69, 6, 26, 'Curriculum Development', 'Design and update educational programs and courses to meet the evolving needs of students and industry standards.', '2025-12-26 08:51:21', '2025-12-26 08:51:21'),
(70, 6, 26, 'Instructional Design', 'Develop and implement effective teaching methods and educational technologies to enhance the learning experience.', '2025-12-26 08:51:21', '2025-12-26 08:51:21'),
(71, 6, 27, 'Admissions', 'Manage the student application and enrollment process, including recruitment, application review, and admission decisions.', '2025-12-26 08:53:53', '2025-12-26 08:53:53'),
(72, 6, 27, 'Student Affairs', 'Provide support services and resources to enhance student life, including counseling, career services, and extracurricular activities.', '2025-12-26 08:53:53', '2025-12-26 08:53:53'),
(73, 6, 27, 'Academic Advising', 'Provide guidance and support to students in selecting courses, planning their academic path, and achieving their educational goals.', '2025-12-26 08:53:53', '2025-12-26 08:53:53'),
(74, 6, 27, 'Financial Aid', 'Assist students in securing financial support through scholarships, grants, loans, and work-study programs.', '2025-12-26 08:53:53', '2025-12-26 08:53:53'),
(75, 6, 27, 'Registrar', 'Maintain student records, manage course registrations, and oversee the administration of academic policies and procedures.', '2025-12-26 08:53:53', '2025-12-26 08:53:53'),
(76, 6, 28, 'Faculty Development', 'Offer professional development opportunities, training, and resources to support faculty in their teaching and research efforts.', '2025-12-26 08:54:57', '2025-12-26 08:54:57'),
(77, 6, 28, 'Diversity and Inclusion', 'Promote and support a diverse and inclusive learning environment through initiatives, policies, and programs.', '2025-12-26 08:54:57', '2025-12-26 08:54:57'),
(78, 6, 29, 'Assessment and Evaluation', 'Conduct assessments and evaluations of educational programs and student learning outcomes to ensure continuous improvement.', '2025-12-26 08:55:53', '2025-12-26 08:55:53'),
(79, 6, 29, 'Quality Assurance (QA)', 'Ensure that educational programs meet specified quality standards through rigorous testing, inspection, and continuous improvement processes.', '2025-12-26 08:55:53', '2025-12-26 08:55:53'),
(80, 6, 30, 'Library Services', 'Manage resources and services to support research, learning, and teaching, including access to books, journals, and digital resources.', '2025-12-26 08:56:37', '2025-12-26 08:56:37'),
(81, 6, 30, 'Campus Facilities Management', 'Ensure the maintenance, safety, and functionality of campus buildings and facilities to provide a conducive learning environment.', '2025-12-26 08:56:37', '2025-12-26 08:56:37'),
(82, 6, 31, 'Alumni Relations', 'Foster connections with alumni, organizing events and programs to engage former students and build a supportive community.', '2025-12-26 08:57:46', '2025-12-26 08:57:46'),
(83, 6, 31, 'Educational Outreach', 'Develop partnerships with schools, community organizations, and industry to promote educational programs and opportunities.', '2025-12-26 08:57:46', '2025-12-26 08:57:46'),
(84, 6, 31, 'Distance Learning', 'Develop and manage online education programs and courses, ensuring accessibility and quality for remote learners.', '2025-12-26 08:57:46', '2025-12-26 08:57:46'),
(85, 7, 32, 'Creative Development', 'Foster and develop artistic projects, including visual arts, music, literature, and performing arts.', '2025-12-26 09:05:16', '2025-12-26 09:05:16'),
(86, 7, 32, 'Art Direction', 'Provide artistic vision and direction for creative projects, ensuring cohesive and impactful visual presentations.', '2025-12-26 09:05:17', '2025-12-26 09:05:17'),
(87, 7, 32, 'Performance Production', 'Coordinate and manage the production of live performances, including theater, dance, and music.', '2025-12-26 09:05:17', '2025-12-26 09:05:17'),
(88, 7, 32, 'Media Production', 'Produce and edit multimedia content, including films, videos, and digital media, to document and promote arts and culture.', '2025-12-26 09:05:17', '2025-12-26 09:05:17'),
(89, 7, 33, 'Curatorial', 'Select and organize exhibitions, performances, and cultural events, ensuring a diverse and engaging program.', '2025-12-26 09:06:13', '2025-12-26 09:06:13'),
(90, 7, 33, 'Exhibition Design', 'Design and create engaging and informative exhibits for museums, galleries, and cultural institutions.', '2025-12-26 09:06:13', '2025-12-26 09:06:13'),
(91, 7, 33, 'Cultural Programming', 'Develop and implement cultural programs and events that reflect and celebrate diverse cultural expressions.', '2025-12-26 09:06:13', '2025-12-26 09:06:13'),
(92, 7, 34, 'Education and Outreach', 'Develop and implement educational programs and community outreach initiatives to promote arts and humanities.', '2025-12-26 09:07:12', '2025-12-26 09:07:12'),
(93, 7, 34, 'Museum Education', 'Create and deliver educational programs and tours for museum visitors to enhance their understanding of exhibits.', '2025-12-26 09:07:12', '2025-12-26 09:07:12'),
(94, 7, 34, 'Library and Archives', 'Manage collections of books, manuscripts, and other cultural materials, providing access and preservation.', '2025-12-26 09:07:12', '2025-12-26 09:07:12'),
(95, 7, 35, 'Grant Writing', 'Research and write grant proposals to secure funding for artistic and cultural projects.', '2025-12-26 09:08:14', '2025-12-26 09:08:14'),
(96, 7, 35, 'Artist Relations', 'Support and manage relationships with artists, providing resources and opportunities for their work.', '2025-12-26 09:08:14', '2025-12-26 09:08:14'),
(97, 7, 36, 'Editorial', 'Oversee the creation, editing, and publication of written content, ensuring high quality and adherence to editorial standards.', '2025-12-26 09:09:32', '2025-12-26 09:09:32'),
(98, 7, 36, 'Publications', 'Produce and distribute publications, such as catalogs, books, and journals, that document and explore the arts and humanities.', '2025-12-26 09:09:32', '2025-12-26 09:09:32'),
(99, 7, 36, 'Cultural Heritage Management', 'Preserve and manage cultural artifacts, historical sites, and documents to safeguard cultural heritage.', '2025-12-26 09:09:32', '2025-12-26 09:09:32'),
(100, 9, 37, 'Basic Research', 'Conduct fundamental research to expand scientific knowledge without immediate practical applications.', '2025-12-26 09:20:12', '2025-12-26 09:20:12'),
(101, 9, 37, 'Applied Research', 'Focus on practical applications of scientific discoveries to solve real-world problems.', '2025-12-26 09:20:12', '2025-12-26 09:20:12'),
(102, 9, 37, 'Field Research', 'Conduct research outside the laboratory in natural environments to collect data and study phenomena in situ.', '2025-12-26 09:20:12', '2025-12-26 09:20:12'),
(103, 9, 38, 'Experimental Design', 'Develop and implement experimental protocols and methodologies to test hypotheses and gather data.', '2025-12-26 09:21:30', '2025-12-26 09:21:30'),
(104, 9, 38, 'Data Analysis', 'Analyze and interpret complex datasets to draw meaningful conclusions and support scientific findings.', '2025-12-26 09:21:30', '2025-12-26 09:21:30'),
(105, 9, 38, 'Bioinformatics', 'Apply computational techniques to analyze biological data and support research in genomics, proteomics, and other fields.', '2025-12-26 09:21:30', '2025-12-26 09:21:30'),
(106, 9, 39, 'Laboratory Management', 'Oversee the daily operations of research laboratories, ensuring safety, efficiency, and proper use of equipment and resources.', '2025-12-26 09:22:55', '2025-12-26 09:22:55'),
(107, 9, 39, 'Instrumentation and Equipment Development', 'Design and develop specialized instruments and equipment to support advanced scientific research.', '2025-12-26 09:22:55', '2025-12-26 09:22:55'),
(108, 9, 39, 'Environmental Monitoring', 'Conduct continuous monitoring of environmental parameters to support research on ecological and environmental changes.', '2025-12-26 09:22:55', '2025-12-26 09:22:55'),
(109, 9, 40, 'Scientific Writing', 'Prepare and publish research findings in scientific journals, ensuring clear communication of results and methodologies.', '2025-12-26 09:24:57', '2025-12-26 09:24:57'),
(110, 9, 40, 'Grant Writing', 'Write proposals to secure funding for scientific research projects from government agencies, foundations, and other funding sources.', '2025-12-26 09:24:57', '2025-12-26 09:24:57'),
(111, 9, 40, 'Peer Review Coordination', 'Organize and manage the peer review process for scientific publications and research proposals.', '2025-12-26 09:24:57', '2025-12-26 09:24:57'),
(112, 9, 41, 'Collaborative Research', 'Coordinate and manage collaborative projects with other research institutions, universities, and industry partners.', '2025-12-26 09:26:13', '2025-12-26 09:26:13'),
(113, 9, 41, 'Ethics and Compliance', 'Ensure that all research activities comply with ethical standards and regulatory requirements.', '2025-12-26 09:26:13', '2025-12-26 09:26:13'),
(114, 9, 41, 'Technology Transfer', 'Facilitate the transfer of scientific discoveries and technologies from the research environment to commercial applications.', '2025-12-26 09:26:13', '2025-12-26 09:26:13'),
(115, 9, 42, 'Training and Education', 'Provide training and educational opportunities for researchers, students, and staff to enhance their scientific skills and knowledge.', '2025-12-26 09:27:21', '2025-12-26 09:27:21'),
(116, 9, 42, 'Knowledge Management', 'Manage and organize scientific data, publications, and intellectual property to facilitate information sharing and collaboration.', '2025-12-26 09:27:21', '2025-12-26 09:27:21'),
(117, 9, 43, 'Quality Control', 'Ensure the accuracy and reliability of scientific data through rigorous quality control and validation procedures.', '2025-12-26 09:27:52', '2025-12-26 09:27:52'),
(118, 10, 44, 'Case Management', 'Provide individualized support and advocacy for clients, connecting them with necessary services and resources to improve their well-being.', '2025-12-26 09:48:31', '2025-12-26 09:48:31'),
(119, 10, 44, 'Crisis Intervention', 'Provide immediate assistance and support to individuals in crisis situations, ensuring their safety and connecting them with necessary resources.', '2025-12-26 09:48:31', '2025-12-26 09:48:31'),
(120, 10, 44, 'Family Support Services', 'Provide resources and assistance to families in need, including parenting support, family counseling, and access to social services.', '2025-12-26 09:48:31', '2025-12-26 09:48:31'),
(121, 10, 44, 'Disability Services', 'Provide support and resources for individuals with disabilities, ensuring access to necessary services, accommodations, and opportunities.', '2025-12-26 09:48:31', '2025-12-26 09:48:31'),
(122, 10, 45, 'Mental Health Services', 'Offer counseling, therapy, and psychiatric services to individuals and families to improve mental health and emotional well-being.', '2025-12-26 09:50:49', '2025-12-26 09:50:49'),
(123, 10, 45, 'Substance Abuse Services', 'Offer treatment and support for individuals struggling with substance abuse, including counseling, rehabilitation, and recovery programs.', '2025-12-26 09:50:49', '2025-12-26 09:50:49'),
(124, 10, 45, 'Domestic Violence Services', 'Provide support and resources for individuals affected by domestic violence, including shelters, counseling, and legal assistance.', '2025-12-26 09:50:49', '2025-12-26 09:50:49'),
(125, 10, 46, 'Community Outreach', 'Develop and implement programs to engage and support communities, raising awareness of available services and fostering community development.', '2025-12-26 22:58:59', '2025-12-26 22:58:59'),
(126, 10, 46, 'Youth Services', 'Develop and implement programs specifically designed to support and empower young people, including education, mentoring, and recreational activities.', '2025-12-26 22:58:59', '2025-12-26 22:58:59'),
(127, 10, 46, 'Elderly Services', 'Offer programs and support specifically designed for the elderly, including health services, social activities, and assistance with daily living.', '2025-12-26 22:58:59', '2025-12-26 22:58:59'),
(128, 10, 46, 'Immigration Services', 'Assist immigrants and refugees with legal support, integration programs, and access to social services.', '2025-12-26 22:58:59', '2025-12-26 22:58:59'),
(129, 10, 47, 'Employment Services', 'Provide job training, employment counseling, and placement services to help individuals achieve economic stability and independence.', '2025-12-26 22:59:45', '2025-12-26 22:59:45'),
(130, 10, 47, 'Housing Services', 'Assist individuals and families in securing stable housing, offering support for finding, maintaining, and affording housing.', '2025-12-26 22:59:45', '2025-12-26 22:59:45'),
(131, 10, 48, 'Health Services', 'Offer basic healthcare services, health education, and preventative care to improve the overall health of the community.', '2025-12-26 23:00:44', '2025-12-26 23:00:44'),
(132, 10, 48, 'Food and Nutrition Services', 'Offer food assistance programs, nutrition counseling, and meal services to ensure individuals and families have access to healthy food.', '2025-12-26 23:00:44', '2025-12-26 23:00:44'),
(133, 10, 49, 'Education and Training', 'Develop and deliver educational programs and training sessions for clients, staff, and the community to enhance skills and knowledge.', '2025-12-26 23:01:25', '2025-12-26 23:01:25'),
(134, 10, 49, 'Volunteer Coordination', 'Recruit, train, and manage volunteers to support the organization’s programs and services.', '2025-12-26 23:01:25', '2025-12-26 23:01:25'),
(135, 10, 50, 'Advocacy and Policy', 'Work to influence public policy and advocate for systemic changes that promote social justice and support vulnerable populations.', '2025-12-26 23:01:52', '2025-12-26 23:01:52'),
(136, 11, 51, 'Prosecution Services', 'Represent the state or government in prosecuting criminal cases, ensuring justice is served in the court of law.', '2025-12-26 23:04:22', '2025-12-26 23:04:22'),
(137, 11, 51, 'Public Defense', 'Provide legal representation to individuals who cannot afford private attorneys, ensuring fair legal treatment.', '2025-12-26 23:04:22', '2025-12-26 23:04:22'),
(138, 11, 51, 'Judicial Services', 'Administer and oversee court proceedings, ensuring legal processes are followed and justice is delivered impartially.', '2025-12-26 23:04:22', '2025-12-26 23:04:22'),
(139, 11, 51, 'Legal Aid Services', 'Provide legal assistance and advice to individuals in need, ensuring access to justice for all.', '2025-12-26 23:04:22', '2025-12-26 23:04:22'),
(140, 11, 51, 'Court Administration', 'Manage the administrative functions of the court system, including scheduling, records management, and case tracking.', '2025-12-26 23:04:22', '2025-12-26 23:04:22'),
(141, 11, 52, 'Criminal Investigation', 'Conduct investigations into criminal activities, gather evidence, and build cases to support prosecutions.', '2025-12-26 23:05:57', '2025-12-26 23:05:57'),
(142, 11, 52, 'Forensic Services', 'Analyze physical evidence from crime scenes using scientific methods to support criminal investigations and prosecutions.', '2025-12-26 23:05:57', '2025-12-26 23:05:57'),
(143, 11, 52, 'Surveillance and Intelligence', 'Monitor and gather intelligence on criminal activities to prevent crime and enhance public safety.', '2025-12-26 23:05:57', '2025-12-26 23:05:57'),
(144, 11, 52, 'Internal Affairs', 'Investigate allegations of misconduct within law enforcement agencies to maintain integrity and accountability.', '2025-12-26 23:05:57', '2025-12-26 23:05:57'),
(145, 11, 53, 'Community Policing', 'Engage with community members to build trust, prevent crime, and address public safety concerns collaboratively.', '2025-12-26 23:07:19', '2025-12-26 23:07:19'),
(146, 11, 53, 'Victim Support Services', 'Provide support, resources, and advocacy for victims of crime to help them recover and navigate the legal system.', '2025-12-26 23:07:19', '2025-12-26 23:07:19'),
(147, 11, 53, 'Probation and Parole Services', 'Supervise offenders who are on probation or parole, ensuring they comply with the terms of their release and supporting their reintegration into society.', '2025-12-26 23:07:19', '2025-12-26 23:07:19'),
(148, 11, 53, 'Juvenile Justice Services', 'Address the legal and rehabilitative needs of juvenile offenders, focusing on their reintegration and prevention of future offenses.', '2025-12-26 23:07:19', '2025-12-26 23:07:19'),
(149, 11, 54, 'Corrections Management', 'Oversee the operation of correctional facilities, including prisons and rehabilitation programs for offenders.', '2025-12-26 23:08:42', '2025-12-26 23:08:42'),
(150, 11, 54, 'Law Enforcement Training', 'Develop and deliver training programs for law enforcement personnel to ensure they are well-prepared to perform their duties.', '2025-12-26 23:08:42', '2025-12-26 23:08:42'),
(151, 11, 54, 'Alternative Dispute Resolution (ADR)', 'Provide mediation and arbitration services to resolve disputes outside the traditional court system.', '2025-12-26 23:08:42', '2025-12-26 23:08:42'),
(152, 11, 54, 'Emergency Response Services', 'Coordinate and respond to emergencies, ensuring public safety and efficient crisis management.', '2025-12-26 23:08:42', '2025-12-26 23:08:42'),
(153, 11, 55, 'Policy Analysis and Reform', 'Analyze current laws and policies, advocating for and implementing reforms to improve the justice system.', '2025-12-26 23:09:13', '2025-12-26 23:09:13'),
(154, 12, 56, 'Editorial', 'Develop and oversee the creation of content, ensuring it meets editorial standards and aligns with the company\'s mission.', '2025-12-26 23:11:18', '2025-12-26 23:11:18'),
(155, 12, 56, 'Content Creation', 'Produce multimedia content, including articles, videos, podcasts, and graphics, to engage and inform the audience.', '2025-12-26 23:11:18', '2025-12-26 23:11:18'),
(156, 12, 56, 'Journalism', 'Investigate, report, and write news stories, providing accurate and timely information to the public.', '2025-12-26 23:11:18', '2025-12-26 23:11:18'),
(157, 12, 56, 'Copywriting', 'Write and edit compelling copy for various media, including advertising, promotional materials, and content marketing.', '2025-12-26 23:11:18', '2025-12-26 23:11:18'),
(158, 12, 57, 'Production', 'Coordinate and manage the technical aspects of content creation, including filming, recording, and editing.', '2025-12-26 23:12:30', '2025-12-26 23:12:30'),
(159, 12, 57, 'Video Production', 'Plan, shoot, and edit video content to support the company\'s storytelling and communication goals.', '2025-12-26 23:12:30', '2025-12-26 23:12:30'),
(160, 12, 57, 'Creative Services', 'Develop creative concepts and designs for various media, including print, digital, and broadcast.', '2025-12-26 23:12:30', '2025-12-26 23:12:30'),
(161, 12, 57, 'Graphic Design', 'Create visual content for various media platforms, including websites, social media, and print materials.', '2025-12-26 23:12:30', '2025-12-26 23:12:30'),
(162, 12, 58, 'Broadcasting', 'Manage the production and airing of television and radio programs, ensuring quality and adherence to schedules.', '2025-12-26 23:13:23', '2025-12-26 23:13:23'),
(163, 12, 58, 'Content Distribution', 'Distribute content across various channels and platforms, ensuring maximum reach and accessibility.', '2025-12-26 23:13:23', '2025-12-26 23:13:23'),
(164, 12, 58, 'Media Planning and Buying', 'Plan and purchase advertising space across various media platforms to optimize reach and engagement.', '2025-12-26 23:13:23', '2025-12-26 23:13:23'),
(165, 12, 59, 'Social Media Management', 'Create and manage content for social media platforms, engaging with the audience and promoting the company\'s brand.', '2025-12-26 23:14:46', '2025-12-26 23:14:46'),
(166, 12, 59, 'Audience Development', 'Analyze audience data and develop strategies to grow and engage the audience across various platforms.', '2025-12-26 23:14:46', '2025-12-26 23:14:46'),
(167, 12, 59, 'Communications Strategy', 'Develop and implement communication strategies to effectively convey the company\'s messages and goals.', '2025-12-26 23:14:46', '2025-12-26 23:14:46'),
(168, 12, 59, 'Event Planning and Coordination', 'Plan and execute events, including press conferences, launches, and community outreach, to promote the company\'s initiatives.', '2025-12-26 23:14:46', '2025-12-26 23:14:46'),
(169, 12, 60, 'Talent Management', 'Recruit, manage, and develop on-air and creative talent, ensuring they align with the company\'s brand and objectives.', '2025-12-26 23:15:27', '2025-12-26 23:15:27'),
(170, 12, 60, 'Media Relations', 'Build and maintain relationships with media outlets and journalists to ensure positive coverage and manage media inquiries.', '2025-12-26 23:15:27', '2025-12-26 23:15:27'),
(171, 12, 61, 'Analytics and Insights', 'Analyze media performance data and audience metrics to inform content strategy and improve engagement.', '2025-12-26 23:15:58', '2025-12-26 23:15:58'),
(172, 13, 62, 'Environmental Conservation', 'Implement and manage programs to protect natural habitats and biodiversity.', '2025-12-26 23:17:39', '2025-12-26 23:17:39'),
(173, 13, 62, 'Biodiversity Research', 'Study and protect biodiversity through research, conservation efforts, and policy recommendations.', '2025-12-26 23:17:39', '2025-12-26 23:17:39'),
(174, 13, 62, 'Climate Science', 'Conduct research and analysis on climate patterns and develop strategies to mitigate climate change impacts.', '2025-12-26 23:17:39', '2025-12-26 23:17:39'),
(175, 13, 63, 'Sustainable Development', 'Develop and promote sustainable practices in urban planning, agriculture, and resource management.', '2025-12-26 23:19:25', '2025-12-26 23:19:25'),
(176, 13, 63, 'Green Building and Design', 'Advocate and implement eco-friendly construction practices and sustainable building designs.', '2025-12-26 23:19:25', '2025-12-26 23:19:25'),
(177, 13, 63, 'Sustainable Agriculture', 'Promote and implement farming practices that protect the environment and conserve resources.', '2025-12-26 23:19:25', '2025-12-26 23:19:25'),
(178, 13, 63, 'Sustainable Transportation', 'Promote and develop transportation solutions that reduce environmental impact and promote sustainability.', '2025-12-26 23:19:25', '2025-12-26 23:19:25'),
(179, 13, 64, 'Renewable Energy', 'Design, implement, and manage renewable energy projects to reduce carbon footprints and promote clean energy use.', '2025-12-26 23:20:34', '2025-12-26 23:20:34'),
(180, 13, 64, 'Water Resources Management', 'Ensure sustainable use and conservation of water resources through planning and management.', '2025-12-26 23:20:34', '2025-12-26 23:20:34'),
(181, 13, 64, 'Waste Management and Recycling', 'Develop and oversee programs to reduce waste, promote recycling, and manage disposal in an environmentally friendly manner.', '2025-12-26 23:20:34', '2025-12-26 23:20:34'),
(182, 13, 65, 'Environmental Policy and Advocacy', 'Work to influence and implement policies that promote environmental protection and sustainability.', '2025-12-26 23:21:30', '2025-12-26 23:21:30'),
(183, 13, 65, 'Corporate Sustainability', 'Develop and oversee sustainability initiatives within companies to improve environmental performance.', '2025-12-26 23:21:30', '2025-12-26 23:21:30'),
(184, 13, 65, 'Sustainability Consulting', 'Provide expert advice and strategies to organizations on how to implement sustainable practices and reduce environmental impact.', '2025-12-26 23:21:30', '2025-12-26 23:21:30'),
(185, 13, 66, 'Ecological Restoration', 'Plan and execute projects to restore damaged ecosystems to their natural state.', '2025-12-26 23:22:33', '2025-12-26 23:22:33'),
(186, 13, 66, 'Environmental Impact Assessment', 'Conduct assessments to evaluate the environmental impact of proposed projects and recommend mitigation measures.', '2025-12-26 23:22:33', '2025-12-26 23:22:33'),
(187, 13, 66, 'Carbon Management', 'Develop and manage carbon reduction projects and strategies to offset greenhouse gas emissions.', '2025-12-26 23:22:33', '2025-12-26 23:22:33'),
(188, 13, 67, 'Environmental Education and Outreach', 'Educate the public and stakeholders about environmental issues and promote sustainable practices.', '2025-12-26 23:23:00', '2025-12-26 23:23:00'),
(189, 14, 68, 'Architectural Design', 'Develop and create architectural plans and designs for buildings and structures, ensuring functionality and aesthetic appeal.', '2025-12-26 23:25:33', '2025-12-26 23:25:33'),
(190, 14, 68, 'Interior Design', 'Design and plan interior spaces, focusing on aesthetics, functionality, and the use of space to enhance quality of life.', '2025-12-26 23:25:33', '2025-12-26 23:25:33'),
(191, 14, 68, 'Landscape Architecture', 'Plan and design outdoor spaces, including parks, gardens, and recreational areas, integrating natural elements with built environments.', '2025-12-26 23:25:33', '2025-12-26 23:25:33'),
(192, 14, 68, 'Urban Planning', 'Develop comprehensive plans for the use and development of urban spaces, balancing the needs of communities with sustainable practices.', '2025-12-26 23:25:33', '2025-12-26 23:25:33'),
(193, 14, 69, 'Sustainable Design', 'Focus on creating environmentally friendly and energy-efficient designs that promote sustainability and reduce environmental impact.', '2025-12-26 23:28:18', '2025-12-26 23:28:18'),
(194, 14, 69, 'Structural Engineering', 'Ensure the structural integrity and safety of buildings and structures through detailed analysis and design.', '2025-12-26 23:28:18', '2025-12-26 23:28:18'),
(195, 14, 69, 'Lighting Design', 'Plan and design lighting solutions for both interior and exterior spaces, enhancing aesthetics and functionality.', '2025-12-26 23:28:18', '2025-12-26 23:28:18'),
(196, 14, 70, 'Visualization and Rendering', 'Develop high-quality visual representations of designs, including 3D models and renderings, to help clients visualize the final product.', '2025-12-26 23:29:47', '2025-12-26 23:29:47'),
(197, 14, 70, 'Graphic Design', 'Create visual content and branding materials to support architectural projects and company communications.', '2025-12-26 23:29:47', '2025-12-26 23:29:47'),
(198, 14, 70, 'BIM (Building Information Modeling)', 'Utilize BIM technology to create and manage digital representations of physical and functional characteristics of places.', '2025-12-26 23:29:47', '2025-12-26 23:29:47'),
(199, 14, 70, 'CAD (Computer-Aided Design)', 'Use CAD software to create precise drawings and technical illustrations for architectural and design projects.', '2025-12-26 23:29:47', '2025-12-26 23:29:47'),
(200, 14, 71, 'Materials Research and Specification', 'Research and select appropriate materials for projects, ensuring quality, sustainability, and aesthetic appeal.', '2025-12-26 23:31:04', '2025-12-26 23:31:04'),
(201, 14, 71, 'Site Analysis and Surveying', 'Conduct site surveys and analyses to gather data and inform design decisions.', '2025-12-26 23:31:04', '2025-12-26 23:31:04'),
(202, 14, 71, 'Construction Administration', 'Oversee the construction process, ensuring that designs are implemented correctly and according to specifications.', '2025-12-26 23:31:04', '2025-12-26 23:31:04'),
(203, 14, 72, 'Client Relations', 'Engage with clients to understand their needs, present design concepts, and ensure satisfaction throughout the project lifecycle.', '2025-12-26 23:31:31', '2025-12-26 23:31:31'),
(204, 15, 73, 'Guest Services', 'Ensure a high level of customer satisfaction by addressing guest needs and providing exceptional service throughout their stay.', '2025-12-26 23:33:47', '2025-12-26 23:33:47'),
(205, 15, 73, 'Concierge Services', 'Assist guests with reservations, recommendations, and arrangements for local activities, dining, and transportation.', '2025-12-26 23:33:47', '2025-12-26 23:33:47'),
(206, 15, 73, 'Guest Relations', 'Foster positive relationships with guests, addressing any issues or concerns promptly', '2025-12-26 23:33:47', '2025-12-26 23:33:47'),
(207, 15, 73, 'Recreation and Entertainment', 'Develop and oversee recreational activities and entertainment programs to enhance the guest experience.', '2025-12-26 23:33:47', '2025-12-26 23:33:47'),
(208, 15, 74, 'Front Desk and Reservations', 'Handle guest check-ins and check-outs, manage reservations, and provide information about the property and local attractions.', '2025-12-26 23:38:18', '2025-12-26 23:38:18'),
(209, 15, 74, 'Housekeeping', 'Maintain cleanliness and order in guest rooms and public areas to ensure a comfortable and hygienic environment for guests.', '2025-12-26 23:38:18', '2025-12-26 23:38:18'),
(210, 15, 74, 'Facilities Management', 'Oversee the maintenance and repair of the property, ensuring all facilities are in excellent working condition.', '2025-12-26 23:38:18', '2025-12-26 23:38:18'),
(211, 15, 74, 'Security Services', 'Ensure the safety and security of guests, staff, and property through vigilant monitoring and response protocols.', '2025-12-26 23:38:18', '2025-12-26 23:38:18'),
(212, 15, 75, 'Food and Beverage Services', 'Manage dining operations, including restaurants, bars, and room service, to provide high-quality food and drink experiences.', '2025-12-26 23:38:50', '2025-12-26 23:38:50'),
(213, 15, 77, 'Event Planning and Coordination', 'Organize and manage events, such as weddings, conferences, and banquets, ensuring all details are executed flawlessly.', '2025-12-26 23:39:36', '2025-12-26 23:39:36'),
(214, 15, 77, 'Cultural Programs', 'Develop and promote cultural activities and programs that highlight local traditions, arts, and heritage.', '2025-12-26 23:39:36', '2025-12-26 23:39:36'),
(215, 15, 76, 'Tour Operations', 'Plan, organize, and conduct tours and excursions to provide guests with enriching and enjoyable experiences.', '2025-12-26 23:40:35', '2025-12-26 23:40:35'),
(216, 15, 76, 'Travel Coordination', 'Arrange travel logistics, including transportation and accommodation, for guests to ensure seamless travel experiences.', '2025-12-26 23:40:35', '2025-12-26 23:40:35'),
(217, 15, 78, 'Spa and Wellness Services', 'Provide wellness services, including spa treatments, fitness programs, and wellness consultations to promote relaxation and health.', '2025-12-26 23:41:16', '2025-12-26 23:41:16'),
(218, 15, 78, 'Sustainability and Eco-tourism', 'Implement sustainable practices and eco-friendly initiatives to promote environmental conservation and attract eco-conscious travelers.', '2025-12-26 23:41:16', '2025-12-26 23:41:16'),
(219, 15, 79, 'Revenue Management', 'Optimize pricing strategies and manage inventory to maximize revenue and occupancy rates.', '2025-12-26 23:41:53', '2025-12-26 23:41:53'),
(220, 15, 79, 'Quality Assurance', 'Monitor and evaluate service quality to ensure standards are met and identify areas for improvement.', '2025-12-26 23:41:53', '2025-12-26 23:41:53'),
(221, 16, 80, 'Crop Science', 'Research and develop methods to improve crop yield, quality, and resistance to pests and diseases.', '2025-12-26 23:43:57', '2025-12-26 23:43:57'),
(222, 16, 80, 'Soil Science', 'Study soil properties and develop practices to enhance soil health and fertility for sustainable agriculture.', '2025-12-26 23:43:57', '2025-12-26 23:43:57'),
(223, 16, 80, 'Animal Science', 'Conduct research on animal health, nutrition, and breeding to improve livestock production and welfare.', '2025-12-26 23:43:57', '2025-12-26 23:43:57'),
(224, 16, 80, 'Plant Breeding and Genetics', 'Develop new plant varieties with improved traits through genetic research and breeding programs.', '2025-12-26 23:43:57', '2025-12-26 23:43:57'),
(225, 16, 80, 'Agroecology', 'Study ecological processes applied to agricultural production systems to promote biodiversity and sustainability.', '2025-12-26 23:43:57', '2025-12-26 23:43:57'),
(226, 16, 81, 'Sustainable Agriculture', 'Develop and promote sustainable farming practices that minimize environmental impact and conserve resources.', '2025-12-26 23:45:21', '2025-12-26 23:45:21'),
(227, 16, 81, 'Water Resource Management', 'Develop and implement strategies for efficient water use and management in agriculture.', '2025-12-26 23:45:21', '2025-12-26 23:45:21'),
(228, 16, 81, 'Climate Resilience', 'Develop strategies and practices to help agriculture adapt to and mitigate the effects of climate change.', '2025-12-26 23:45:21', '2025-12-26 23:45:21'),
(229, 16, 81, 'Agroforestry', 'Integrate trees and shrubs into agricultural landscapes to improve biodiversity, soil health, and productivity.', '2025-12-26 23:45:21', '2025-12-26 23:45:21'),
(230, 16, 82, 'Food Safety and Quality', 'Ensure the safety and quality of food products through rigorous testing, monitoring, and compliance with standards.', '2025-12-26 23:46:35', '2025-12-26 23:46:35'),
(231, 16, 82, 'Food Processing and Technology', 'Innovate and improve methods for processing, packaging, and preserving food to enhance shelf life and nutritional value.', '2025-12-26 23:46:35', '2025-12-26 23:46:35'),
(232, 16, 82, 'Nutrition Science', 'Research and develop nutritional guidelines and products to improve public health and nutrition.', '2025-12-26 23:46:35', '2025-12-26 23:46:35'),
(233, 16, 82, 'Biotechnology', 'Apply biotechnological techniques to enhance agricultural production and food quality.', '2025-12-26 23:46:35', '2025-12-26 23:46:35'),
(234, 16, 83, 'Extension Services', 'Provide education and resources to farmers and the public on best practices in agriculture and food production.', '2025-12-26 23:47:20', '2025-12-26 23:47:20'),
(235, 16, 83, 'Pest and Disease Management', 'Research and develop integrated pest and disease management strategies to protect crops and livestock.', '2025-12-26 23:47:20', '2025-12-26 23:47:20'),
(236, 16, 84, 'Food Policy and Advocacy', 'Work on policy development and advocacy to promote food security, sustainable agriculture, and nutrition improvements.', '2025-12-26 23:48:05', '2025-12-26 23:48:05'),
(237, 16, 84, 'Farming Systems Research', 'Study and improve whole farming systems to enhance their efficiency, sustainability, and resilience.', '2025-12-26 23:48:05', '2025-12-26 23:48:05'),
(238, 17, 136, 'Fleet Management', 'Oversee the maintenance, operation, and optimization of the company\'s transportation fleet to ensure efficient and reliable service.', '2025-12-27 14:39:39', '2025-12-27 14:39:39'),
(239, 17, 136, 'Vehicle Maintenance', 'Conduct regular maintenance and repairs on vehicles to ensure they are in optimal working condition and safe for use.', '2025-12-27 14:39:39', '2025-12-27 14:39:39'),
(240, 17, 137, 'Logistics Coordination', 'Plan and coordinate the movement of goods, managing routes, schedules, and transportation methods to optimize delivery efficiency.', '2025-12-27 14:39:39', '2025-12-27 14:39:39'),
(241, 17, 137, 'Freight Management', 'Oversee the transportation of freight, including coordination with carriers, tracking shipments, and managing logistics.', '2025-12-27 14:39:39', '2025-12-27 14:39:39'),
(242, 17, 137, 'Intermodal Transportation', 'Coordinate and manage the use of multiple modes of transportation (e.g., truck, rail, ship) to move goods efficiently.', '2025-12-27 14:39:39', '2025-12-27 14:39:39'),
(243, 17, 138, 'Transportation Planning', 'Develop and implement transportation strategies and plans to improve the movement of people and goods.', '2025-12-27 14:39:39', '2025-12-27 14:39:39'),
(244, 17, 138, 'Route Optimization', 'Analyze and optimize transportation routes to reduce travel time, fuel consumption, and costs.', '2025-12-27 14:39:39', '2025-12-27 14:39:39'),
(245, 17, 138, 'Traffic Management', 'Monitor and manage traffic flow to reduce congestion and improve transportation efficiency.', '2025-12-27 14:39:39', '2025-12-27 14:39:39'),
(246, 17, 139, 'Sustainability and Emissions Reduction', 'Implement initiatives and technologies to reduce transportation emissions and promote environmentally friendly practices.', '2025-12-27 14:39:39', '2025-12-27 14:39:39'),
(247, 17, 139, 'Safety and Compliance', 'Ensure that all transportation and logistics operations comply with safety regulations and standards, minimizing risks.', '2025-12-27 14:39:39', '2025-12-27 14:39:39'),
(248, 17, 140, 'Warehousing and Distribution', 'Manage warehouse operations, including storage, inventory control, and distribution of goods to ensure timely delivery.', '2025-12-27 14:39:39', '2025-12-27 14:39:39'),
(249, 17, 141, 'Training and Development', 'Provide training programs for drivers and logistics personnel to enhance their skills and knowledge.', '2025-12-27 14:39:39', '2025-12-27 14:39:39'),
(250, 17, 141, 'Customs and Border Control', 'Handle customs procedures and ensure compliance with regulations for international shipments.', '2025-12-27 14:39:39', '2025-12-27 14:39:39'),
(251, 17, 141, 'Emergency Response and Contingency Planning', 'Develop and implement plans to handle transportation emergencies and disruptions.', '2025-12-27 14:39:39', '2025-12-27 14:39:39'),
(252, 17, 142, 'Data Analytics and Reporting', 'Analyze transportation and logistics data to inform decision-making and improve operational performance.', '2025-12-27 14:39:39', '2025-12-27 14:39:39'),
(253, 18, 143, 'Program Development and Management', 'Design, implement, and oversee programs and initiatives that address specific societal issues and meet community needs.', '2025-12-27 14:47:15', '2025-12-27 14:47:15'),
(254, 18, 143, 'Social Services Delivery', 'Provide direct services and support to individuals and communities in need, including case management, counseling, and resource distribution.', '2025-12-27 14:47:15', '2025-12-27 14:47:15'),
(255, 18, 143, 'Education and Training', 'Develop and deliver educational programs and training sessions to empower individuals and communities with knowledge and skills.', '2025-12-27 14:47:15', '2025-12-27 14:47:15'),
(256, 18, 144, 'Fundraising and Development', 'Plan and execute fundraising campaigns, events, and grant applications to secure financial support for the organization’s mission.', '2025-12-27 14:47:15', '2025-12-27 14:47:15'),
(257, 18, 144, 'Grant Writing and Management', 'Write and manage grant applications to secure funding from foundations, government agencies, and other sources.', '2025-12-27 14:47:15', '2025-12-27 14:47:15'),
(258, 18, 145, 'Community Outreach and Engagement', 'Build and maintain relationships with community members, organizations, and stakeholders to promote the organization\'s work and gather support.', '2025-12-27 14:47:15', '2025-12-27 14:47:15');
INSERT INTO `sub_departments` (`id`, `industry_id`, `department_id`, `name`, `details`, `created_at`, `updated_at`) VALUES
(259, 18, 145, 'Volunteer Coordination', 'Recruit, train, and manage volunteers to support the organization’s programs and events.', '2025-12-27 14:47:15', '2025-12-27 14:47:15'),
(260, 18, 145, 'Membership Services', 'Manage and engage with the organization\'s members, ensuring their needs are met and encouraging active participation.', '2025-12-27 14:47:15', '2025-12-27 14:47:15'),
(261, 18, 146, 'Advocacy and Policy', 'Advocate for policy changes and initiatives that support the organization’s mission, engaging with policymakers and the public.', '2025-12-27 14:47:15', '2025-12-27 14:47:15'),
(262, 18, 146, 'Partnership Development', 'Build and maintain partnerships with other organizations, businesses, and institutions to enhance the organization’s reach and effectiveness.', '2025-12-27 14:47:15', '2025-12-27 14:47:15'),
(263, 18, 147, 'Communications and Outreach', 'Develop and disseminate informational materials, manage the organization’s online presence, and engage with media to raise awareness about the organization\'s work.', '2025-12-27 14:47:15', '2025-12-27 14:47:15'),
(264, 18, 147, 'Event Planning and Coordination', 'Organize and execute events, such as community meetings, awareness campaigns, and fundraising activities.', '2025-12-27 14:47:15', '2025-12-27 14:47:15'),
(265, 18, 148, 'Monitoring and Evaluation', 'Track and assess the effectiveness and impact of the organization’s programs and initiatives to ensure they meet their goals and objectives.', '2025-12-27 14:47:15', '2025-12-27 14:47:15'),
(266, 18, 148, 'Research and Data Analysis', 'Conduct research and analyze data to inform the organization’s strategies, programs, and advocacy efforts.', '2025-12-27 14:47:15', '2025-12-27 14:47:15'),
(267, 18, 149, 'Emergency Relief and Disaster Response', 'Coordinate and provide emergency relief services and support in response to disasters and crises.', '2025-12-27 14:47:15', '2025-12-27 14:47:15'),
(268, 19, 188, 'Behavioral Research', 'Investigate human behavior using interdisciplinary methods like psychology, economics, and sociology to understand decision-making and societal trends.', '2025-12-27 15:00:36', '2025-12-27 15:00:36'),
(269, 19, 188, 'Quantitative Analysis', 'Employ statistical tools and models to analyze data collected from surveys and experiments, revealing patterns in behavior and social dynamics.', '2025-12-27 15:00:36', '2025-12-27 15:00:36'),
(270, 19, 188, 'Behavioral Economics', 'Study the psychological factors behind economic decisions, focusing on how individuals and groups act under conditions of uncertainty and social influence.', '2025-12-27 15:00:36', '2025-12-27 15:00:36'),
(271, 19, 189, 'Sociological Research', 'Explore social structures and institutions, analyzing how class, gender, ethnicity, and social norms influence human behavior and interactions.', '2025-12-27 15:00:36', '2025-12-27 15:00:36'),
(272, 19, 189, 'Cultural Anthropology', 'Study the cultural practices and traditions of various societies, providing deep insights into societal evolution and human cultural diversity.', '2025-12-27 15:00:36', '2025-12-27 15:00:36'),
(273, 19, 189, 'Ethnography', 'Conduct fieldwork to document and analyze the daily lives and practices of different communities, often using immersive observation methods.', '2025-12-27 15:00:36', '2025-12-27 15:00:36'),
(274, 19, 190, 'Policy Analysis', 'Evaluate and assess social policies and programs, using research insights to recommend improvements and predict their impact on societal well-being.', '2025-12-27 15:00:36', '2025-12-27 15:00:36'),
(275, 19, 190, 'Ethical Review', 'Evaluate and assess social policies and programs, using research insights to recommend improvements and predict their impact on societal well-being.', '2025-12-27 15:00:36', '2025-12-27 15:00:36'),
(276, 19, 190, 'Regulatory Compliance', 'Monitor and enforce adherence to legal and ethical standards in social research, ensuring all projects meet necessary regulatory requirements.', '2025-12-27 15:00:36', '2025-12-27 15:00:36'),
(277, 19, 191, 'Community Partnership Development', 'Build and nurture relationships with community stakeholders, facilitating data collection, collaboration, and implementation of socially impactful projects.', '2025-12-27 15:00:36', '2025-12-27 15:00:36'),
(278, 19, 191, 'Cultural Consultancy', 'Provide expert advice on cultural sensitivity, ensuring that communication strategies, marketing, and policy implementation align with the cultural contexts of target groups.', '2025-12-27 15:00:36', '2025-12-27 15:00:36'),
(279, 19, 191, 'Public Outreach and Education', 'Engage the public through educational programs and campaigns, raising awareness on social issues and promoting community-driven change.', '2025-12-27 15:00:36', '2025-12-27 15:00:36'),
(280, 19, 192, 'Data Analysis and Visualization', 'Process and interpret large datasets from social research, creating visual representations to highlight key patterns in human behavior and societal changes.', '2025-12-27 15:00:36', '2025-12-27 15:00:36'),
(281, 19, 192, 'Media and Communication Research', 'Examine the role of media, language, and communication technologies in shaping public opinion, cultural narratives, and social interactions.', '2025-12-27 15:00:36', '2025-12-27 15:00:36'),
(282, 19, 192, 'Information Dissemination', 'Develop strategies for sharing research findings with broader audiences, using both traditional and digital media to maximize impact and engagement.', '2025-12-27 15:00:36', '2025-12-27 15:00:36'),
(283, 20, 182, 'Environmental Impact Assessment', 'Evaluates the environmental effects of energy projects, ensuring sustainability and adherence to environmental regulations.', '2025-12-27 15:07:08', '2025-12-27 15:07:08'),
(284, 20, 182, 'Sustainability Reporting', 'Collects data on environmental and social impacts, producing transparent reports to stakeholders on sustainability initiatives and outcomes.', '2025-12-27 15:07:08', '2025-12-27 15:07:08'),
(285, 20, 182, 'Environmental Health and Safety (EHS)', 'Develops and enforces safety protocols and environmental practices, reducing risk and promoting eco-friendly operations.', '2025-12-27 15:07:08', '2025-12-27 15:07:08'),
(286, 20, 183, 'Solar and Wind Energy Engineering', 'Designs and implements renewable energy projects, with a focus on reducing reliance on non-renewable sources like fossil fuels.', '2025-12-27 15:07:08', '2025-12-27 15:07:08'),
(287, 20, 183, 'Energy Efficiency Analysis', 'Analyzes energy consumption patterns and designs strategies for reducing energy waste and promoting conservation.', '2025-12-27 15:07:08', '2025-12-27 15:07:08'),
(288, 20, 184, 'Geological Surveying', 'Conducts studies to locate and assess natural resources like oil, gas, and minerals, aiding in sustainable extraction and resource planning.', '2025-12-27 15:07:08', '2025-12-27 15:07:08'),
(289, 20, 184, 'Resource Planning', 'Manages the allocation of energy resources, ensuring sustainable supply chains and responsible resource extraction.', '2025-12-27 15:07:08', '2025-12-27 15:07:08'),
(290, 20, 185, 'Land Use Planning', 'Oversees the allocation and permitting of land for energy projects, ensuring responsible land use in compliance with environmental standards.', '2025-12-27 15:07:08', '2025-12-27 15:07:08'),
(291, 20, 185, 'Hydrology and Water Resource Management', 'Manages water resources to ensure that energy production processes do not negatively affect water ecosystems or local supplies.', '2025-12-27 15:07:08', '2025-12-27 15:07:08'),
(292, 20, 186, 'Energy Trading and Market Analysis', 'Monitors energy market trends, providing insights to optimize energy distribution and manage risks related to supply fluctuations.', '2025-12-27 15:07:08', '2025-12-27 15:07:08'),
(293, 20, 186, 'Energy Efficiency and Conservation', 'Supports energy trading by enhancing energy savings and promoting efficient use within industrial and residential sectors.', '2025-12-27 15:07:08', '2025-12-27 15:07:08'),
(294, 20, 187, 'Site Reclamation', 'Oversees cleanup and rehabilitation of energy production sites, ensuring that land is restored to its natural state post-extraction or project completion.', '2025-12-27 15:07:08', '2025-12-27 15:07:08'),
(295, 20, 187, 'Environmental Remediation', 'Focuses on mitigating environmental damage from energy projects through rehabilitation and sustainable management practices.', '2025-12-27 15:07:08', '2025-12-27 15:07:08'),
(296, 21, 176, 'Process Engineering', 'Designs and optimizes production processes to enhance efficiency, reduce costs, and improve product output.', '2025-12-27 15:11:50', '2025-12-27 15:11:50'),
(297, 21, 176, 'Automation and Robotics', 'Implements and manages automation systems and robotics to streamline production processes and reduce manual errors.', '2025-12-27 15:11:50', '2025-12-27 15:11:50'),
(298, 21, 177, 'Quality Assurance', 'Ensures that manufacturing processes meet required standards through regular audits, compliance checks, and process improvements.', '2025-12-27 15:11:50', '2025-12-27 15:11:50'),
(299, 21, 177, 'Quality Control', 'Monitors and inspects products during production to detect defects, ensuring that only high-quality products are delivered.', '2025-12-27 15:11:50', '2025-12-27 15:11:50'),
(300, 21, 177, 'Continuous Improvement', 'Focuses on identifying areas for improvement in manufacturing processes, implementing lean manufacturing principles to reduce waste and increase efficiency.', '2025-12-27 15:11:50', '2025-12-27 15:11:50'),
(301, 21, 178, 'Production Planning and Scheduling', 'Develops and coordinates production schedules, ensuring that manufacturing targets are met within deadlines and resource constraints.', '2025-12-27 15:11:50', '2025-12-27 15:11:50'),
(302, 21, 178, 'Maintenance and Equipment Management', 'Maintains and repairs machinery to minimize downtime, ensuring continuous and smooth production operations.', '2025-12-27 15:11:50', '2025-12-27 15:11:50'),
(303, 21, 179, 'Logistics Coordination', 'Manages the flow of raw materials and finished goods, ensuring efficient transportation and timely delivery of products.', '2025-12-27 15:11:50', '2025-12-27 15:11:50'),
(304, 21, 179, 'Warehousing', 'Oversees the storage, organization, and handling of goods and raw materials to optimize space utilization and ensure proper inventory management.', '2025-12-27 15:11:50', '2025-12-27 15:11:50'),
(305, 21, 180, 'Safety Management', 'Implements safety protocols and ensures compliance with health and environmental regulations, maintaining a safe working environment for all employees.', '2025-12-27 15:11:50', '2025-12-27 15:11:50'),
(306, 21, 180, 'Environmental Sustainability', 'Manages environmental impact reduction initiatives, promoting sustainable practices within the manufacturing process.', '2025-12-27 15:11:50', '2025-12-27 15:11:50'),
(307, 21, 181, 'Production Supervisors', 'Oversee day-to-day manufacturing activities, ensuring that production targets, safety standards, and quality benchmarks are consistently met.', '2025-12-27 15:11:50', '2025-12-27 15:11:50'),
(308, 22, 170, 'Merchandising', 'Selects and manages the product assortment, ensuring it aligns with consumer demand while optimizing product displays to enhance the shopping experience.', '2025-12-27 15:16:52', '2025-12-27 15:16:52'),
(309, 22, 170, 'Inventory Management', 'Tracks and manages stock levels to ensure product availability and prevent overstock or shortages.', '2025-12-27 15:16:52', '2025-12-27 15:16:52'),
(310, 22, 170, 'Category Management', 'Analyzes product categories to make data-driven decisions on pricing, promotions, and inventory levels, optimizing profitability for each category.', '2025-12-27 15:16:52', '2025-12-27 15:16:52'),
(311, 22, 171, 'Website Management', 'Oversees the e-commerce platform\'s functionality and performance, ensuring a smooth and engaging user experience for online shoppers.', '2025-12-27 15:16:52', '2025-12-27 15:16:52'),
(312, 22, 171, 'User Experience (UX) Design', 'Optimizes the user interface for ease of navigation, ensuring intuitive design and customer satisfaction across digital channels.', '2025-12-27 15:16:52', '2025-12-27 15:16:52'),
(313, 22, 172, 'Order Fulfillment', 'Manages the order process from purchase to delivery, ensuring accurate and timely processing of orders.', '2025-12-27 15:16:52', '2025-12-27 15:16:52'),
(314, 22, 172, 'Shipping and Delivery Management', 'Coordinates logistics and carriers to ensure efficient, timely deliveries and cost-effective shipping solutions for customers.', '2025-12-27 15:16:52', '2025-12-27 15:16:52'),
(315, 22, 173, 'Store Operations', 'Manages day-to-day activities of physical stores, ensuring smooth store performance, staff coordination, and product availability to enhance the in-store experience.', '2025-12-27 15:16:52', '2025-12-27 15:16:52'),
(316, 22, 173, 'Visual Merchandising', 'Designs and implements in-store displays, creating visually appealing environments that attract customers.', '2025-12-27 15:16:52', '2025-12-27 15:16:52'),
(317, 22, 173, 'Omnichannel Integration', 'Aligns both online and offline shopping experiences, ensuring a seamless and integrated customer journey across all channels.', '2025-12-27 15:16:52', '2025-12-27 15:16:52'),
(318, 22, 174, 'Data Analytics', 'Collects and analyzes data on customer behavior, sales trends, and platform performance to drive informed decision-making.', '2025-12-27 15:16:52', '2025-12-27 15:16:52'),
(319, 22, 174, 'Consumer Insights', 'Gathers and interprets customer feedback and preferences to guide product selection, pricing, and improve the shopping experience.', '2025-12-27 15:16:52', '2025-12-27 15:16:52'),
(320, 22, 175, 'Vendor Relations', 'Manages supplier relationships, ensuring timely product deliveries and negotiating terms to meet customer demand and optimize supply chain efficiency.', '2025-12-27 15:16:52', '2025-12-27 15:16:52'),
(321, 23, 164, 'Architectural Design', 'Develops building designs that meet functional, aesthetic, and regulatory standards, ensuring the project’s viability and compliance with local codes.', '2025-12-27 15:28:17', '2025-12-27 15:28:17'),
(322, 23, 164, 'Civil and Structural Engineering', 'Designs infrastructure and ensures the structural integrity of buildings and other developments, focusing on durability and safety in alignment with the architectural vision.', '2025-12-27 15:28:17', '2025-12-27 15:28:17'),
(323, 23, 165, 'Construction Supervision', 'Oversees the execution of construction projects, ensuring adherence to timelines, budgets, and quality standards while coordinating teams on-site.', '2025-12-27 15:28:17', '2025-12-27 15:28:17'),
(324, 23, 165, 'Safety Management', 'Implements and monitors safety protocols to ensure compliance with health and safety regulations on construction sites, minimizing accidents and protecting workers.', '2025-12-27 15:28:17', '2025-12-27 15:28:17'),
(325, 23, 166, 'Urban Planning', 'Designs land-use strategies to develop sustainable communities, ensuring a balance between residential, commercial, and public spaces.', '2025-12-27 15:28:17', '2025-12-27 15:28:17'),
(326, 23, 166, 'Land Development', 'Prepares and improves land for construction, ensuring environmental compliance, proper zoning, and infrastructure readiness.', '2025-12-27 15:28:17', '2025-12-27 15:28:17'),
(327, 23, 167, 'Property and Facility Management', 'Manages the operation, maintenance, and leasing of real estate assets, ensuring properties are well-maintained, profitable, and functional for long-term use.', '2025-12-27 15:28:17', '2025-12-27 15:28:17'),
(328, 23, 168, 'Environmental Sustainability', 'Ensures that projects follow green building practices and comply with environmental regulations, promoting energy efficiency and reducing ecological impacts.', '2025-12-27 15:28:17', '2025-12-27 15:28:17'),
(329, 23, 168, 'Energy Efficiency Planning', 'Integrates sustainable materials and energy-saving technologies into building designs to minimize energy consumption and support eco-friendly initiatives.', '2025-12-27 15:28:17', '2025-12-27 15:28:17'),
(330, 23, 169, 'Site Acquisition', 'Identifies and negotiates the purchase or lease of land for development, securing strategic locations for new construction.', '2025-12-27 15:28:17', '2025-12-27 15:28:17'),
(331, 23, 169, 'Zoning and Permitting', 'Handles the necessary legal approvals, permits, and zoning requirements for construction projects, ensuring regulatory compliance throughout the development process.', '2025-12-27 15:28:17', '2025-12-27 15:28:17'),
(332, 24, 156, 'Network Design and Engineering', 'Designs, builds, and maintains the telecommunications infrastructure, ensuring efficient connectivity and optimal network performance.', '2025-12-27 15:32:41', '2025-12-27 15:32:41'),
(333, 24, 156, 'Fiber Optic and Cabling Management', 'Manages the design and deployment of fiber optic and cabling systems to ensure high-speed data transmission and robust network infrastructure.', '2025-12-27 15:32:41', '2025-12-27 15:32:41'),
(334, 24, 157, 'Field Operations', 'Provides on-site support for the installation, maintenance, and repair of telecommunications equipment, ensuring service continuity and quick resolution of issues.', '2025-12-27 15:32:41', '2025-12-27 15:32:41'),
(335, 24, 157, 'Network Maintenance', 'Monitors and performs routine maintenance on network infrastructure to ensure operational efficiency and minimal downtime.', '2025-12-27 15:32:41', '2025-12-27 15:32:41'),
(336, 24, 158, 'Network Traffic Analysis', 'Monitors and manages data traffic to optimize network performance, manage congestion, and ensure users have a smooth experience.', '2025-12-27 15:32:41', '2025-12-27 15:32:41'),
(337, 24, 158, 'Data Management', 'Ensures secure and efficient handling of user and service data, maintaining data integrity and supporting network optimization.', '2025-12-27 15:32:41', '2025-12-27 15:32:41'),
(338, 24, 159, 'Spectrum Allocation', 'Manages the allocation of radio frequencies to prevent interference and ensure seamless communication across wireless networks.', '2025-12-27 15:32:41', '2025-12-27 15:32:41'),
(339, 24, 159, 'Wireless Network Operations', 'Oversees the management and optimization of wireless networks, including cellular towers and related technologies.', '2025-12-27 15:32:41', '2025-12-27 15:32:41'),
(340, 24, 160, 'Cybersecurity', 'Implements security measures to protect the telecommunications network from cyber threats, ensuring data integrity and safe communications.', '2025-12-27 15:32:41', '2025-12-27 15:32:41'),
(341, 24, 160, 'Risk Management', 'Identifies potential vulnerabilities and risks to the network, creating strategies to mitigate operational disruptions and ensure regulatory compliance.', '2025-12-27 15:32:41', '2025-12-27 15:32:41'),
(342, 24, 161, 'Service Activation', 'Manages the setup and activation of new telecom services, ensuring that services are configured correctly for customers and operational within expected timelines.', '2025-12-27 15:32:41', '2025-12-27 15:32:41'),
(343, 24, 161, 'Service Provisioning', 'Oversees the integration of new services into the network, ensuring alignment with existing infrastructure and capabilities.', '2025-12-27 15:32:41', '2025-12-27 15:32:41'),
(344, 24, 162, 'Infrastructure Deployment', 'Coordinates the rollout of new network infrastructure, including towers, cables, and hardware, to expand coverage and enhance network capacity.', '2025-12-27 15:32:41', '2025-12-27 15:32:41'),
(345, 24, 162, 'Satellite and Remote Communications', 'Manages satellite communication systems and supports remote connectivity to extend communication services globally.', '2025-12-27 15:32:41', '2025-12-27 15:32:41'),
(346, 24, 163, 'Regulatory Compliance', 'Ensures adherence to national and international telecommunications regulations, managing licenses, and coordinating with government and regulatory agencies.', '2025-12-27 15:32:41', '2025-12-27 15:32:41'),
(347, 25, 150, 'Aerospace Design and Engineering', 'Develops advanced aircraft, spacecraft, and defense systems, ensuring they meet safety, performance, and mission requirements.', '2025-12-27 15:37:44', '2025-12-27 15:37:44'),
(348, 25, 150, 'Systems Integration and Testing', 'Integrates various subsystems and components, conducting rigorous testing to verify performance and ensure all systems work together seamlessly.', '2025-12-27 15:37:44', '2025-12-27 15:37:44'),
(349, 25, 151, 'Flight Operations and Testing', 'Oversees flight readiness and performs controlled flight tests to ensure aircraft and spacecraft meet operational and safety standards.', '2025-12-27 15:37:44', '2025-12-27 15:37:44'),
(350, 25, 151, 'Space Systems and Mission Planning', 'Develops space systems and plans missions, managing everything from satellite deployment to deep space exploration with technical and strategic alignment.', '2025-12-27 15:37:44', '2025-12-27 15:37:44'),
(351, 25, 152, 'Defense Systems Engineering', 'Designs, develops, and maintains advanced defense systems, including missile technologies, radar, and military-grade security solutions.', '2025-12-27 15:37:44', '2025-12-27 15:37:44'),
(352, 25, 152, 'Cybersecurity', 'Protects defense and aerospace technologies from cyber threats by implementing robust security measures to safeguard critical data and operations.', '2025-12-27 15:37:44', '2025-12-27 15:37:44'),
(353, 25, 153, 'Advanced Manufacturing and Fabrication', 'Produces high-precision components and systems for aerospace and defense technologies, ensuring parts are fabricated and assembled to exacting standards.', '2025-12-27 15:37:44', '2025-12-27 15:37:44'),
(354, 25, 153, 'Aerodynamics and Propulsion', 'Focuses on the design of aerodynamics and propulsion systems, including jet and rocket engines, ensuring efficient movement and propulsion through air and space.', '2025-12-27 15:37:44', '2025-12-27 15:37:44'),
(355, 25, 154, 'Quality Assurance and Compliance', 'Ensures all aerospace and defense systems meet regulatory and quality standards through audits, inspections, and testing, while managing certifications and regulatory compliance.', '2025-12-27 15:37:44', '2025-12-27 15:37:44'),
(356, 25, 155, 'Satellite and Communication Systems', 'Manages the design, launch, and operation of satellite systems, developing secure communication technologies for aerospace and defense.', '2025-12-27 15:37:44', '2025-12-27 15:37:44'),
(357, 25, 155, 'Missile and Weapon Systems', 'Designs and tests advanced weaponry such as guided missiles and precision strike technologies, ensuring they meet defense objectives and performance standards.', '2025-12-27 15:37:44', '2025-12-27 15:37:44'),
(358, 27, 122, 'Clinical Trials Management', 'Designs, conducts, and oversees clinical trials to test the safety and efficacy of new drugs in human subjects, ensuring regulatory and ethical compliance.', '2025-12-27 15:42:02', '2025-12-27 15:42:02'),
(359, 27, 122, 'Preclinical Research', 'Conducts toxicology and pharmacology studies on animals or cellular models to assess drug safety and effectiveness before advancing to clinical trials.', '2025-12-27 15:42:02', '2025-12-27 15:42:02'),
(360, 27, 123, 'Regulatory Strategy and Compliance', 'Manages drug applications and ensures all products adhere to regulatory standards throughout their lifecycle.', '2025-12-27 15:42:02', '2025-12-27 15:42:02'),
(361, 27, 123, 'Pharmacovigilance (Drug Safety Monitoring)', 'Monitors drug safety post-launch by collecting data on adverse effects and ensuring compliance with safety regulations.', '2025-12-27 15:42:02', '2025-12-27 15:42:02'),
(362, 27, 124, 'Medical Science Liaison (MSL):', 'Acts as the primary point of contact between the company and healthcare professionals, sharing clinical insights and supporting product usage.', '2025-12-27 15:42:02', '2025-12-27 15:42:02'),
(363, 27, 124, 'Medical Communications', 'Disseminates accurate scientific and clinical data to internal teams and healthcare providers to support informed therapeutic decisions.', '2025-12-27 15:42:02', '2025-12-27 15:42:02'),
(364, 27, 125, 'Quality Assurance (QA)', 'Ensures that all products meet high-quality standards through systematic audits, inspections, and oversight during manufacturing and research.', '2025-12-27 15:42:02', '2025-12-27 15:42:02'),
(365, 27, 125, 'Quality Control (QC)', 'Conducts tests on pharmaceutical products at different development stages to confirm compliance with predefined quality specifications.', '2025-12-27 15:42:02', '2025-12-27 15:42:02'),
(366, 27, 126, 'Biotech Manufacturing', 'Oversees the production of pharmaceutical and biotech therapies, ensuring consistency, safety, and efficiency in manufacturing processes.', '2025-12-27 15:42:02', '2025-12-27 15:42:02'),
(367, 27, 126, 'Process Development', 'Focuses on optimizing and scaling up manufacturing processes to ensure higher output while maintaining quality.', '2025-12-27 15:42:02', '2025-12-27 15:42:02'),
(368, 27, 127, 'Lab Management', 'Ensures laboratories are equipped, maintained, and compliant with safety standards to support ongoing research and testing efforts.', '2025-12-27 15:42:02', '2025-12-27 15:42:02'),
(369, 27, 127, 'Research Operations', 'Supports day-to-day research activities, ensuring that all laboratory work aligns with project timelines and quality standards.', '2025-12-27 15:42:02', '2025-12-27 15:42:02'),
(370, 27, 128, 'IP Management and Patents', 'Secures patents and manages intellectual property rights for the company’s biotechnological and pharmaceutical innovations, ensuring competitive advantage.', '2025-12-27 15:42:02', '2025-12-27 15:42:02'),
(371, 26, 129, 'Automotive and Body Design', 'Develops vehicle designs with a focus on functionality, safety, aerodynamics, and aesthetics, ensuring that vehicles are visually appealing and meet regulatory requirements.', '2025-12-27 15:48:52', '2025-12-27 15:48:52'),
(372, 26, 129, 'Chassis and Structural Engineering', 'Designs the vehicle\'s chassis and structural components, ensuring durability, safety, and high performance in different conditions.', '2025-12-27 15:48:52', '2025-12-27 15:48:52'),
(373, 26, 130, 'Powertrain Engineering', 'Develops the engine, transmission, and drivetrain components that power the vehicle, focusing on performance, fuel efficiency, and emissions reduction.', '2025-12-27 15:48:52', '2025-12-27 15:48:52'),
(374, 26, 130, 'Electric Vehicle (EV) Systems Engineering', 'Designs and optimizes electric vehicle components, including battery technology and electric motors, focusing on energy management and sustainability.', '2025-12-27 15:48:52', '2025-12-27 15:48:52'),
(375, 26, 131, 'ADAS Development', 'Designs and integrates advanced driver assistance systems like automatic braking, lane-keeping, and collision avoidance to enhance safety and driving experience.', '2025-12-27 15:48:52', '2025-12-27 15:48:52'),
(376, 26, 131, 'Autonomous Vehicle Engineering', 'Develops self-driving technologies, working on algorithms, sensors, and hardware to advance autonomous vehicle capabilities.', '2025-12-27 15:48:52', '2025-12-27 15:48:52'),
(377, 26, 132, 'Testing and Validation', 'Conducts crash tests, road tests, and environmental assessments on prototypes to ensure that vehicles meet performance, durability, and safety standards.', '2025-12-27 15:48:52', '2025-12-27 15:48:52'),
(378, 26, 133, 'Manufacturing Engineering and Assembly', 'Oversees the production and assembly of vehicles, ensuring quality and efficiency through optimized production lines and the use of advanced manufacturing technologies.', '2025-12-27 15:48:52', '2025-12-27 15:48:52'),
(379, 26, 134, 'Quality Assurance', 'Implements rigorous inspection processes to ensure that all components and finished vehicles meet high safety and performance standards.', '2025-12-27 15:48:52', '2025-12-27 15:48:52'),
(380, 26, 134, 'Vehicle Dynamics and Performance', 'Focuses on optimizing vehicle handling, stability, braking, and overall driving performance to create a smooth and reliable driving experience.', '2025-12-27 15:48:52', '2025-12-27 15:48:52'),
(381, 26, 135, 'Sustainability and Environmental Systems', 'Develops eco-friendly materials, promotes energy-efficient technologies, and incorporates sustainable manufacturing processes to minimize the environmental impact of vehicles.', '2025-12-27 15:48:52', '2025-12-27 15:48:52'),
(382, 28, 117, 'Policy Analysis and Development', 'Researches, develops, and implements public policies that address societal needs, ensuring alignment with legal frameworks and public interests.', '2025-12-27 15:56:29', '2025-12-27 15:56:29'),
(383, 28, 117, 'Regulatory Compliance and Public Oversight', 'Oversees the enforcement of public policies, ensuring industries and public sectors comply with regulations, and monitors public service delivery.', '2025-12-27 15:56:29', '2025-12-27 15:56:29'),
(384, 28, 118, 'Public Programs and Services', 'Manages the provision of essential public services, including healthcare, education, and welfare programs, to ensure citizens receive efficient and accessible services.', '2025-12-27 15:56:29', '2025-12-27 15:56:29'),
(385, 28, 118, 'Infrastructure and Transportation Planning', 'Oversees the planning, development, and maintenance of public infrastructure and transportation systems to meet community needs and support economic growth.', '2025-12-27 15:56:29', '2025-12-27 15:56:29'),
(386, 28, 119, 'Urban Development and Zoning', 'Develops land-use plans and oversees urban growth to ensure sustainable and well-balanced development within communities.', '2025-12-27 15:56:29', '2025-12-27 15:56:29'),
(387, 28, 119, 'Environmental and Natural Resource Management', 'Implements policies focused on environmental conservation and sustainable management of natural resources like water, forests, and minerals.', '2025-12-27 15:56:29', '2025-12-27 15:56:29'),
(388, 28, 120, 'Public Health Management', 'Develops and coordinates programs to protect and promote public health, preventing diseases and responding to public health emergencies.', '2025-12-27 15:56:29', '2025-12-27 15:56:29'),
(389, 28, 120, 'Emergency Services and Public Safety', 'Manages disaster response, emergency preparedness, and public safety services such as law enforcement, fire protection, and first responders.', '2025-12-27 15:56:29', '2025-12-27 15:56:29'),
(390, 28, 121, 'Community Outreach and Engagement', 'Engages citizens and community stakeholders to gather input on public policies, ensure transparency, and involve them in government decision-making.', '2025-12-27 15:56:29', '2025-12-27 15:56:29'),
(391, 28, 121, 'Economic Policy and Development', 'Designs and implements programs that foster economic growth, attract investment, and create jobs to improve the community’s economic standing.', '2025-12-27 15:56:29', '2025-12-27 15:56:29'),
(392, 29, 109, 'Content Development', 'Creates original programming across various formats, ensuring content aligns with audience preferences and company goals.', '2025-12-27 16:01:43', '2025-12-27 16:01:43'),
(393, 29, 109, 'Creative Direction', 'Provides artistic guidance, overseeing elements like scriptwriting, visual design, and storyboarding to ensure cohesive storytelling across all media projects.', '2025-12-27 16:01:43', '2025-12-27 16:01:43'),
(394, 29, 110, 'Production Management', 'Manages all aspects of physical content production, including filming, set design, and coordinating technical crews to bring creative concepts to life.', '2025-12-27 16:01:43', '2025-12-27 16:01:43'),
(395, 29, 110, 'Post-Production', 'Handles editing, visual effects, sound mixing, and color grading, ensuring that the final product meets creative and technical standards.', '2025-12-27 16:01:43', '2025-12-27 16:01:43'),
(396, 29, 111, 'Editorial Team', 'Curates and edits content to ensure it meets quality and consistency standards, aligning with the company’s mission and audience needs.', '2025-12-27 16:01:43', '2025-12-27 16:01:43'),
(397, 29, 111, 'Programming and Scheduling', 'Plans the timing and placement of content across platforms, optimizing for audience engagement and ratings.', '2025-12-27 16:01:43', '2025-12-27 16:01:43'),
(398, 29, 112, 'Broadcast Operations', 'Manages the technical aspects of broadcasting across TV, radio, and digital platforms, ensuring smooth and high-quality content transmission.', '2025-12-27 16:01:43', '2025-12-27 16:01:43'),
(399, 29, 112, 'Media Distribution', 'Oversees the distribution of content across various platforms, including streaming services and social media, to maximize audience reach.', '2025-12-27 16:01:43', '2025-12-27 16:01:43'),
(400, 29, 113, 'Casting and Talent Management', 'Sources, hires, and manages talent such as actors, musicians, and hosts, ensuring the right individuals are cast for roles and managed throughout production.', '2025-12-27 16:01:43', '2025-12-27 16:01:43'),
(401, 29, 113, 'Set Design and Art Direction', 'Designs physical sets and oversees the visual style of content, including props, costumes, and lighting, ensuring a cohesive aesthetic.', '2025-12-27 16:01:43', '2025-12-27 16:01:43'),
(402, 29, 114, 'Audience Analytics', 'Collects and analyzes viewership data to understand audience preferences and engagement, providing insights for future content strategies.', '2025-12-27 16:01:43', '2025-12-27 16:01:43'),
(403, 29, 114, 'Content Performance Evaluation', 'Assesses the success of media projects by analyzing feedback, ratings, and reviews, ensuring content aligns with both company goals and audience expectations.', '2025-12-27 16:01:43', '2025-12-27 16:01:43'),
(404, 29, 115, 'Sound Engineering', 'Manages all audio-related aspects, including sound recording, mixing, and post-production, ensuring high-quality audio output for media projects.', '2025-12-27 16:01:43', '2025-12-27 16:01:43'),
(405, 29, 115, 'Music Production', 'Collaborates with composers and sound designers to create music that complements the tone and style of media projects.', '2025-12-27 16:01:43', '2025-12-27 16:01:43'),
(406, 29, 116, 'Licensing and Rights Management', 'Manages intellectual property rights, acquiring and granting licenses for content distribution to various platforms.', '2025-12-27 16:01:43', '2025-12-27 16:01:43'),
(407, 29, 116, 'Syndication Management', 'Oversees the sale and distribution of media content to external platforms and international markets.', '2025-12-27 16:01:43', '2025-12-27 16:01:43'),
(408, 30, 104, '•	Construction Workers, Electricians, and Plumbers', 'Perform specialized tasks in building, electrical work, and plumbing, ensuring that projects meet safety standards, regulations, and design specifications.', '2025-12-27 16:04:07', '2025-12-27 16:04:07'),
(409, 30, 104, 'Field Supervisors', 'Manage on-site work, coordinating tasks among tradespeople and monitoring the progress to ensure timely and accurate completion.', '2025-12-27 16:04:07', '2025-12-27 16:04:07'),
(410, 30, 105, 'Apprenticeship Coordination', 'Manages training and mentorship programs for apprentices, ensuring skill development and progression in their respective trades.', '2025-12-27 16:04:07', '2025-12-27 16:04:07'),
(411, 30, 105, 'Workplace Safety Coordination', 'Oversees the implementation of safety protocols and conducts training, ensuring that all work environments meet health and safety standards to protect workers.', '2025-12-27 16:04:07', '2025-12-27 16:04:07'),
(412, 30, 106, 'Quality Inspectors', 'Inspect completed work, ensuring that construction, electrical, and plumbing services meet industry standards, codes, and client expectations before final delivery.', '2025-12-27 16:04:07', '2025-12-27 16:04:07'),
(413, 30, 107, 'Equipment Technicians', 'Maintain and repair tools, machinery, and vehicles used by tradespeople, ensuring they are operational and safe for use on job sites.', '2025-12-27 16:04:07', '2025-12-27 16:04:07'),
(414, 30, 107, 'Site Logistics Coordinators', 'Manage the transportation and delivery of materials, tools, and equipment to job sites, ensuring efficiency in resource allocation.', '2025-12-27 16:04:07', '2025-12-27 16:04:07'),
(415, 30, 108, 'HVAC Technicians and Welders', 'Provide specialized services in heating, ventilation, air conditioning, and metal fabrication, supporting construction, repair, and industrial projects.', '2025-12-27 16:04:07', '2025-12-27 16:04:07'),
(416, 31, 98, 'Defense Engineering', 'Design and develop advanced military technologies and defense systems to enhance national security capabilities.', '2025-12-27 16:09:23', '2025-12-27 16:09:23'),
(417, 31, 98, 'Weapons Systems', 'Oversee the development, testing, and maintenance of weapons systems to ensure their effectiveness and reliability.', '2025-12-27 16:09:23', '2025-12-27 16:09:23'),
(418, 31, 98, 'Aerospace Engineering', 'Design and manufacture aircraft, satellites, and related systems for military applications and surveillance.', '2025-12-27 16:09:23', '2025-12-27 16:09:23'),
(419, 31, 98, 'Cybersecurity', 'Protect military information systems and networks from cyber threats and ensure the integrity and confidentiality of sensitive data.', '2025-12-27 16:09:23', '2025-12-27 16:09:23'),
(420, 31, 98, 'Communications Systems', 'Develop and maintain secure communication systems to facilitate coordination and information sharing during military operations.', '2025-12-27 16:09:23', '2025-12-27 16:09:23'),
(421, 31, 99, 'Logistics and Support Services', 'Coordinate the transportation, supply, and maintenance of military equipment and personnel to ensure operational readiness.', '2025-12-27 16:09:23', '2025-12-27 16:09:23'),
(422, 31, 99, 'Field Operations Support', 'Provide technical and logistical support to military operations in the field, ensuring efficient and effective mission execution.', '2025-12-27 16:09:23', '2025-12-27 16:09:23'),
(423, 31, 99, 'Explosive Ordnance Disposal (EOD)', 'Safely handle, disarm, and dispose of explosive devices to protect military personnel and civilians.', '2025-12-27 16:09:23', '2025-12-27 16:09:23'),
(424, 31, 99, 'Infrastructure Development', 'Plan, construct, and maintain military bases, facilities, and infrastructure to support operational needs.', '2025-12-27 16:09:23', '2025-12-27 16:09:23'),
(425, 31, 100, 'Intelligence and Analysis', 'Gather, analyze, and disseminate intelligence information to support military operations and strategic decision-making.', '2025-12-27 16:09:23', '2025-12-27 16:09:23'),
(426, 31, 100, 'Surveillance and Reconnaissance', 'Operate and maintain surveillance and reconnaissance systems to gather intelligence and monitor potential threats.', '2025-12-27 16:09:23', '2025-12-27 16:09:23'),
(427, 31, 101, 'Training and Simulation', 'Develop and provide training programs and simulation technologies to prepare military personnel for various operational scenarios.', '2025-12-27 16:09:23', '2025-12-27 16:09:23'),
(428, 31, 101, 'Medical and Health Services', 'Provide medical care, health services, and support to military personnel to ensure their well-being and readiness.', '2025-12-27 16:09:23', '2025-12-27 16:09:23'),
(429, 31, 102, 'Environmental Safety and Compliance', 'Ensure that military operations and facilities adhere to environmental regulations and promote sustainable practices.', '2025-12-27 16:09:23', '2025-12-27 16:09:23'),
(430, 31, 102, 'Peacekeeping Operations', 'Plan and execute peacekeeping missions and humanitarian efforts to promote stability and support international peace.', '2025-12-27 16:09:23', '2025-12-27 16:09:23'),
(431, 31, 103, 'Defense Contract Management', 'Oversee contracts with suppliers and contractors to ensure timely delivery and quality of defense products and services.', '2025-12-27 16:09:23', '2025-12-27 16:09:23'),
(432, 33, 85, 'Patrol and Traffic Enforcement', 'Conducts routine patrols, responds to emergency calls, enforces traffic laws, and manages traffic flow to ensure public safety and reduce accidents in the community.', '2025-12-27 16:15:55', '2025-12-27 16:15:55'),
(433, 33, 86, 'Detective Unit', 'Investigates serious crimes, gathering evidence and working with prosecutors to build cases for court.', '2025-12-27 16:15:55', '2025-12-27 16:15:55'),
(434, 33, 86, 'Special Operations (SWAT and K-9 Unit)', 'Handles high-risk operations such as hostage rescues, counter-terrorism, and utilizes specially trained dogs for tasks like detecting explosives and assisting in apprehensions.', '2025-12-27 16:15:55', '2025-12-27 16:15:55'),
(435, 33, 87, 'Community Outreach and School Resource Officers', 'Engages directly with community members and schools to foster positive relationships, reduce crime, and provide guidance on safety and legal issues.', '2025-12-27 16:15:55', '2025-12-27 16:15:55'),
(436, 33, 88, 'Forensic Science and Crime Scene Investigation (CSI)', 'Collects, analyzes, and processes physical evidence from crime scenes, ensuring the integrity of evidence and supporting criminal investigations.', '2025-12-27 16:15:55', '2025-12-27 16:15:55'),
(437, 33, 89, 'Corrections and Custody Services', 'Manages detention facilities, ensuring the safety and compliance of inmates, and oversees parole and probation services to support offender reintegration into society.', '2025-12-27 16:15:55', '2025-12-27 16:15:55'),
(438, 33, 90, 'Dispatch and 911 Services', 'Receives and processes emergency calls, dispatching officers and first responders to incidents, and coordinating real-time responses.', '2025-12-27 16:15:55', '2025-12-27 16:15:55'),
(439, 33, 91, 'Law Enforcement Training and Internal Investigations', 'Provides training and professional development for officers, while also investigating internal complaints and ensuring ethical standards within the department.', '2025-12-27 16:15:55', '2025-12-27 16:15:55'),
(440, 1, 10, 'Radiology', 'Perform imaging procedures such as X-rays, MRIs, and CT scans to diagnose and monitor medical conditions', '2025-12-28 23:13:34', '2025-12-28 23:13:34'),
(441, 1, 10, 'Laboratory Services', 'Conduct diagnostic tests on patient samples to aid in the diagnosis, treatment, and prevention of diseases.', '2025-12-28 23:13:56', '2025-12-28 23:13:56'),
(442, 1, 10, 'Physiotherapy', 'Assist patients in recovering and rehabilitating from physical injuries or surgeries, improving mobility and function.', '2025-12-28 23:14:12', '2025-12-28 23:14:12'),
(443, 1, 10, 'Nutrition and Dietetics', 'Develop and implement nutritional plans to support patient health, manage chronic diseases, and promote overall wellness.', '2025-12-28 23:14:26', '2025-12-28 23:14:26'),
(444, 1, 10, 'Chiropractic Services', 'Provide spinal adjustments and other manual therapies to diagnose and treat musculoskeletal issues, enhancing patient mobility and reducing pain.', '2025-12-28 23:14:40', '2025-12-28 23:14:40'),
(445, 1, 10, 'Massage Therapy', 'Utilize therapeutic massage techniques to relieve pain, reduce stress, and promote overall well-being.', '2025-12-28 23:15:38', '2025-12-28 23:15:38'),
(446, 1, 10, 'Occupational Therapy', 'Help patients regain and improve their ability to perform daily activities and occupational tasks through therapeutic practices.', '2025-12-28 23:16:20', '2025-12-28 23:16:20'),
(447, 1, 10, 'Speech and Language Therapy', 'Diagnose and treat speech, language, and communication disorders, enhancing communication skills and swallowing abilities.', '2025-12-28 23:16:54', '2025-12-28 23:16:54'),
(448, 1, 11, 'Medical Affairs', 'Ensure the scientific integrity of clinical research and medical information, supporting regulatory compliance and providing medical expertise.', '2025-12-29 07:01:20', '2025-12-29 07:01:20'),
(449, 1, 11, 'Pharmacy Services', 'Manage the dispensing of medications, provide pharmaceutical care, and ensure safe and effective medication use.', '2025-12-29 07:01:36', '2025-12-29 07:01:36'),
(450, 1, 11, 'Clinical Research', 'Conduct clinical trials and research studies to advance medical knowledge and develop new treatments and therapies.', '2025-12-29 07:01:46', '2025-12-29 07:01:46'),
(451, 1, 11, 'Infectious Disease', 'Diagnose, treat, and prevent infectious diseases, providing expertise in epidemiology and infection control.', '2025-12-29 07:01:57', '2025-12-29 07:01:57'),
(452, 1, 11, 'Health Education and Promotion', 'Educate patients and the community on health practices, disease prevention, and healthy lifestyle choices.', '2025-12-29 07:02:09', '2025-12-29 07:02:09'),
(453, 2, 13, 'Database Administration', 'Design, manage, and maintain databases, ensuring data integrity and performance optimization.', '2025-12-29 07:16:39', '2025-12-29 07:16:39'),
(454, 2, 14, 'Quality Assurance (QA)', 'Ensure software products meet quality standards through rigorous testing and defect identification.', '2025-12-29 07:17:12', '2025-12-29 07:17:12'),
(455, 2, 14, 'Technical Writing', 'Create and maintain comprehensive documentation for software products and IT processes to ensure clear communication.', '2025-12-29 07:17:43', '2025-12-29 07:17:43'),
(456, 2, 14, 'Customer Support', 'Assist customers with inquiries and technical issues, ensuring high levels of customer satisfaction.', '2025-12-29 07:17:55', '2025-12-29 07:17:55'),
(457, 2, 15, 'Data Science and Analytics', 'Analyze data to extract actionable insights, supporting business decisions and strategy.', '2025-12-29 07:18:19', '2025-12-29 07:18:19'),
(458, 2, 15, 'Artificial Intelligence (AI) and Machine Learning (ML)', 'Develop and implement AI and ML algorithms to solve complex problems and enhance technology solutions.', '2025-12-29 07:18:36', '2025-12-29 07:18:36'),
(459, 2, 16, 'User Experience (UX) Design', 'Design user interfaces and experiences that are intuitive, engaging, and efficient for end-users.', '2025-12-29 07:19:00', '2025-12-29 07:19:00'),
(460, 2, 16, 'Cloud Computing Services', 'Manage and maintain cloud infrastructure and services, ensuring scalability, security, and efficiency.', '2025-12-29 07:19:21', '2025-12-29 07:19:21');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role_id` int(11) NOT NULL,
  `video_status` tinyint(1) NOT NULL DEFAULT 0,
  `data_range` tinyint(1) NOT NULL DEFAULT 0,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `report_status` varchar(255) NOT NULL DEFAULT '0',
  `report_notification` tinyint(1) NOT NULL DEFAULT 0,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `account_expires_at` timestamp NULL DEFAULT NULL,
  `max_cards` int(11) DEFAULT NULL,
  `can_create_users` tinyint(1) DEFAULT 0,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `panel_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = active, 0 = inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `role_id`, `video_status`, `data_range`, `email_verified_at`, `password`, `report_status`, `report_notification`, `last_login_at`, `account_expires_at`, `max_cards`, `can_create_users`, `remember_token`, `created_at`, `updated_at`, `panel_status`) VALUES
(1, 'Super', 'Admin', 'superadmin@gmail.com', 1, 0, 1, NULL, '$2y$12$7xFPCGUEtkScfg0fGerqAOn1oTgr55xB9KDvS24/0oKAlfvKVsha6', '1', 0, '2026-02-21 23:46:34', NULL, NULL, 1, NULL, '2025-11-07 11:28:54', '2026-02-21 23:46:34', 1),
(16, 'Syed', 'Zeehad', 'syed.zeehad@gmail.com', 2, 1, 1, NULL, '$2y$12$JIQFKalP0f8Axl9km6j6qetGHMqynu7iZhwDKhqVJtmvlVeSfV2dm', '2', 1, '2025-12-30 07:50:44', NULL, 50, 1, NULL, '2025-12-27 09:14:14', '2025-12-30 07:59:05', 1),
(20, 'Tanjima', 'Tabassum', 'connected@gmail.com', 3, 1, 0, NULL, '$2y$12$20UM4r.myg5Bid6T9uWxTeWcuX.piqAL6GfN1WXRuqsecGHP0gZ5.', '2', 1, '2025-12-30 04:29:16', '2026-01-01 22:37:23', 50, 0, NULL, '2025-12-29 22:35:27', '2025-12-30 04:29:16', 1),
(21, 'Sulaiman', 'Hossin', 'smdsulaiman6076@gmail.com', 3, 1, 0, NULL, '$2y$12$EZLvys1mm9gaWeg1bzc4rO/00pPS5wyc.jb6m7HkApvjBRS7n9GrW', '1', 1, '2025-12-30 00:36:59', '2026-01-02 00:34:44', 50, 0, NULL, '2025-12-30 00:34:26', '2025-12-30 02:02:33', 1),
(22, 'MD MAHOMUDUL', 'HASAN', 'turnat0719@gmail.com', 3, 1, 0, NULL, '$2y$12$rgSYWNVJJVHXDNG7BVWFz.e7iw2CQJJ2BYg.gil1HBfP.3fq3kLiy', '2', 1, '2025-12-31 01:03:37', '2026-01-02 01:05:32', 50, 0, NULL, '2025-12-30 01:04:48', '2025-12-31 01:05:52', 1),
(23, 'Faijunnesa', 'Puspita', 'faijunnesapuspita@gmail.com', 3, 1, 0, NULL, '$2y$12$m1Nrs/DlVRN5rTyuidknaudj/PiapsgfwIQXFdX685JaYLltbtXxy', '1', 1, '2025-12-30 04:34:09', '2026-01-02 04:20:34', 50, 0, NULL, '2025-12-30 04:20:06', '2025-12-30 05:25:47', 1),
(25, 'Sameen', 'Irham', 'sameenirham248@gmail.com', 3, 1, 0, NULL, '$2y$12$Ve/OpGDzBq.qw6jtQave9u9Cx0570YFATjfIjBcfLtQXDbG0hLEYG', '1', 1, '2026-01-13 05:49:44', '2026-01-16 05:31:49', 50, 0, NULL, '2026-01-13 05:31:39', '2026-01-13 07:05:43', 1),
(26, 'Ali Ashraf', 'Khan', 'abirak386@gmail.com', 3, 1, 0, NULL, '$2y$12$GHLAi5ilBQdo6LUCJlQWYOD0MLCrXqfKB7l3FH0c73x/pwg/wQx/m', '1', 1, '2026-01-13 05:37:38', '2026-01-16 05:35:26', 50, 0, NULL, '2026-01-13 05:34:35', '2026-01-13 06:05:32', 1),
(27, 'MD.Meharajul', 'Islam', 'msrohan32@gmail.com', 3, 1, 0, NULL, '$2y$12$PihYqFql/P6c18Bsag49NerrtyH4RpMblObstN4oQUh/cigL5nSVu', '2', 1, '2026-01-13 05:40:40', '2026-01-16 05:37:38', 50, 0, NULL, '2026-01-13 05:37:12', '2026-01-13 07:44:51', 1),
(28, 'Israfil Ahmed Sami', 'Sami', 'israfilsami85@gmail.com', 3, 1, 0, NULL, '$2y$12$xmxxvFKYIS32fPT6QfQCEO3bBA3WG5A.RPtdnnWehzxlJlxi4coAO', '1', 1, '2026-01-17 22:49:27', '2026-01-20 06:54:38', 50, 0, NULL, '2026-01-17 06:54:03', '2026-01-17 23:04:51', 1),
(29, 'Siam Bin', 'Shafique', 'siam.bin004@gmail.com', 3, 1, 0, NULL, '$2y$12$TWLvFwG17g1zPNHHQCZKT.FR46W5dE7Gx/3ktuc25LEbDnrq95HmO', '1', 1, '2026-01-19 00:34:58', '2026-01-20 11:58:41', 50, 0, NULL, '2026-01-17 07:58:55', '2026-01-19 00:52:57', 1),
(30, 'test', 'user', 'test@gmail.com', 3, 0, 0, NULL, '$2y$12$zc8aTwMRCMIEqvhizTIgEe7u4AP4zb76rWOJzxHYFYZcDRmZC1jMa', '0', 0, '2026-01-17 08:21:34', '2026-01-20 08:21:34', 50, 0, NULL, '2026-01-17 08:20:41', '2026-01-17 08:21:34', 1),
(31, 'Pranto', 'Mondal', 'mondol242408@gmail.com', 3, 1, 0, NULL, '$2y$12$AnTaAHSXbZKYBNnzuYw/hOeXMfvxJs0i/3IG0Kv46Bcm06WNQv5RG', '1', 1, '2026-01-19 04:04:32', '2026-01-21 23:39:55', 50, 0, NULL, '2026-01-18 23:37:44', '2026-01-19 04:52:23', 1),
(32, 'Maisha', 'Connected', 'maisha01connected@gmail.com', 2, 1, 0, NULL, '$2y$12$N1UysQN4Ce4/2LPOyrYEN.SRC20KQPQWK07sB5C32NLsH.fFKd/eG', '0', 0, '2026-02-18 22:16:11', NULL, 10, 1, NULL, '2026-01-19 21:43:50', '2026-02-18 22:16:11', 1),
(33, 'Rumana Jannat', 'Ritu', 'rjritubd@gmail.com', 3, 1, 0, NULL, '$2y$12$Ch.bH.lF5zWTnkp3Z/XbRubJWTbl8NXd4qHud1GNkJsgxu.kL.IeW', '1', 0, '2026-01-21 00:36:46', '2026-01-23 10:30:57', NULL, 0, NULL, '2026-01-19 22:38:14', '2026-01-21 01:05:59', 1),
(34, 'Toha Rezwana', 'Nijhum', 'zebarezwana77@gmail.com', 3, 1, 0, NULL, '$2y$12$tQPJet5JvJyvyCxwukcp2u3sIVlQLkjDIuhX1qqYz3Fwo5ucwNFn.', '1', 1, '2026-01-21 03:20:50', '2026-01-24 03:13:14', NULL, 0, NULL, '2026-01-21 00:50:19', '2026-01-21 03:34:16', 1),
(35, 'Al Fahim', 'Billah', 'alfahimbillah@gmail.com', 3, 1, 0, NULL, '$2y$12$bHpdRtnmxDYFeecIGje5Fesc8ZobKDjAHTFkAfoeHu/A8Nfcrm5Le', '1', 1, '2026-01-21 09:42:25', '2026-01-24 01:43:24', NULL, 0, NULL, '2026-01-21 00:54:47', '2026-01-21 09:42:25', 1),
(37, 'Himadry', 'Shuvro', 'shubhrodavid40@gmail.com', 3, 1, 0, NULL, '$2y$12$DF5q9Y769ctKi3BshFcFFOV97Yc5ziy9qrhVg/X2QvX76DpVPLcTW', '1', 1, '2026-02-08 02:14:35', '2026-02-11 02:14:35', NULL, 0, NULL, '2026-02-08 02:11:42', '2026-02-08 02:48:58', 1),
(38, 'Munia', 'Akhtar', 'muniaakhtar59@gmail.com', 3, 1, 0, NULL, '$2y$12$nUfi9kioZPFD6E37uzrK6.KFtTkhLt1bey6JJujm74RiujaMvPBwG', '0', 0, '2026-02-10 11:50:45', '2026-02-13 11:50:45', 50, 0, NULL, '2026-02-10 07:16:21', '2026-02-10 15:05:34', 1),
(39, 'test2', 'user', 'test2@gmail.com', 3, 0, 0, NULL, '$2y$12$dvGKRVtvZXZoUWaVHjnVqu1uIIIpXRuW/gKqO3Ar5G4BxyI1MW4Um', '0', 0, '2026-02-17 02:45:37', '2026-02-20 02:45:37', 50, 0, NULL, '2026-02-17 02:45:20', '2026-02-17 02:45:37', 1),
(40, 'Nuzhat Tabassum', 'Akher', 'nuzhattabassumakher@gmail.com', 3, 0, 0, NULL, '$2y$12$/JdgCVysNOl0prLjBa6jV.bhd7D.0b.H/zBPj7Kmp8AJDlPGoJ1B6', '0', 0, NULL, NULL, NULL, 0, NULL, '2026-02-18 21:15:01', '2026-02-18 21:15:01', 1),
(41, 'Iffat Tabassum', 'Akher', 'iffatakher@gmail.com', 3, 0, 0, NULL, '$2y$12$R8DDkUAwGLrHhhEiuxlVTulh0w8sQ3JBzBWLKaYQlThV/ae45cwFm', '0', 0, NULL, NULL, NULL, 0, NULL, '2026-02-18 21:16:17', '2026-02-18 21:16:17', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_challenge_data`
--

CREATE TABLE `user_challenge_data` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `industry_id` bigint(20) UNSIGNED NOT NULL,
  `department_id` bigint(20) UNSIGNED DEFAULT NULL,
  `common_department_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`common_department_id`)),
  `sub_department_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`sub_department_ids`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_challenge_data`
--

INSERT INTO `user_challenge_data` (`id`, `user_id`, `industry_id`, `department_id`, `common_department_id`, `sub_department_ids`, `created_at`, `updated_at`) VALUES
(325, 21, 2, 13, '[1,5]', '[31,32]', '2025-12-30 01:50:27', '2025-12-30 01:54:13'),
(326, 21, 2, 15, '[1,5]', '[457]', '2025-12-30 01:50:27', '2025-12-30 01:54:13'),
(327, 21, 16, 80, '[1,5]', '[221]', '2025-12-30 01:50:27', '2025-12-30 01:54:13'),
(328, 21, 16, 82, '[1,5]', '[230,231]', '2025-12-30 01:50:27', '2025-12-30 01:54:13'),
(332, 20, 3, 21, '[6]', '[48]', '2025-12-30 01:55:32', '2025-12-30 01:55:54'),
(336, 23, 1, 9, '[6]', '[13,14,23]', '2025-12-30 05:11:53', '2025-12-30 05:12:40'),
(337, 23, 27, 123, '[6]', '[361]', '2025-12-30 05:11:53', '2025-12-30 05:12:40'),
(338, 23, 27, 124, '[6]', '[363]', '2025-12-30 05:11:53', '2025-12-30 05:12:40'),
(339, 23, 27, 127, '[6]', '[368]', '2025-12-30 05:11:53', '2025-12-30 05:12:40'),
(340, 23, 10, 45, '[6]', '[122]', '2025-12-30 05:11:53', '2025-12-30 05:12:40'),
(341, 23, 10, 48, '[6]', '[131,132]', '2025-12-30 05:11:53', '2025-12-30 05:12:40'),
(359, 16, 30, 107, '[]', '[413]', '2025-12-30 07:57:13', '2025-12-30 07:57:15'),
(361, 22, 25, 154, '[]', '[355]', '2025-12-31 01:05:34', '2025-12-31 01:05:39'),
(369, 26, 2, 12, '[2,5]', '[27]', '2026-01-13 05:59:02', '2026-01-13 06:00:23'),
(370, 26, 2, 15, '[2,5]', '[457,458]', '2026-01-13 05:59:02', '2026-01-13 06:00:23'),
(371, 26, 3, 19, '[2,5]', '[40]', '2026-01-13 05:59:02', '2026-01-13 06:00:23'),
(372, 26, 3, 20, '[2,5]', '[46]', '2026-01-13 05:59:02', '2026-01-13 06:00:23'),
(373, 26, 3, 21, '[2,5]', '[48]', '2026-01-13 05:59:02', '2026-01-13 06:00:23'),
(374, 26, 25, 150, '[2,5]', '[347,348]', '2026-01-13 05:59:02', '2026-01-13 06:00:23'),
(375, 26, 25, 151, '[2,5]', '[350]', '2026-01-13 05:59:02', '2026-01-13 06:00:23'),
(379, 25, 4, 22, '[]', '[49,50]', '2026-01-13 06:54:33', '2026-01-13 06:55:40'),
(380, 25, 4, 23, '[]', '[54]', '2026-01-13 06:54:33', '2026-01-13 06:55:40'),
(381, 25, 10, 47, '[]', '[130]', '2026-01-13 06:54:33', '2026-01-13 06:55:40'),
(382, 25, 10, 48, '[]', '[131,132]', '2026-01-13 06:54:33', '2026-01-13 06:55:40'),
(383, 25, 20, 182, '[]', '[284,285]', '2026-01-13 06:54:33', '2026-01-13 06:55:40'),
(384, 25, 20, 183, '[]', '[286]', '2026-01-13 06:54:33', '2026-01-13 06:55:40'),
(388, 27, 4, 23, '[4]', '[53]', '2026-01-13 07:31:10', '2026-01-13 07:32:50'),
(389, 27, 4, 24, '[4]', '[62]', '2026-01-13 07:31:10', '2026-01-13 07:32:50'),
(390, 27, 2, 13, '[4]', '[31]', '2026-01-13 07:31:10', '2026-01-13 07:32:50'),
(391, 27, 2, 15, '[4]', '[458]', '2026-01-13 07:31:10', '2026-01-13 07:32:50'),
(392, 27, 21, 176, '[4]', '[297]', '2026-01-13 07:31:10', '2026-01-13 07:32:50'),
(396, 28, 3, 17, '[5,2]', '[35]', '2026-01-17 23:00:50', '2026-01-17 23:01:16'),
(397, 28, 3, 18, '[5,2]', '[37,39]', '2026-01-17 23:00:50', '2026-01-17 23:01:16'),
(398, 28, 2, 15, '[5,2]', '[458]', '2026-01-17 23:00:50', '2026-01-17 23:01:16'),
(420, 29, 3, 17, '[2]', '[35]', '2026-01-19 00:44:07', '2026-01-19 00:46:28'),
(421, 29, 4, 22, '[2]', '[49,51]', '2026-01-19 00:44:07', '2026-01-19 00:46:28'),
(437, 31, 2, 12, '[1,5]', '[27]', '2026-01-19 04:42:47', '2026-01-19 04:44:06'),
(438, 31, 2, 13, '[1,5]', '[31]', '2026-01-19 04:42:47', '2026-01-19 04:44:06'),
(439, 31, 2, 15, '[1,5]', '[457]', '2026-01-19 04:42:47', '2026-01-19 04:44:06'),
(440, 31, 26, 130, '[1,5]', '[374]', '2026-01-19 04:42:47', '2026-01-19 04:44:06'),
(441, 31, 26, 131, '[1,5]', '[376]', '2026-01-19 04:42:47', '2026-01-19 04:44:06'),
(442, 31, 26, 132, '[1,5]', '[377]', '2026-01-19 04:42:47', '2026-01-19 04:44:06'),
(443, 31, 23, 166, '[1,5]', '[326]', '2026-01-19 04:42:47', '2026-01-19 04:44:06'),
(444, 31, 23, 167, '[1,5]', '[327]', '2026-01-19 04:42:47', '2026-01-19 04:44:06'),
(445, 31, 23, 168, '[1,5]', '[328]', '2026-01-19 04:42:47', '2026-01-19 04:44:06'),
(449, 33, 2, 12, '[]', '[27]', '2026-01-21 00:54:58', '2026-01-21 00:55:34'),
(450, 33, 2, 13, '[]', '[31]', '2026-01-21 00:54:58', '2026-01-21 00:55:34'),
(451, 33, 2, 15, '[]', '[458]', '2026-01-21 00:54:58', '2026-01-21 00:55:34'),
(455, 34, 4, 23, '[]', '[53,55,57]', '2026-01-21 03:32:22', '2026-01-21 03:32:39'),
(456, 34, 23, 164, '[]', '[322]', '2026-01-21 03:32:22', '2026-01-21 03:32:39'),
(460, 35, 3, 17, '[2,4]', '[34,35]', '2026-01-21 04:10:01', '2026-01-21 04:10:29'),
(461, 35, 3, 20, '[2,4]', '[46]', '2026-01-21 04:10:01', '2026-01-21 04:10:29'),
(462, 35, 17, 141, '[2,4]', '[250]', '2026-01-21 04:10:01', '2026-01-21 04:10:29'),
(463, 35, 17, 142, '[2,4]', '[252]', '2026-01-21 04:10:01', '2026-01-21 04:10:29'),
(464, 35, 21, 177, '[2,4]', '[298]', '2026-01-21 04:10:01', '2026-01-21 04:10:29'),
(465, 35, 21, 178, '[2,4]', '[302]', '2026-01-21 04:10:01', '2026-01-21 04:10:29'),
(466, 35, 21, 179, '[2,4]', '[304]', '2026-01-21 04:10:01', '2026-01-21 04:10:29'),
(470, 37, 16, 80, '[6]', '[221]', '2026-02-08 02:39:17', '2026-02-08 02:39:43'),
(471, 37, 16, 82, '[6]', '[230]', '2026-02-08 02:39:17', '2026-02-08 02:39:43'),
(472, 37, 16, 83, '[6]', '[234]', '2026-02-08 02:39:17', '2026-02-08 02:39:43'),
(473, 37, 19, 189, '[6]', '[273]', '2026-02-08 02:39:17', '2026-02-08 02:39:43'),
(474, 37, 19, 190, '[6]', '[275]', '2026-02-08 02:39:17', '2026-02-08 02:39:43'),
(475, 37, 19, 191, '[6]', '[279]', '2026-02-08 02:39:17', '2026-02-08 02:39:43');

-- --------------------------------------------------------

--
-- Table structure for table `user_questionnaire_answers`
--

CREATE TABLE `user_questionnaire_answers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `details` text DEFAULT NULL,
  `first_option` varchar(255) DEFAULT NULL,
  `second_option` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_questionnaire_answers`
--

INSERT INTO `user_questionnaire_answers` (`id`, `user_id`, `title`, `details`, `first_option`, `second_option`, `created_at`, `updated_at`) VALUES
(2, 1, 'High Salary Importance', 'Is receiving a high salary extremely important for your job satisfaction? For example, would you prefer a career that offers a higher salary over one that provides an average household income?', 'Yes, I am highly money motivated.', 'No, I will still be happy with an average income if I am happy.', '2025-11-16 21:49:34', '2025-11-16 21:49:34'),
(3, 1, 'Job Security', 'Is job security a crucial factor for you?', 'Yes, I prefer a stable and predictable career path', 'No, I like taking risks and prefer rapid career advancement', '2025-11-16 21:49:59', '2025-11-16 21:49:59'),
(4, 1, 'Work Life Balance', 'Do you mind being a workaholic?', 'Yes, I enjoy working all the time', 'No, I would like to get back home after working hours with a balanced life', '2025-11-16 21:50:30', '2025-11-16 21:50:30'),
(5, 1, 'Travel Willingness', 'Are you willing to travel extensively for work?', 'Yes, I don’t mind being away from family time to time', 'No, I prefer always staying close to my family', '2025-11-16 21:50:55', '2025-11-16 21:50:55'),
(6, 1, 'Teamwork Preference', 'Do you enjoy working in teams?', 'Yes, I love being around people and working together', 'No, I prefer to work alone independently', '2025-11-16 21:51:07', '2025-11-16 21:51:07'),
(7, 1, 'Social Interactivity', 'Do you like jobs that involve frequent interaction with customers or clients?', 'Yes, I love talking to lots of strangers and speaking publicly', 'No, I don’t enjoy lots of public interaction', '2025-11-16 21:51:21', '2025-11-16 21:51:21'),
(8, 1, 'Work Environment Pressure', 'Do you like a fast-paced and high-pressure work environment?', 'Yes, I enjoy high pressure work environments', 'No, I prefer a balanced work pressure environment', '2025-11-16 21:51:34', '2025-11-16 21:51:34'),
(9, 1, 'Physical Activity', 'Do you prefer a job that involves physical activity or being on your feet?', 'Yes, I like moving around a lot during my work and being in the field', 'No, I like a job that involves less physical activity', '2025-11-16 21:51:58', '2025-11-16 21:51:58'),
(10, 1, 'Outdoor Work', 'Do you enjoy outdoor work rather than being confined to an office?', 'Yes, I love being outdoors all the time and don’t like being confined to an office', 'No, I prefer being confined to an office environment with a predictable day', '2025-11-16 21:52:13', '2025-11-16 21:52:13'),
(11, 1, 'Recognition', 'Is receiving recognition and rewards for your work important to you?', 'Yes, I love being recognized publicly', 'No, I prefer being appreciated privately', '2025-12-29 20:04:42', '2025-12-29 20:04:42'),
(12, 1, 'Leadership and Influence', 'Do you enjoy jobs where you can influence or lead others?', 'Yes, I love leading people and influence them', 'No, I feel very anxious leading people', '2025-12-29 20:05:17', '2025-12-29 20:05:17'),
(13, 1, 'Ambition & Competitiveness', 'Is it important for you to achieve top positions in your career?', 'Yes, I like to compete and achieve top positions in my job', 'No, I prefer a work environment where everyone is treated equally and collaboration is emphasized over competition', '2025-12-29 20:06:35', '2025-12-29 20:06:35'),
(14, 1, 'Decision-Making', 'Do you prefer to make significant decisions in your job, or do you feel more comfortable following guidelines?', 'Yes, I enjoy making significant decisions that impact my team, company or industry', 'No, I prefer following established guidelines from an expert', '2025-12-29 20:07:14', '2025-12-29 20:07:14'),
(15, 1, 'Technical vs Non- Technical', 'Do you enjoy working in technical roles requiring specialized knowledge, or do you prefer non-technical roles that focus on other skills?', 'Yes, I enjoy technical role requiring specialized skills in one area.', 'No, I prefer non-technical roles requiring broad skills sets.', '2025-12-29 20:07:44', '2025-12-29 20:07:44'),
(16, 1, 'Conflict Resolution', 'Do you enjoy roles that involve conflict resolution and negotiation, or do you prefer roles with minimal conflict?', 'Yes, I enjoy conflict resolution and negotiation which may involve tense discussions', 'No, I prefer roles with minimal conflict where I won’t be faced with negative opinions of people about me', '2025-12-29 20:08:13', '2025-12-29 20:08:13');

-- --------------------------------------------------------

--
-- Table structure for table `user_submitted_answers`
--

CREATE TABLE `user_submitted_answers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `question_id` bigint(20) UNSIGNED NOT NULL,
  `selected_option` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_submitted_answers`
--

INSERT INTO `user_submitted_answers` (`id`, `user_id`, `question_id`, `selected_option`, `created_at`, `updated_at`) VALUES
(83, 16, 2, 'No, I will still be happy with an average income if I am happy.', '2025-12-29 20:01:45', '2025-12-30 07:58:50'),
(84, 16, 3, 'No, I like taking risks and prefer rapid career advancement', '2025-12-29 20:01:45', '2025-12-29 20:01:45'),
(85, 16, 4, 'No, I would like to get back home after working hours with a balanced life', '2025-12-29 20:01:45', '2025-12-29 20:01:45'),
(86, 16, 5, 'No, I prefer always staying close to my family', '2025-12-29 20:01:45', '2025-12-29 20:01:45'),
(87, 16, 6, 'Yes, I love being around people and working together', '2025-12-29 20:01:45', '2025-12-29 20:01:45'),
(88, 16, 7, 'No, I don’t enjoy lots of public interaction', '2025-12-29 20:01:45', '2025-12-29 20:01:45'),
(89, 16, 8, 'Yes, I enjoy high pressure work environments', '2025-12-29 20:01:45', '2025-12-29 20:01:45'),
(90, 16, 9, 'Yes, I like moving around a lot during my work and being in the field', '2025-12-29 20:01:45', '2025-12-29 20:01:45'),
(91, 16, 10, 'Yes, I love being outdoors all the time and don’t like being confined to an office', '2025-12-29 20:01:45', '2025-12-29 20:01:45'),
(92, 20, 2, 'Yes, I am highly money motivated.', '2025-12-29 23:00:59', '2025-12-29 23:00:59'),
(93, 20, 3, 'Yes, I prefer a stable and predictable career path', '2025-12-29 23:00:59', '2025-12-29 23:00:59'),
(94, 20, 4, 'Yes, I enjoy working all the time', '2025-12-29 23:00:59', '2025-12-29 23:00:59'),
(95, 20, 5, 'No, I prefer always staying close to my family', '2025-12-29 23:00:59', '2025-12-29 23:00:59'),
(96, 20, 6, 'Yes, I love being around people and working together', '2025-12-29 23:00:59', '2025-12-29 23:00:59'),
(97, 20, 7, 'Yes, I love talking to lots of strangers and speaking publicly', '2025-12-29 23:00:59', '2025-12-29 23:00:59'),
(98, 20, 8, 'Yes, I enjoy high pressure work environments', '2025-12-29 23:00:59', '2025-12-29 23:00:59'),
(99, 20, 9, 'No, I like a job that involves less physical activity', '2025-12-29 23:00:59', '2025-12-29 23:00:59'),
(100, 20, 10, 'No, I prefer being confined to an office environment with a predictable day', '2025-12-29 23:00:59', '2025-12-29 23:00:59'),
(101, 20, 11, 'Yes, I love being recognized publicly', '2025-12-29 23:00:59', '2025-12-29 23:00:59'),
(102, 20, 12, 'Yes, I love leading people and influence them', '2025-12-29 23:00:59', '2025-12-29 23:00:59'),
(103, 20, 13, 'No, I prefer a work environment where everyone is treated equally and collaboration is emphasized over competition', '2025-12-29 23:00:59', '2025-12-29 23:00:59'),
(104, 20, 14, 'Yes, I enjoy making significant decisions that impact my team, company or industry', '2025-12-29 23:00:59', '2025-12-29 23:00:59'),
(105, 20, 15, 'No, I prefer non-technical roles requiring broad skills sets.', '2025-12-29 23:00:59', '2025-12-29 23:00:59'),
(106, 20, 16, 'No, I prefer roles with minimal conflict where I won’t be faced with negative opinions of people about me', '2025-12-29 23:00:59', '2025-12-29 23:00:59'),
(122, 22, 2, 'Yes, I am highly money motivated.', '2025-12-30 01:50:28', '2025-12-30 01:50:28'),
(123, 22, 3, 'Yes, I prefer a stable and predictable career path', '2025-12-30 01:50:28', '2025-12-30 01:50:28'),
(124, 22, 4, 'No, I would like to get back home after working hours with a balanced life', '2025-12-30 01:50:28', '2025-12-30 01:50:28'),
(125, 22, 5, 'No, I prefer always staying close to my family', '2025-12-30 01:50:28', '2025-12-30 01:50:28'),
(126, 22, 6, 'Yes, I love being around people and working together', '2025-12-30 01:50:28', '2025-12-30 01:50:28'),
(127, 22, 7, 'Yes, I love talking to lots of strangers and speaking publicly', '2025-12-30 01:50:28', '2025-12-30 01:50:28'),
(128, 22, 8, 'No, I prefer a balanced work pressure environment', '2025-12-30 01:50:28', '2025-12-30 01:50:28'),
(129, 22, 9, 'Yes, I like moving around a lot during my work and being in the field', '2025-12-30 01:50:28', '2025-12-30 01:50:28'),
(130, 22, 10, 'Yes, I love being outdoors all the time and don’t like being confined to an office', '2025-12-30 01:50:28', '2025-12-30 01:50:28'),
(131, 22, 11, 'Yes, I love being recognized publicly', '2025-12-30 01:50:28', '2025-12-30 01:50:28'),
(132, 22, 12, 'Yes, I love leading people and influence them', '2025-12-30 01:50:28', '2025-12-30 01:50:28'),
(133, 22, 13, 'Yes, I like to compete and achieve top positions in my job', '2025-12-30 01:50:28', '2025-12-30 01:50:28'),
(134, 22, 14, 'Yes, I enjoy making significant decisions that impact my team, company or industry', '2025-12-30 01:50:28', '2025-12-30 01:50:28'),
(135, 22, 15, 'Yes, I enjoy technical role requiring specialized skills in one area.', '2025-12-30 01:50:28', '2025-12-30 01:50:28'),
(136, 22, 16, 'No, I prefer roles with minimal conflict where I won’t be faced with negative opinions of people about me', '2025-12-30 01:50:28', '2025-12-30 01:50:28'),
(137, 21, 2, 'No, I will still be happy with an average income if I am happy.', '2025-12-30 02:02:28', '2025-12-30 02:02:28'),
(138, 21, 3, 'Yes, I prefer a stable and predictable career path', '2025-12-30 02:02:28', '2025-12-30 02:02:28'),
(139, 21, 4, 'No, I would like to get back home after working hours with a balanced life', '2025-12-30 02:02:28', '2025-12-30 02:02:28'),
(140, 21, 5, 'Yes, I don’t mind being away from family time to time', '2025-12-30 02:02:28', '2025-12-30 02:02:28'),
(141, 21, 6, 'Yes, I love being around people and working together', '2025-12-30 02:02:28', '2025-12-30 02:02:28'),
(142, 21, 8, 'No, I prefer a balanced work pressure environment', '2025-12-30 02:02:28', '2025-12-30 02:02:28'),
(143, 21, 7, 'Yes, I love talking to lots of strangers and speaking publicly', '2025-12-30 02:02:28', '2025-12-30 02:02:28'),
(144, 21, 9, 'No, I like a job that involves less physical activity', '2025-12-30 02:02:28', '2025-12-30 02:02:28'),
(145, 21, 10, 'No, I prefer being confined to an office environment with a predictable day', '2025-12-30 02:02:28', '2025-12-30 02:02:28'),
(146, 21, 11, 'Yes, I love being recognized publicly', '2025-12-30 02:02:28', '2025-12-30 02:02:28'),
(147, 21, 12, 'Yes, I love leading people and influence them', '2025-12-30 02:02:28', '2025-12-30 02:02:28'),
(148, 21, 13, 'Yes, I like to compete and achieve top positions in my job', '2025-12-30 02:02:28', '2025-12-30 02:02:28'),
(149, 21, 14, 'Yes, I enjoy making significant decisions that impact my team, company or industry', '2025-12-30 02:02:28', '2025-12-30 02:02:28'),
(150, 21, 15, 'Yes, I enjoy technical role requiring specialized skills in one area.', '2025-12-30 02:02:28', '2025-12-30 02:02:28'),
(151, 21, 16, 'No, I prefer roles with minimal conflict where I won’t be faced with negative opinions of people about me', '2025-12-30 02:02:28', '2025-12-30 02:02:28'),
(152, 23, 2, 'No, I will still be happy with an average income if I am happy.', '2025-12-30 05:25:32', '2025-12-30 05:25:32'),
(153, 23, 3, 'Yes, I prefer a stable and predictable career path', '2025-12-30 05:25:32', '2025-12-30 05:25:32'),
(154, 23, 4, 'No, I would like to get back home after working hours with a balanced life', '2025-12-30 05:25:32', '2025-12-30 05:25:32'),
(155, 23, 5, 'Yes, I don’t mind being away from family time to time', '2025-12-30 05:25:32', '2025-12-30 05:25:32'),
(156, 23, 6, 'Yes, I love being around people and working together', '2025-12-30 05:25:32', '2025-12-30 05:25:32'),
(157, 23, 7, 'Yes, I love talking to lots of strangers and speaking publicly', '2025-12-30 05:25:32', '2025-12-30 05:25:32'),
(158, 23, 8, 'No, I prefer a balanced work pressure environment', '2025-12-30 05:25:32', '2025-12-30 05:25:32'),
(159, 23, 9, 'Yes, I like moving around a lot during my work and being in the field', '2025-12-30 05:25:32', '2025-12-30 05:25:32'),
(160, 23, 10, 'Yes, I love being outdoors all the time and don’t like being confined to an office', '2025-12-30 05:25:32', '2025-12-30 05:25:32'),
(161, 23, 11, 'Yes, I love being recognized publicly', '2025-12-30 05:25:32', '2025-12-30 05:25:32'),
(162, 23, 12, 'Yes, I love leading people and influence them', '2025-12-30 05:25:32', '2025-12-30 05:25:32'),
(163, 23, 13, 'Yes, I like to compete and achieve top positions in my job', '2025-12-30 05:25:32', '2025-12-30 05:25:32'),
(164, 23, 14, 'No, I prefer following established guidelines from an expert', '2025-12-30 05:25:32', '2025-12-30 05:25:32'),
(165, 23, 15, 'Yes, I enjoy technical role requiring specialized skills in one area.', '2025-12-30 05:25:32', '2025-12-30 05:25:32'),
(166, 23, 16, 'Yes, I enjoy conflict resolution and negotiation which may involve tense discussions', '2025-12-30 05:25:32', '2025-12-30 05:25:32'),
(167, 16, 12, 'Yes, I love leading people and influence them', '2025-12-30 07:58:50', '2025-12-30 07:58:50'),
(168, 16, 16, 'No, I prefer roles with minimal conflict where I won’t be faced with negative opinions of people about me', '2025-12-30 07:58:50', '2025-12-30 07:58:50'),
(169, 16, 11, 'No, I prefer being appreciated privately', '2025-12-30 07:58:50', '2025-12-30 07:58:50'),
(170, 16, 15, 'No, I prefer non-technical roles requiring broad skills sets.', '2025-12-30 07:58:50', '2025-12-30 07:58:50'),
(171, 16, 14, 'No, I prefer following established guidelines from an expert', '2025-12-30 07:58:50', '2025-12-30 07:58:50'),
(172, 16, 13, 'No, I prefer a work environment where everyone is treated equally and collaboration is emphasized over competition', '2025-12-30 07:58:50', '2025-12-30 07:58:50'),
(173, 26, 2, 'Yes, I am highly money motivated.', '2026-01-13 06:05:24', '2026-01-13 06:05:24'),
(174, 26, 3, 'No, I like taking risks and prefer rapid career advancement', '2026-01-13 06:05:24', '2026-01-13 06:05:24'),
(175, 26, 4, 'No, I would like to get back home after working hours with a balanced life', '2026-01-13 06:05:24', '2026-01-13 06:05:24'),
(176, 26, 5, 'Yes, I don’t mind being away from family time to time', '2026-01-13 06:05:24', '2026-01-13 06:05:24'),
(177, 26, 6, 'Yes, I love being around people and working together', '2026-01-13 06:05:24', '2026-01-13 06:05:24'),
(178, 26, 7, 'Yes, I love talking to lots of strangers and speaking publicly', '2026-01-13 06:05:24', '2026-01-13 06:05:24'),
(179, 26, 8, 'Yes, I enjoy high pressure work environments', '2026-01-13 06:05:24', '2026-01-13 06:05:24'),
(180, 26, 9, 'Yes, I like moving around a lot during my work and being in the field', '2026-01-13 06:05:24', '2026-01-13 06:05:24'),
(181, 26, 10, 'Yes, I love being outdoors all the time and don’t like being confined to an office', '2026-01-13 06:05:24', '2026-01-13 06:05:24'),
(182, 26, 11, 'Yes, I love being recognized publicly', '2026-01-13 06:05:24', '2026-01-13 06:05:24'),
(183, 26, 12, 'Yes, I love leading people and influence them', '2026-01-13 06:05:24', '2026-01-13 06:05:24'),
(184, 26, 14, 'Yes, I enjoy making significant decisions that impact my team, company or industry', '2026-01-13 06:05:24', '2026-01-13 06:05:24'),
(185, 26, 13, 'No, I prefer a work environment where everyone is treated equally and collaboration is emphasized over competition', '2026-01-13 06:05:24', '2026-01-13 06:05:24'),
(186, 26, 15, 'Yes, I enjoy technical role requiring specialized skills in one area.', '2026-01-13 06:05:24', '2026-01-13 06:05:24'),
(187, 26, 16, 'Yes, I enjoy conflict resolution and negotiation which may involve tense discussions', '2026-01-13 06:05:24', '2026-01-13 06:05:24'),
(188, 25, 2, 'Yes, I am highly money motivated.', '2026-01-13 07:05:38', '2026-01-13 07:05:38'),
(189, 25, 3, 'Yes, I prefer a stable and predictable career path', '2026-01-13 07:05:38', '2026-01-13 07:05:38'),
(190, 25, 5, 'Yes, I don’t mind being away from family time to time', '2026-01-13 07:05:38', '2026-01-13 07:05:38'),
(191, 25, 4, 'No, I would like to get back home after working hours with a balanced life', '2026-01-13 07:05:38', '2026-01-13 07:05:38'),
(192, 25, 6, 'Yes, I love being around people and working together', '2026-01-13 07:05:38', '2026-01-13 07:05:38'),
(193, 25, 7, 'Yes, I love talking to lots of strangers and speaking publicly', '2026-01-13 07:05:38', '2026-01-13 07:05:38'),
(194, 25, 9, 'Yes, I like moving around a lot during my work and being in the field', '2026-01-13 07:05:38', '2026-01-13 07:05:38'),
(195, 25, 10, 'Yes, I love being outdoors all the time and don’t like being confined to an office', '2026-01-13 07:05:38', '2026-01-13 07:05:38'),
(196, 25, 11, 'Yes, I love being recognized publicly', '2026-01-13 07:05:38', '2026-01-13 07:05:38'),
(197, 25, 12, 'Yes, I love leading people and influence them', '2026-01-13 07:05:38', '2026-01-13 07:05:38'),
(198, 25, 8, 'No, I prefer a balanced work pressure environment', '2026-01-13 07:05:38', '2026-01-13 07:05:38'),
(199, 25, 13, 'No, I prefer a work environment where everyone is treated equally and collaboration is emphasized over competition', '2026-01-13 07:05:38', '2026-01-13 07:05:38'),
(200, 25, 14, 'Yes, I enjoy making significant decisions that impact my team, company or industry', '2026-01-13 07:05:38', '2026-01-13 07:05:38'),
(201, 25, 15, 'Yes, I enjoy technical role requiring specialized skills in one area.', '2026-01-13 07:05:38', '2026-01-13 07:05:38'),
(202, 25, 16, 'Yes, I enjoy conflict resolution and negotiation which may involve tense discussions', '2026-01-13 07:05:38', '2026-01-13 07:05:38'),
(203, 27, 2, 'Yes, I am highly money motivated.', '2026-01-13 07:42:42', '2026-01-13 07:42:42'),
(204, 27, 3, 'No, I like taking risks and prefer rapid career advancement', '2026-01-13 07:42:42', '2026-01-13 07:42:42'),
(205, 27, 4, 'No, I would like to get back home after working hours with a balanced life', '2026-01-13 07:42:42', '2026-01-13 07:42:42'),
(206, 27, 5, 'Yes, I don’t mind being away from family time to time', '2026-01-13 07:42:42', '2026-01-13 07:42:42'),
(207, 27, 6, 'No, I prefer to work alone independently', '2026-01-13 07:42:42', '2026-01-13 07:42:42'),
(208, 27, 7, 'No, I don’t enjoy lots of public interaction', '2026-01-13 07:42:42', '2026-01-13 07:42:42'),
(209, 27, 8, 'No, I prefer a balanced work pressure environment', '2026-01-13 07:42:42', '2026-01-13 07:42:42'),
(210, 27, 9, 'Yes, I like moving around a lot during my work and being in the field', '2026-01-13 07:42:42', '2026-01-13 07:42:42'),
(211, 27, 10, 'No, I prefer being confined to an office environment with a predictable day', '2026-01-13 07:42:42', '2026-01-13 07:42:42'),
(212, 27, 11, 'No, I prefer being appreciated privately', '2026-01-13 07:42:42', '2026-01-13 07:42:42'),
(213, 27, 12, 'Yes, I love leading people and influence them', '2026-01-13 07:42:42', '2026-01-13 07:42:42'),
(214, 27, 13, 'Yes, I like to compete and achieve top positions in my job', '2026-01-13 07:42:42', '2026-01-13 07:42:42'),
(215, 27, 14, 'Yes, I enjoy making significant decisions that impact my team, company or industry', '2026-01-13 07:42:42', '2026-01-13 07:42:42'),
(216, 27, 15, 'Yes, I enjoy technical role requiring specialized skills in one area.', '2026-01-13 07:42:42', '2026-01-13 07:42:42'),
(217, 27, 16, 'Yes, I enjoy conflict resolution and negotiation which may involve tense discussions', '2026-01-13 07:42:42', '2026-01-13 07:42:42'),
(218, 28, 2, 'Yes, I am highly money motivated.', '2026-01-17 23:04:41', '2026-01-17 23:04:41'),
(219, 28, 3, 'No, I like taking risks and prefer rapid career advancement', '2026-01-17 23:04:41', '2026-01-17 23:04:41'),
(220, 28, 4, 'No, I would like to get back home after working hours with a balanced life', '2026-01-17 23:04:41', '2026-01-17 23:04:41'),
(221, 28, 5, 'Yes, I don’t mind being away from family time to time', '2026-01-17 23:04:41', '2026-01-17 23:04:41'),
(222, 28, 6, 'Yes, I love being around people and working together', '2026-01-17 23:04:41', '2026-01-17 23:04:41'),
(223, 28, 7, 'Yes, I love talking to lots of strangers and speaking publicly', '2026-01-17 23:04:41', '2026-01-17 23:04:41'),
(224, 28, 8, 'No, I prefer a balanced work pressure environment', '2026-01-17 23:04:41', '2026-01-17 23:04:41'),
(225, 28, 9, 'Yes, I like moving around a lot during my work and being in the field', '2026-01-17 23:04:41', '2026-01-17 23:04:41'),
(226, 28, 10, 'Yes, I love being outdoors all the time and don’t like being confined to an office', '2026-01-17 23:04:41', '2026-01-17 23:04:41'),
(227, 28, 11, 'Yes, I love being recognized publicly', '2026-01-17 23:04:41', '2026-01-17 23:04:41'),
(228, 28, 12, 'Yes, I love leading people and influence them', '2026-01-17 23:04:41', '2026-01-17 23:04:41'),
(229, 28, 13, 'Yes, I like to compete and achieve top positions in my job', '2026-01-17 23:04:41', '2026-01-17 23:04:41'),
(230, 28, 14, 'Yes, I enjoy making significant decisions that impact my team, company or industry', '2026-01-17 23:04:41', '2026-01-17 23:04:41'),
(231, 28, 15, 'Yes, I enjoy technical role requiring specialized skills in one area.', '2026-01-17 23:04:41', '2026-01-17 23:04:41'),
(232, 28, 16, 'Yes, I enjoy conflict resolution and negotiation which may involve tense discussions', '2026-01-17 23:04:41', '2026-01-17 23:04:41'),
(233, 29, 2, 'Yes, I am highly money motivated.', '2026-01-19 00:52:46', '2026-01-19 00:52:46'),
(234, 29, 3, 'No, I like taking risks and prefer rapid career advancement', '2026-01-19 00:52:46', '2026-01-19 00:52:46'),
(235, 29, 4, 'Yes, I enjoy working all the time', '2026-01-19 00:52:46', '2026-01-19 00:52:46'),
(236, 29, 5, 'Yes, I don’t mind being away from family time to time', '2026-01-19 00:52:46', '2026-01-19 00:52:46'),
(237, 29, 6, 'Yes, I love being around people and working together', '2026-01-19 00:52:46', '2026-01-19 00:52:46'),
(238, 29, 7, 'No, I don’t enjoy lots of public interaction', '2026-01-19 00:52:46', '2026-01-19 00:52:46'),
(239, 29, 8, 'Yes, I enjoy high pressure work environments', '2026-01-19 00:52:46', '2026-01-19 00:52:46'),
(240, 29, 9, 'Yes, I like moving around a lot during my work and being in the field', '2026-01-19 00:52:46', '2026-01-19 00:52:46'),
(241, 29, 10, 'Yes, I love being outdoors all the time and don’t like being confined to an office', '2026-01-19 00:52:46', '2026-01-19 00:52:46'),
(242, 29, 11, 'No, I prefer being appreciated privately', '2026-01-19 00:52:46', '2026-01-19 00:52:46'),
(243, 29, 12, 'Yes, I love leading people and influence them', '2026-01-19 00:52:46', '2026-01-19 00:52:46'),
(244, 29, 13, 'Yes, I like to compete and achieve top positions in my job', '2026-01-19 00:52:46', '2026-01-19 00:52:46'),
(245, 29, 14, 'Yes, I enjoy making significant decisions that impact my team, company or industry', '2026-01-19 00:52:46', '2026-01-19 00:52:46'),
(246, 29, 15, 'Yes, I enjoy technical role requiring specialized skills in one area.', '2026-01-19 00:52:46', '2026-01-19 00:52:46'),
(247, 29, 16, 'No, I prefer roles with minimal conflict where I won’t be faced with negative opinions of people about me', '2026-01-19 00:52:46', '2026-01-19 00:52:46'),
(248, 31, 2, 'Yes, I am highly money motivated.', '2026-01-19 04:52:18', '2026-01-19 04:52:18'),
(249, 31, 3, 'Yes, I prefer a stable and predictable career path', '2026-01-19 04:52:18', '2026-01-19 04:52:18'),
(250, 31, 5, 'Yes, I don’t mind being away from family time to time', '2026-01-19 04:52:18', '2026-01-19 04:52:18'),
(251, 31, 4, 'No, I would like to get back home after working hours with a balanced life', '2026-01-19 04:52:18', '2026-01-19 04:52:18'),
(252, 31, 7, 'No, I don’t enjoy lots of public interaction', '2026-01-19 04:52:18', '2026-01-19 04:52:18'),
(253, 31, 16, 'No, I prefer roles with minimal conflict where I won’t be faced with negative opinions of people about me', '2026-01-19 04:52:18', '2026-01-19 04:52:18'),
(254, 31, 6, 'Yes, I love being around people and working together', '2026-01-19 04:52:18', '2026-01-19 04:52:18'),
(255, 31, 8, 'No, I prefer a balanced work pressure environment', '2026-01-19 04:52:18', '2026-01-19 04:52:18'),
(256, 31, 9, 'Yes, I like moving around a lot during my work and being in the field', '2026-01-19 04:52:18', '2026-01-19 04:52:18'),
(257, 31, 12, 'No, I feel very anxious leading people', '2026-01-19 04:52:18', '2026-01-19 04:52:18'),
(258, 31, 13, 'No, I prefer a work environment where everyone is treated equally and collaboration is emphasized over competition', '2026-01-19 04:52:18', '2026-01-19 04:52:18'),
(259, 31, 14, 'No, I prefer following established guidelines from an expert', '2026-01-19 04:52:18', '2026-01-19 04:52:18'),
(260, 31, 15, 'Yes, I enjoy technical role requiring specialized skills in one area.', '2026-01-19 04:52:18', '2026-01-19 04:52:18'),
(261, 31, 10, 'Yes, I love being outdoors all the time and don’t like being confined to an office', '2026-01-19 04:52:19', '2026-01-19 04:52:19'),
(262, 31, 11, 'No, I prefer being appreciated privately', '2026-01-19 04:52:19', '2026-01-19 04:52:19'),
(263, 33, 2, 'Yes, I am highly money motivated.', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(264, 33, 2, 'Yes, I am highly money motivated.', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(265, 33, 3, 'Yes, I prefer a stable and predictable career path', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(266, 33, 4, 'No, I would like to get back home after working hours with a balanced life', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(267, 33, 5, 'Yes, I don’t mind being away from family time to time', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(268, 33, 6, 'Yes, I love being around people and working together', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(269, 33, 7, 'Yes, I love talking to lots of strangers and speaking publicly', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(270, 33, 9, 'Yes, I like moving around a lot during my work and being in the field', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(271, 33, 8, 'No, I prefer a balanced work pressure environment', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(272, 33, 10, 'No, I prefer being confined to an office environment with a predictable day', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(273, 33, 11, 'Yes, I love being recognized publicly', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(274, 33, 12, 'Yes, I love leading people and influence them', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(275, 33, 11, 'Yes, I love being recognized publicly', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(276, 33, 13, 'Yes, I like to compete and achieve top positions in my job', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(277, 33, 14, 'Yes, I enjoy making significant decisions that impact my team, company or industry', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(278, 33, 15, 'Yes, I enjoy technical role requiring specialized skills in one area.', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(279, 33, 16, 'Yes, I enjoy conflict resolution and negotiation which may involve tense discussions', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(280, 33, 16, 'Yes, I enjoy conflict resolution and negotiation which may involve tense discussions', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(281, 33, 16, 'Yes, I enjoy conflict resolution and negotiation which may involve tense discussions', '2026-01-21 01:02:17', '2026-01-21 01:02:17'),
(282, 34, 2, 'Yes, I am highly money motivated.', '2026-01-21 03:34:13', '2026-01-21 03:34:13'),
(283, 34, 3, 'Yes, I prefer a stable and predictable career path', '2026-01-21 03:34:13', '2026-01-21 03:34:13'),
(284, 34, 4, 'No, I would like to get back home after working hours with a balanced life', '2026-01-21 03:34:13', '2026-01-21 03:34:13'),
(285, 34, 5, 'No, I prefer always staying close to my family', '2026-01-21 03:34:13', '2026-01-21 03:34:13'),
(286, 34, 6, 'Yes, I love being around people and working together', '2026-01-21 03:34:13', '2026-01-21 03:34:13'),
(287, 34, 7, 'Yes, I love talking to lots of strangers and speaking publicly', '2026-01-21 03:34:13', '2026-01-21 03:34:13'),
(288, 34, 8, 'No, I prefer a balanced work pressure environment', '2026-01-21 03:34:13', '2026-01-21 03:34:13'),
(289, 34, 9, 'No, I like a job that involves less physical activity', '2026-01-21 03:34:13', '2026-01-21 03:34:13'),
(290, 34, 10, 'No, I prefer being confined to an office environment with a predictable day', '2026-01-21 03:34:13', '2026-01-21 03:34:13'),
(291, 34, 11, 'Yes, I love being recognized publicly', '2026-01-21 03:34:13', '2026-01-21 03:34:13'),
(292, 34, 12, 'Yes, I love leading people and influence them', '2026-01-21 03:34:13', '2026-01-21 03:34:13'),
(293, 34, 13, 'Yes, I like to compete and achieve top positions in my job', '2026-01-21 03:34:13', '2026-01-21 03:34:13'),
(294, 34, 14, 'Yes, I enjoy making significant decisions that impact my team, company or industry', '2026-01-21 03:34:13', '2026-01-21 03:34:13'),
(295, 34, 15, 'Yes, I enjoy technical role requiring specialized skills in one area.', '2026-01-21 03:34:13', '2026-01-21 03:34:13'),
(296, 34, 16, 'Yes, I enjoy conflict resolution and negotiation which may involve tense discussions', '2026-01-21 03:34:13', '2026-01-21 03:34:13'),
(297, 35, 2, 'Yes, I am highly money motivated.', '2026-01-21 04:12:05', '2026-01-21 04:12:05'),
(298, 35, 3, 'Yes, I prefer a stable and predictable career path', '2026-01-21 04:12:05', '2026-01-21 04:12:05'),
(299, 35, 4, 'No, I would like to get back home after working hours with a balanced life', '2026-01-21 04:12:05', '2026-01-21 04:12:05'),
(300, 35, 5, 'Yes, I don’t mind being away from family time to time', '2026-01-21 04:12:05', '2026-01-21 04:12:05'),
(301, 35, 6, 'Yes, I love being around people and working together', '2026-01-21 04:12:05', '2026-01-21 04:12:05'),
(302, 35, 7, 'Yes, I love talking to lots of strangers and speaking publicly', '2026-01-21 04:12:05', '2026-01-21 04:12:05'),
(303, 35, 8, 'Yes, I enjoy high pressure work environments', '2026-01-21 04:12:05', '2026-01-21 04:12:05'),
(304, 35, 9, 'Yes, I like moving around a lot during my work and being in the field', '2026-01-21 04:12:05', '2026-01-21 04:12:05'),
(305, 35, 10, 'No, I prefer being confined to an office environment with a predictable day', '2026-01-21 04:12:05', '2026-01-21 04:12:05'),
(306, 35, 11, 'Yes, I love being recognized publicly', '2026-01-21 04:12:05', '2026-01-21 04:12:05'),
(307, 35, 12, 'Yes, I love leading people and influence them', '2026-01-21 04:12:05', '2026-01-21 04:12:05'),
(308, 35, 13, 'No, I prefer a work environment where everyone is treated equally and collaboration is emphasized over competition', '2026-01-21 04:12:05', '2026-01-21 04:12:05'),
(309, 35, 14, 'Yes, I enjoy making significant decisions that impact my team, company or industry', '2026-01-21 04:12:05', '2026-01-21 04:12:05'),
(310, 35, 15, 'No, I prefer non-technical roles requiring broad skills sets.', '2026-01-21 04:12:05', '2026-01-21 04:12:05'),
(311, 35, 16, 'Yes, I enjoy conflict resolution and negotiation which may involve tense discussions', '2026-01-21 04:12:05', '2026-01-21 04:12:05'),
(312, 37, 2, 'No, I will still be happy with an average income if I am happy.', '2026-02-08 02:48:53', '2026-02-08 02:48:53'),
(313, 37, 3, 'Yes, I prefer a stable and predictable career path', '2026-02-08 02:48:53', '2026-02-08 02:48:53'),
(314, 37, 4, 'No, I would like to get back home after working hours with a balanced life', '2026-02-08 02:48:53', '2026-02-08 02:48:53'),
(315, 37, 5, 'Yes, I don’t mind being away from family time to time', '2026-02-08 02:48:53', '2026-02-08 02:48:53'),
(316, 37, 6, 'Yes, I love being around people and working together', '2026-02-08 02:48:53', '2026-02-08 02:48:53'),
(317, 37, 7, 'Yes, I love talking to lots of strangers and speaking publicly', '2026-02-08 02:48:53', '2026-02-08 02:48:53'),
(318, 37, 8, 'No, I prefer a balanced work pressure environment', '2026-02-08 02:48:53', '2026-02-08 02:48:53'),
(319, 37, 9, 'Yes, I like moving around a lot during my work and being in the field', '2026-02-08 02:48:53', '2026-02-08 02:48:53'),
(320, 37, 10, 'No, I prefer being confined to an office environment with a predictable day', '2026-02-08 02:48:53', '2026-02-08 02:48:53'),
(321, 37, 11, 'No, I prefer being appreciated privately', '2026-02-08 02:48:53', '2026-02-08 02:48:53'),
(322, 37, 12, 'Yes, I love leading people and influence them', '2026-02-08 02:48:53', '2026-02-08 02:48:53'),
(323, 37, 13, 'No, I prefer a work environment where everyone is treated equally and collaboration is emphasized over competition', '2026-02-08 02:48:53', '2026-02-08 02:48:53'),
(324, 37, 14, 'No, I prefer following established guidelines from an expert', '2026-02-08 02:48:53', '2026-02-08 02:48:53'),
(325, 37, 15, 'Yes, I enjoy technical role requiring specialized skills in one area.', '2026-02-08 02:48:53', '2026-02-08 02:48:53'),
(326, 37, 16, 'Yes, I enjoy conflict resolution and negotiation which may involve tense discussions', '2026-02-08 02:48:53', '2026-02-08 02:48:53');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_allowed_ips`
--
ALTER TABLE `admin_allowed_ips`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_allowed_ips_ip_unique` (`ip`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `common_departments`
--
ALTER TABLE `common_departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `industries`
--
ALTER TABLE `industries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `sub_departments`
--
ALTER TABLE `sub_departments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_departments_industry_id_foreign` (`industry_id`),
  ADD KEY `sub_departments_department_id_foreign` (`department_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_challenge_data`
--
ALTER TABLE `user_challenge_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_challenge_data_user_id_foreign` (`user_id`),
  ADD KEY `user_challenge_data_industry_id_foreign` (`industry_id`),
  ADD KEY `user_challenge_data_department_id_foreign` (`department_id`);

--
-- Indexes for table `user_questionnaire_answers`
--
ALTER TABLE `user_questionnaire_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_questionnaire_answers_user_id_foreign` (`user_id`);

--
-- Indexes for table `user_submitted_answers`
--
ALTER TABLE `user_submitted_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_submitted_answers_user_id_foreign` (`user_id`),
  ADD KEY `user_submitted_answers_question_id_foreign` (`question_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_allowed_ips`
--
ALTER TABLE `admin_allowed_ips`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `common_departments`
--
ALTER TABLE `common_departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=193;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `industries`
--
ALTER TABLE `industries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=252;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sub_departments`
--
ALTER TABLE `sub_departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=461;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `user_challenge_data`
--
ALTER TABLE `user_challenge_data`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=476;

--
-- AUTO_INCREMENT for table `user_questionnaire_answers`
--
ALTER TABLE `user_questionnaire_answers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `user_submitted_answers`
--
ALTER TABLE `user_submitted_answers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=327;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sub_departments`
--
ALTER TABLE `sub_departments`
  ADD CONSTRAINT `sub_departments_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sub_departments_industry_id_foreign` FOREIGN KEY (`industry_id`) REFERENCES `industries` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_challenge_data`
--
ALTER TABLE `user_challenge_data`
  ADD CONSTRAINT `user_challenge_data_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_challenge_data_industry_id_foreign` FOREIGN KEY (`industry_id`) REFERENCES `industries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_challenge_data_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_questionnaire_answers`
--
ALTER TABLE `user_questionnaire_answers`
  ADD CONSTRAINT `user_questionnaire_answers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_submitted_answers`
--
ALTER TABLE `user_submitted_answers`
  ADD CONSTRAINT `user_submitted_answers_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `user_questionnaire_answers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_submitted_answers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
