USE health_db;

-- 1. Average Length of Stay by Medical Condition

SELECT m.ConditionID, m.Condition, AVG(a.LengthofStay) AS LengthofStay
FROM Admission AS a
JOIN MedicalCondition AS m ON a.ConditionID = m.ConditionID
GROUP BY m.ConditionID, m.Condition
ORDER BY LengthofStay DESC
;

-- 2. Doctor Workload

SELECT TOP 10 d.DoctorID, d.DoctorName, COUNT(a.AdmissionID) as admission_count
FROM Admission AS a
JOIN Doctor AS d ON a.DoctorID = d.DoctorID
GROUP BY d.DoctorID, d.DoctorName
ORDER BY admission_count DESC
;

-- 3. Hospital Workload

SELECT TOP 10 h.HospitalID, h.HospitalName, COUNT(a.AdmissionID) AS count_admission
FROM Admission AS a
Join Hospital AS h ON a.HospitalID = h.HospitalID
GROUP BY h.HospitalID, h.HospitalName
ORDER BY count_admission DESC
;


-- 4. Admission per month with running total

SELECT MIN(DateOfAdmission),
		MAX(DateOfAdmission)	
FROM Admission;

WITH MonthlyAdmission AS (
	SELECT 
		FORMAT(DateOfAdmission, 'yyyy-MM' ) AS YearMonth,
		COUNT(*) AS AdmissionCount
	FROM Admission
	GROUP BY FORMAT(DateOfAdmission, 'yyyy-MM' )
)
SELECT YearMonth, 
		AdmissionCount, 
		SUM(AdmissionCount) OVER(ORDER BY YearMonth ROWS UNBOUNDED PRECEDING) AS RollingTotal
FROM MonthlyAdmission
ORDER BY YearMonth;

-- 5. Repeating patients

SELECT 
    a.PatientID, 
    p.Name, 
    COUNT(*) AS AdmissionCount
FROM Admission AS a
JOIN Patient AS p ON a.PatientID = p.PatientID
GROUP BY a.PatientID, p.Name
HAVING COUNT(*) > 1
ORDER BY AdmissionCount DESC;

 -- 6.Rank hospitals by readmission rate (patients with multiple admissions)

-- 7. For each patient, what is the average number of days between their admissions?


-- 8. Which patients have been admitted in the same month across multiple years?

-- 9. Identify the top 3 medications used per condition.

SELECT 
	C.CONDITIONID,
	C.CONDITION,
	M.MEDICATIONID,
	M.MEDICATION,

FROM MEDICALCONDITION AS C
JOIN PATI
JOIN MEDICATION AS M 
ON C.


;






















