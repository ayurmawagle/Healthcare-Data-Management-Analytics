CREATE DATABASE health_db;

USE health_db;

CREATE TABLE Patient(
PatientID INT IDENTITY(1,1) PRIMARY KEY,
Name VARCHAR(100),
Age TINYINT,
Gender VARCHAR(20),
BloodGroup VARCHAR(5)
);

CREATE TABLE Admission(
AdmissionID INT IDENTITY(1,1) PRIMARY KEY,
AdmissionType VARCHAR(50),
RoomNumber INT,
DateOfAdmission DATETIME,
DischargeDate DATETIME,
LengthofStay INT
);

CREATE TABLE MedicalCondition(
ConditionID INT IDENTITY(1,1) PRIMARY KEY,
Condition VARCHAR(100)
);

CREATE TABLE Doctor(
DoctorID INT IDENTITY(1,1) PRIMARY KEY,
DoctorName VARCHAR(100)
);

CREATE TABLE Hospital(
HospitalID INT IDENTITY(1,1) PRIMARY KEY,
HospitalName VARCHAR(100)
);

CREATE TABLE InsuranceProvider(
InsuranceID INT IDENTITY(1,1) PRIMARY KEY,
InsuranceName VARCHAR(100)
);

CREATE TABLE Medication(
MedicationID INT IDENTITY(1,1) PRIMARY KEY,
Medication VARCHAR(100)
);

CREATE TABLE TestResult(
TestID INT IDENTITY(1,1) PRIMARY KEY,
Result VARCHAR(100),
);

CREATE TABLE Billing(
BillID INT IDENTITY(1,1) PRIMARY KEY,
BillingAmount MONEY
);


--Importing csv into tables

USE health_db;
GO

INSERT INTO Patient (Name, Age, Gender, BloodGroup)
SELECT DISTINCT 
	Name, 
	Age, 
	Gender, 
	[Blood_Type]
FROM staging_data;


INSERT INTO Admission( AdmissionType, RoomNumber, DateOfAdmission, DischargeDate, LengthofStay)
SELECT DISTINCT
	Admission_Type,
    Room_Number,
    Date_of_Admission,
    Discharge_Date,
    Length_of_Stay
FROM staging_data;


INSERT INTO MedicalCondition(Condition)
SELECT DISTINCT Medical_Condition
FROM staging_data;

INSERT INTO Doctor(DoctorName)
SELECT DISTINCT Doctor
FROM staging_data;

INSERT INTO Hospital(HospitalName)
SELECT DISTINCT Hospital
FROM staging_data;


INSERT INTO InsuranceProvider(InsuranceName)
SELECT DISTINCT Insurance_Provider
FROM staging_data;

INSERT INTO Medication(Medication)
SELECT DISTINCT Medication
FROM staging_data;


INSERT INTO TestResult(Result)
SELECT DISTINCT Test_Results
FROM staging_data;


INSERT INTO Billing(BillingAmount )
SELECT DISTINCT Billing_Amount 
FROM staging_data;



-- Adding foreign key to tables

-- 1. Joining Patients and Admission Table using PatientID

ALTER TABLE Admission
ADD PatientID INT;

ALTER TABLE Admission
ADD CONSTRAINT FK_Admission_Patient FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);

UPDATE a
SET a.PatientID = p.PatientID
FROM Admission AS a
JOIN staging_data AS s
	ON a.DateOfAdmission = s.Date_of_Admission
JOIN Patient AS p
	ON p.Name = s.Name AND
	p.Age = s.Age AND
	p.Gender = s.Gender AND
	p.BloodGroup = s.Blood_Type
;


-- Joining Admission and Medical Condition Table

ALTER TABLE Admission
ADD ConditionID INT;

ALTER TABLE Admission
ADD CONSTRAINT FK_Admission_Condition FOREIGN KEY (ConditionID) REFERENCES MedicalCondition(ConditionID)
;


INSERT INTO MedicalCondition (Condition)
SELECT DISTINCT s.Medical_Condition
FROM staging_data s
LEFT JOIN MedicalCondition m ON s.Medical_Condition = m.Condition
WHERE m.ConditionID IS NULL;


UPDATE a
SET a.ConditionID = m.ConditionID
FROM Admission AS a 
JOIN staging_data AS s
	ON a.DateOfAdmission = s.Date_of_Admission
	AND a.RoomNumber = s.Room_Number
	AND a.AdmissionType = s.Admission_Type
JOIN MedicalCondition AS m
	ON m.Condition = s.Medical_Condition
;

-- Joining Admission and Hospital Table

ALTER TABLE Admission
ADD HospitalID INT;

ALTER TABLE Admission
ADD CONSTRAINT FK_Admission_Hospital FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID)
;

INSERT INTO Hospital (HospitalName)
SELECT DISTINCT s.Hospital
FROM staging_data s
LEFT JOIN Hospital h ON s.Hospital = h.HospitalName
WHERE h.HospitalID IS NULL;


UPDATE a
SET a.HospitalID = h.HospitalID
FROM Admission AS a 
JOIN staging_data AS s
	ON a.DateOfAdmission = s.Date_of_Admission
	AND a.RoomNumber = s.Room_Number
	AND a.AdmissionType = s.Admission_Type
JOIN Hospital AS h
	ON h.HospitalName = s.Hospital
;


-- Joining Admission and Doctor Table
