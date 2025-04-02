
USE health_db;

-- 1. Total Number of Patients

SELECT COUNT(*) AS total_patient FROM Patient;

-- 2. Total Admissions by Admission Type

SELECT AdmissionType, COUNT(AdmissionID) AS admission_count
FROM Admission
GROUP BY AdmissionType
ORDER BY COUNT(AdmissionType) DESC;


-- 3. Most Common Medical Conditions

SELECT m.Condition, COUNT(*) AS frequency
FROM Admission AS a
JOIN MedicalCondition AS m ON a.ConditionID = m.ConditionID
GROUP BY m.Condition
ORDER BY frequency DESC
;


-- 4. Average Billing Amount

SELECT AVG(BillingAmount) AS Average_Billing_Amount FROM Billing;

-- 5. Average Length of Stay by Medical Condition

SELECT m.ConditionID, m.Condition, AVG(a.LengthofStay) AS average_stay
FROM Admission AS a
JOIN MedicalCondition AS m
	ON a.ConditionID = m.ConditionID
GROUP BY m.ConditionID, m.Condition
ORDER BY average_stay DESC
;


