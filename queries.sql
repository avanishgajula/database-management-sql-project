-- ============================================================
-- Arlington Physicians / Coverage (apc_db) — Analysis Queries
-- Q1–Q16
-- ============================================================

USE apc_db;

-- Q1.B Retrieve the hospital names that are located in 'Arlington'.
-- Column headers: HospitalName
SELECT DISTINCT h.HName AS HospitalName
FROM hospital h
JOIN hospital_location hl ON hl.HId = h.HId
WHERE hl.Location = 'Arlington';


-- Q2.B List the patient names and their addresses for patients born after January 1, 1990.
-- Column headers: PatientName, Address
SELECT p.PName AS PatientName, p.Address AS Address
FROM patient p
WHERE p.DateOfBirth > '1990-01-01';


-- Q3.B Show the names of physicians whose last names start with 'K'.
-- Column headers: FirstName, LastName
SELECT FName AS FirstName, LName AS LastName
FROM physician
WHERE LName LIKE 'K%';


-- Q4.B Retrieve the names of all specialties in alphabetical order.
-- Column headers: SpecialityName
SELECT SName AS SpecialityName
FROM speciality
ORDER BY SName;


-- Q5.B Find the names of patients and their coverage policy type for those covered under 'Molina Healthcare'.
-- Column headers: PatientName, PolicyType
SELECT p.PName AS PatientName, cp.PoType AS PolicyType
FROM patient p
JOIN coveragepolicy cp ON cp.PoId = p.PoId
WHERE cp.PoName = 'Molina Healthcare';


-- Q6.B List the consultation dates and times for consultations held before 9:00 AM.
-- Column headers: ConsultationDate, ConsultationTime
SELECT CDate AS ConsultationDate, CTime AS ConsultationTime
FROM consultation
WHERE CTime < '09:00:00'
ORDER BY CDate, CTime;


-- Q7.B Show the hospital names and the count of physicians working in each hospital,
-- including hospitals with zero physicians.
-- Column headers: HospitalName, PhysicianCount
SELECT h.HName AS HospitalName, COUNT(ph.PId) AS PhysicianCount
FROM hospital h
LEFT JOIN physician ph ON ph.HId = h.HId
GROUP BY h.HId, h.HName
ORDER BY h.HName;


-- Q8.B List all patients along with the names of the physicians they are assigned to.
-- Column headers: PatientName, PhysicianName
SELECT p.PName AS PatientName,
       CONCAT(ph.FName, ' ', ph.LName) AS PhysicianName
FROM patient p
LEFT JOIN physician ph ON ph.PId = p.PId
ORDER BY p.PName;


-- Q9.B Retrieve the physician names and their hospital names where the physician's specialty
-- is 'General Surgery'.
-- Column headers: PhysicianName, HospitalName
SELECT CONCAT(ph.FName, ' ', ph.LName) AS PhysicianName,
       h.HName AS HospitalName
FROM physician_speciality ps
JOIN speciality s  ON s.SName = ps.SName
JOIN physician  ph ON ph.PId = ps.PId
JOIN hospital   h  ON h.HId  = ph.HId
WHERE s.SName = 'General Surgery'
ORDER BY PhysicianName;


-- Q10.B Display the patient names and consultation dates for consultations with no follow-up date.
-- Column headers: PatientName, ConsultationDate
SELECT DISTINCT p.PName AS PatientName, c.CDate AS ConsultationDate
FROM consultation c
JOIN patient p ON p.PSSN = c.PSSN
WHERE c.FDate IS NULL
ORDER BY p.PName, c.CDate;


-- Q11.B Find the coverage policies and the number of distinct physicians whose patients
-- are enrolled under each policy.
-- Column headers: PolicyName, DistinctPhysicians
SELECT cp.PoName AS PolicyName,
       COUNT(DISTINCT p.PId) AS DistinctPhysicians
FROM coveragepolicy cp
LEFT JOIN patient p ON p.PoId = cp.PoId
GROUP BY cp.PoId, cp.PoName
ORDER BY cp.PoName;


-- Q12.B Show the names of patients who have had exactly two consultations.
-- Column headers: PatientName
SELECT p.PName AS PatientName
FROM patient p
JOIN consultation c ON c.PSSN = p.PSSN
GROUP BY p.PSSN, p.PName
HAVING COUNT(*) = 2
ORDER BY p.PName;


-- Q13.B List the physicians who have treated patients from more than one coverage policy.
-- Column headers: PId, PhysicianName
SELECT ph.PId,
       CONCAT(ph.FName, ' ', ph.LName) AS PhysicianName
FROM physician ph
JOIN consultation c ON c.PId = ph.PId
JOIN patient p      ON p.PSSN = c.PSSN
GROUP BY ph.PId, PhysicianName
HAVING COUNT(DISTINCT p.PoId) > 1
ORDER BY PhysicianName;


-- Q14.B Find the hospital(s) with the highest number of distinct specialties among its physicians.
-- Column headers: HospitalName, DistinctSpecialities
WITH hs AS (
    SELECT h.HId, h.HName, COUNT(DISTINCT ps.SName) AS DistinctSpecialities
    FROM hospital h
    JOIN physician ph ON ph.HId = h.HId
    JOIN physician_speciality ps ON ps.PId = ph.PId
    GROUP BY h.HId, h.HName
),
mx AS (SELECT MAX(DistinctSpecialities) AS m FROM hs)
SELECT hs.HName AS HospitalName, hs.DistinctSpecialities
FROM hs JOIN mx ON hs.DistinctSpecialities = mx.m;


-- Q15.B Retrieve the top 3 physicians who have conducted the most consultations in August 2025.
-- Column headers: PhysicianName, ConsultationsInAug2025
SELECT CONCAT(ph.FName, ' ', ph.LName) AS PhysicianName,
       COUNT(*) AS ConsultationsInAug2025
FROM consultation c
JOIN physician ph ON ph.PId = c.PId
WHERE c.CDate >= '2025-08-01' AND c.CDate < '2025-09-01'
GROUP BY ph.PId, PhysicianName
ORDER BY ConsultationsInAug2025 DESC, PhysicianName
LIMIT 3;


-- Q16.B Calculate the average number of consultations per patient in August 2025.
-- Column headers: AvgConsultationsPerPatient_Aug2025
SELECT AVG(t.cnt) AS AvgConsultationsPerPatient_Aug2025
FROM (
    SELECT c.PSSN, COUNT(*) AS cnt
    FROM consultation c
    WHERE c.CDate >= '2025-08-01' AND c.CDate < '2025-09-01'
    GROUP BY c.PSSN
) AS t;
