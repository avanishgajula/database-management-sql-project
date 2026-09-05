-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 06, 2026 at 12:31 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apc_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `consultation`
--

CREATE TABLE `consultation` (
  `PSSN` char(9) NOT NULL,
  `PId` int(11) NOT NULL,
  `CDate` date NOT NULL,
  `CTime` time NOT NULL,
  `FDate` date DEFAULT NULL,
  `FTime` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `consultation`
--

INSERT INTO `consultation` (`PSSN`, `PId`, `CDate`, `CTime`, `FDate`, `FTime`) VALUES
('111-22-33', 1, '2025-08-01', '06:00:00', '0000-00-00', '06:30:00'),
('111-22-33', 1, '2025-08-08', '06:30:00', NULL, NULL),
('123-45-67', 2, '2025-08-11', '13:30:00', NULL, NULL),
('222-33-44', 2, '2025-08-02', '08:30:00', NULL, NULL),
('234-56-78', 3, '2025-08-12', '16:00:00', NULL, NULL),
('333-44-55', 3, '2025-08-03', '10:00:00', NULL, NULL),
('345-67-89', 4, '2025-08-13', '19:30:00', NULL, NULL),
('444-55-66', 4, '2025-08-04', '14:30:00', NULL, NULL),
('555-66-77', 5, '2025-08-05', '09:00:00', NULL, NULL),
('666-77-88', 6, '2025-08-06', '15:30:00', NULL, NULL),
('777-88-99', 7, '2025-08-07', '18:00:00', '0000-00-00', '06:00:00'),
('777-88-99', 7, '2025-08-14', '06:00:00', NULL, NULL),
('888-99-00', 8, '2025-08-09', '07:30:00', NULL, NULL),
('999-00-11', 1, '2025-08-10', '12:00:00', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `coveragepolicy`
--

CREATE TABLE `coveragepolicy` (
  `PoId` int(11) NOT NULL,
  `PoName` varchar(120) NOT NULL,
  `PoType` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `coveragepolicy`
--

INSERT INTO `coveragepolicy` (`PoId`, `PoName`, `PoType`) VALUES
(1, 'Cigna', 'HMO'),
(2, 'Humana', 'PPO'),
(3, 'Aetna', 'EPO'),
(4, 'Molina Healthcare', 'HMO'),
(5, 'CVS Health', 'PPO');

-- --------------------------------------------------------

--
-- Table structure for table `diagnosis`
--

CREATE TABLE `diagnosis` (
  `PSSN` char(9) NOT NULL,
  `PId` int(11) NOT NULL,
  `CDate` date NOT NULL,
  `CTime` time NOT NULL,
  `DiagnosisTxt` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `diagnosis`
--

INSERT INTO `diagnosis` (`PSSN`, `PId`, `CDate`, `CTime`, `DiagnosisTxt`) VALUES
('111-22-33', 1, '2025-08-01', '06:00:00', 'Coronary Artery Disease'),
('111-22-33', 1, '2025-08-08', '06:30:00', 'Post-surgical Follow-up'),
('123-45-67', 2, '2025-08-11', '13:30:00', 'Tendon Tear'),
('222-33-44', 2, '2025-08-02', '08:30:00', 'Cartilage Degeneration'),
('234-56-78', 3, '2025-08-12', '16:00:00', 'Asthma'),
('333-44-55', 3, '2025-08-03', '10:00:00', 'Seasonal Allergies'),
('345-67-89', 4, '2025-08-13', '19:30:00', 'Otitis Media'),
('444-55-66', 4, '2025-08-04', '14:30:00', 'Acute Bronchitis'),
('555-66-77', 5, '2025-08-05', '09:00:00', 'Appendicitis'),
('666-77-88', 6, '2025-08-06', '15:30:00', 'Hypertension'),
('777-88-99', 7, '2025-08-07', '18:00:00', 'Atrial Fibrillation'),
('777-88-99', 7, '2025-08-07', '18:00:00', 'Mitral Valve Prolapse'),
('777-88-99', 7, '2025-08-14', '06:00:00', 'Post-surgical Follow-up'),
('888-99-00', 8, '2025-08-09', '07:30:00', 'Femur Fracture'),
('999-00-11', 1, '2025-08-10', '12:00:00', 'Heart Murmur');

-- --------------------------------------------------------

--
-- Table structure for table `hospital`
--

CREATE TABLE `hospital` (
  `HId` int(11) NOT NULL,
  `HName` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hospital`
--

INSERT INTO `hospital` (`HId`, `HName`) VALUES
(1, 'All India Institute of Medical Sciences'),
(2, 'University of Tokyo Hospital'),
(3, 'Mayo Clinic'),
(4, 'Hospital Ángeles'),
(5, 'Shariati Hospital'),
(6, 'Ibn Sina Hospital'),
(7, 'Bir Hospital'),
(8, 'Bangabandhu Sheikh Mujib Medical University');

-- --------------------------------------------------------

--
-- Stand-in structure for view `hospitallocationsummary`
-- (See below for the actual view)
--
CREATE TABLE `hospitallocationsummary` (
`HospitalName` varchar(120)
,`Locations` mediumtext
);

-- --------------------------------------------------------

--
-- Table structure for table `hospital_location`
--

CREATE TABLE `hospital_location` (
  `HId` int(11) NOT NULL,
  `Location` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hospital_location`
--

INSERT INTO `hospital_location` (`HId`, `Location`) VALUES
(1, 'Arlington'),
(2, 'Plano'),
(3, 'Grapevine'),
(4, 'Denton'),
(5, 'Irving'),
(6, 'Arlington'),
(7, 'Plano'),
(8, 'Grapevine');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `PSSN` char(9) NOT NULL,
  `PName` varchar(100) NOT NULL,
  `Gender` char(1) DEFAULT NULL,
  `Address` varchar(150) DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `PId` int(11) DEFAULT NULL,
  `PoId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`PSSN`, `PName`, `Gender`, `Address`, `DateOfBirth`, `PId`, `PoId`) VALUES
('111-22-33', 'John Smith', 'M', '123 Maple St', '1985-04-15', 1, 1),
('123-45-67', 'David Brown', 'M', '951 Aspen Cir', '1978-06-11', 2, 5),
('222-33-44', 'Maria Lopez', 'F', '456 Oak Ave', '1985-04-23', 2, 2),
('222334455', 'Timmy Jones', 'M', NULL, '2020-01-15', 601, NULL),
('234-56-78', 'Lina Farah', 'F', '147 Hickory Dr', '1999-05-27', 3, 1),
('333-44-55', 'Akira Tanaka', 'M', '789 Pine Rd', '1975-03-10', 3, 3),
('345-67-89', 'Oscar Martinez', 'M', '369 Palm St', '1986-02-10', 4, 2),
('444-55-66', 'Sara Johnson', 'F', '321 Birch Blvd', '2000-05-11', 4, 4),
('555-66-77', 'Hossein Rezaei', 'M', '654 Cedar Dr', '1968-08-12', 5, 5),
('666-77-88', 'Ali Kareem', 'M', '987 Spruce Ct', '1982-12-12', 6, 1),
('777-88-99', 'Bikash Thapa', 'M', '159 Elm St', '1995-09-09', 7, 2),
('888-99-00', 'Anika Rahman', 'F', '753 Willow Ln', '1988-01-15', 8, 3),
('999-00-11', 'Emily Davis', 'F', '852 Fir Pl', '1992-05-12', 1, 4);

-- --------------------------------------------------------

--
-- Stand-in structure for view `patientagedistribution`
-- (See below for the actual view)
--
CREATE TABLE `patientagedistribution` (
`PatientName` varchar(100)
,`Age` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `physician`
--

CREATE TABLE `physician` (
  `PId` int(11) NOT NULL,
  `FName` varchar(60) NOT NULL,
  `LName` varchar(60) NOT NULL,
  `MInitial` char(1) DEFAULT NULL,
  `HId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `physician`
--

INSERT INTO `physician` (`PId`, `FName`, `LName`, `MInitial`, `HId`) VALUES
(1, 'Naresh', 'Trehan', 'K', 1),
(2, 'Shinya', 'Yamanaka', 'H', 2),
(3, 'Anthony', 'Fauci', 'S', 3),
(4, 'José', 'Halabe', 'C', 4),
(5, 'Ali', 'Jafarian', 'H', 5),
(6, 'Mohammed', 'Al-Obaidi', 'R', 6),
(7, 'Ramesh', 'Koirala', 'P', 7),
(8, 'Kanak', 'Kanti', 'B', 8),
(601, 'Emily', 'White', 'C', 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `physicianspecialitycount`
-- (See below for the actual view)
--
CREATE TABLE `physicianspecialitycount` (
`PhysicianFullName` varchar(123)
,`SpecialityCount` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `physician_speciality`
--

CREATE TABLE `physician_speciality` (
  `PId` int(11) NOT NULL,
  `SName` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `physician_speciality`
--

INSERT INTO `physician_speciality` (`PId`, `SName`) VALUES
(1, 'Cardiothoracic Surgery'),
(2, 'Regenerative Medicine'),
(3, 'Immunology'),
(4, 'Pediatrics'),
(5, 'General Surgery'),
(6, 'Internal Medicine'),
(7, 'Cardiothoracic Surgery'),
(7, 'Neurosurgery'),
(8, 'General Surgery'),
(8, 'Orthopedic Surgery'),
(601, 'Pediatrics');

-- --------------------------------------------------------

--
-- Table structure for table `speciality`
--

CREATE TABLE `speciality` (
  `SName` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `speciality`
--

INSERT INTO `speciality` (`SName`) VALUES
('Cardiothoracic Surgery'),
('General Surgery'),
('Immunology'),
('Internal Medicine'),
('Neurosurgery'),
('Orthopedic Surgery'),
('Pediatrics'),
('Regenerative Medicine');

-- --------------------------------------------------------

--
-- Structure for view `hospitallocationsummary`
--
DROP TABLE IF EXISTS `hospitallocationsummary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `hospitallocationsummary`  AS SELECT `h`.`HName` AS `HospitalName`, group_concat(distinct `hl`.`Location` order by `hl`.`Location` ASC separator ',') AS `Locations` FROM (`hospital` `h` join `hospital_location` `hl` on(`hl`.`HId` = `h`.`HId`)) GROUP BY `h`.`HId`, `h`.`HName` ;

-- --------------------------------------------------------

--
-- Structure for view `patientagedistribution`
--
DROP TABLE IF EXISTS `patientagedistribution`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `patientagedistribution`  AS SELECT `p`.`PName` AS `PatientName`, timestampdiff(YEAR,`p`.`DateOfBirth`,curdate()) AS `Age` FROM `patient` AS `p` ;

-- --------------------------------------------------------

--
-- Structure for view `physicianspecialitycount`
--
DROP TABLE IF EXISTS `physicianspecialitycount`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `physicianspecialitycount`  AS SELECT concat(`ph`.`FName`,' ',ifnull(`ph`.`MInitial`,''),' ',`ph`.`LName`) AS `PhysicianFullName`, count(distinct `ps`.`SName`) AS `SpecialityCount` FROM (`physician` `ph` left join `physician_speciality` `ps` on(`ps`.`PId` = `ph`.`PId`)) GROUP BY `ph`.`PId` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `consultation`
--
ALTER TABLE `consultation`
  ADD PRIMARY KEY (`PSSN`,`PId`,`CDate`,`CTime`),
  ADD KEY `fk_consult_physician` (`PId`);

--
-- Indexes for table `coveragepolicy`
--
ALTER TABLE `coveragepolicy`
  ADD PRIMARY KEY (`PoId`);

--
-- Indexes for table `diagnosis`
--
ALTER TABLE `diagnosis`
  ADD PRIMARY KEY (`PSSN`,`PId`,`CDate`,`CTime`,`DiagnosisTxt`);

--
-- Indexes for table `hospital`
--
ALTER TABLE `hospital`
  ADD PRIMARY KEY (`HId`);

--
-- Indexes for table `hospital_location`
--
ALTER TABLE `hospital_location`
  ADD PRIMARY KEY (`HId`,`Location`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`PSSN`),
  ADD KEY `fk_patient_physician` (`PId`),
  ADD KEY `fk_patient_coverage` (`PoId`);

--
-- Indexes for table `physician`
--
ALTER TABLE `physician`
  ADD PRIMARY KEY (`PId`),
  ADD KEY `idx_physician_hid` (`HId`);

--
-- Indexes for table `physician_speciality`
--
ALTER TABLE `physician_speciality`
  ADD PRIMARY KEY (`PId`,`SName`),
  ADD KEY `fk_ps_speciality` (`SName`);

--
-- Indexes for table `speciality`
--
ALTER TABLE `speciality`
  ADD PRIMARY KEY (`SName`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `consultation`
--
ALTER TABLE `consultation`
  ADD CONSTRAINT `fk_consult_patient` FOREIGN KEY (`PSSN`) REFERENCES `patient` (`PSSN`),
  ADD CONSTRAINT `fk_consult_physician` FOREIGN KEY (`PId`) REFERENCES `physician` (`PId`);

--
-- Constraints for table `diagnosis`
--
ALTER TABLE `diagnosis`
  ADD CONSTRAINT `fk_diag_consult` FOREIGN KEY (`PSSN`,`PId`,`CDate`,`CTime`) REFERENCES `consultation` (`PSSN`, `PId`, `CDate`, `CTime`);

--
-- Constraints for table `hospital_location`
--
ALTER TABLE `hospital_location`
  ADD CONSTRAINT `fk_hloc_hospital` FOREIGN KEY (`HId`) REFERENCES `hospital` (`HId`);

--
-- Constraints for table `patient`
--
ALTER TABLE `patient`
  ADD CONSTRAINT `fk_patient_coverage` FOREIGN KEY (`PoId`) REFERENCES `coveragepolicy` (`PoId`),
  ADD CONSTRAINT `fk_patient_physician` FOREIGN KEY (`PId`) REFERENCES `physician` (`PId`);

--
-- Constraints for table `physician`
--
ALTER TABLE `physician`
  ADD CONSTRAINT `fk_physician_hospital` FOREIGN KEY (`HId`) REFERENCES `hospital` (`HId`);

--
-- Constraints for table `physician_speciality`
--
ALTER TABLE `physician_speciality`
  ADD CONSTRAINT `fk_ps_physician` FOREIGN KEY (`PId`) REFERENCES `physician` (`PId`),
  ADD CONSTRAINT `fk_ps_speciality` FOREIGN KEY (`SName`) REFERENCES `speciality` (`SName`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
