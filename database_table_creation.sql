
CREATE DATABASE healthcare_db;

USE healthcare_db;

CREATE TABLE Patients(
PatientID INT IDENTITY(1,1) PRIMARY KEY,
Name VARCHAR(100),
Age TINYINT,
Gender VARCHAR(20),
BloodGroup VARCHAR(5)
);


CREATE TABLE Admission(
AdmissionID INT IDENTITY(1,1) PRIMARY KEY,
PatientID INT,
AdmissionType VARCHAR(50),
RoomNumber INT,
DateOfAdmission DATETIME,
DischargeDate DATETIME,
LengthOfStay INT,

CONSTRAINT FK_admission_patient FOREIGN KEY (PatientID)
REFERENCES Patients(PatientID)
);

CREATE TABLE MedicalCondition(
ConditionID INT IDENTITY(1,1) PRIMARY KEY,
PatientID INT,
MedicalCondition VARCHAR(100),

CONSTRAINT FK_condition_patient FOREIGN KEY (PatientID)
REFERENCES Patients(PatientID)
);

CREATE TABLE Doctor(
DoctorID INT IDENTITY(1,1) PRIMARY KEY,
PatientID INT,
DoctorName VARCHAR(100),

CONSTRAINT FK_doctor_patient FOREIGN KEY (PatientID)
REFERENCES Patients(PatientID)
);

CREATE TABLE Hospital(
HospitalID INT IDENTITY(1,1) PRIMARY KEY,
AdmissionID INT,
HospitalName VARCHAR(100),

CONSTRAINT FK_hospital_admission FOREIGN KEY (AdmissionID)
REFERENCES Admission(AdmissionID)
);

CREATE TABLE InsuranceProvider(
InsuranceID INT IDENTITY(1,1) PRIMARY KEY,
InsuranceName VARCHAR(100)
);

CREATE TABLE Medication(
MedicationID INT IDENTITY(1,1) PRIMARY KEY,
PatientID INT,
Medication VARCHAR(100),

CONSTRAINT FK_medication_patient FOREIGN KEY (PatientID)
REFERENCES Patients(PatientID)
);

CREATE TABLE TestResult(
TestID INT IDENTITY(1,1) PRIMARY KEY,
PatientID INT,
TestResult VARCHAR(100),

CONSTRAINT FK_test_patient FOREIGN KEY (PatientID)
REFERENCES Patients(PatientID)
);

CREATE TABLE Billing(
BillID INT IDENTITY(1,1) PRIMARY KEY,
PatientID INT,
BillingAmount MONEY,
InsuranceID INT,

CONSTRAINT FK_bill_patient FOREIGN KEY (PatientID)
REFERENCES Patients(PatientID),

CONSTRAINT FK_bill_insurance FOREIGN KEY (InsuranceID)
REFERENCES InsuranceProvider(InsuranceID)
);