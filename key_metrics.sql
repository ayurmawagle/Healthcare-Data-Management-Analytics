

-- 1. Total Number of Patients

SELECT COUNT(*) AS total_patient FROM Patient;

-- 2. Total Admissions by Admission Type

SELECT AdmissionType, COUNT(AdmissionID) AS admission_count
FROM Admission
GROUP BY AdmissionType
ORDER BY COUNT(AdmissionType) DESC;


-- 3. Most Common Medical Conditions
