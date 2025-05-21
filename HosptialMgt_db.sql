-- DATABASE CREATION
DROP DATABASE IF EXISTS HospitalMgt_db;

-- Create Database For Hospital Management
CREATE DATABASE HospitalMgt_db
DEFAULT CHARACTER SET utf8mb4;

-- Makes the database active
USE HospitalMgt_db;

-- TABLE CREATIONS

-- Departments Table (MUST BE CREATED FIRST DUE TO FOREIGN KEY DEPENDENCY)
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- Doctors Table
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialty VARCHAR(100),
    DepartmentID INT,
    Phone VARCHAR(15),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Patients Table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DOB DATE, 
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female')), 
    Phone VARCHAR(15),
    Address TEXT
);

-- Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Status VARCHAR(20) DEFAULT 'Scheduled', -- Added a default status
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Medications Table
CREATE TABLE Medications (
    MedicationID INT PRIMARY KEY AUTO_INCREMENT,
    MedicationName VARCHAR(100) NOT NULL UNIQUE, 
    Dosage VARCHAR(50)
);

-- Prescriptions Table
CREATE TABLE Prescriptions (
    PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    AppointmentID INT NOT NULL,
    MedicationID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0), -- Quantity should be positive
    Notes TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
);

-- Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL CHECK (Amount >= 0), -- Amount should be non-negative
    PaymentDate DATE NOT NULL,
    PaymentMethod VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);


-- DATA INSERTION
-- Populating Departments Table 
INSERT INTO Departments (DepartmentName)
VALUES ('Cardiology'), ('Neurology'), ('Pediatrics'), ('Gynace'), ('Urology'), ('Radiology'), ('Oncology'), ('Dermatology'),('Orthopedics'), ('Psychiatry');

-- Populating Doctors Table 
INSERT INTO Doctors (FirstName, LastName, Specialty, DepartmentID, Phone)
VALUES ('John', 'Obasi','Cardiologist', 1, '08012345678'),
        ('Funsho', 'Ade', 'Neurology', 2, '08027140969'),
        ('Funsho', 'Ade', 'Pediatrics', 3,  '08027140969'),
        ('Mfon', 'Bassey', 'Gynace', 4, '08077111641'),
        ('Chika', 'Adigwe', 'Urology', 5, '08074969816'),
        ('Abdul', 'Tanko', 'Radiology', 6, '08039928626'),
        ('Gabice', 'Ada', 'Oncology', 7, '08048841022'),
        ('Joy', 'Ibe', 'Dermatology', 8, '08033109164'),
        ('Mike', 'Igu', 'Orthopedics', 9, '08028076520'),
        ('Iko', 'Adinde', 'Psychiatry', 10, '08055093659');

-- Populating Patients Table 
INSERT INTO Patients (FirstName, LastName, DOB, Gender, Phone, Address)
VALUES ('Jane', 'Udo', '1990-02-10', 'Female', '09012345678', 'Gwarinpa, Abuja'),
('Smith', 'John', '2010-10-07', 'Male', '09058181739', 'Katampe, Abuja'),
('Stella', 'Obanda', '1986-12-30', 'Female', '07098745678', 'Jabi, Abuja'),
('Japeth', 'Musa', '1970-05-20', 'Male', '08034560078', 'Utako, Abuja'),
('Clare', 'Omega', '1989-01-11', 'Female', '08104598000', 'Citec, Abuja'),
('Dami', 'Femi', '1988-03-18', 'Female', '07067490028', 'Kubwa, Abuja'),
('Daniel', 'Ekpo', '2008-02-21', 'Male', '08070687884', 'Dawaki, Abuja'),
('Aisha', 'Jibril', '1991-09-23', 'Female', '09086491097', 'Wuse, Abuja'),
('Rachel', 'Pius', '2005-04-02', 'Female', '07069450431', 'Katampe II, Abuja'),
('Mohammed', 'Umar', '2015-01-23', 'Male', '09077964503 ', 'LifeCamp, Abuja');

-- Populating Appointments Table 
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Status)
VALUES (1, 4, '2025-05-15 10:00:00', 'Scheduled'),
(3, 10, '2025-01-03 11:00:00', 'Cancelled'),
(2, 9, '2025-05-12 10:00:00', 'Completed'),
(1, 8, '2025-05-15 13:00:00', 'Scheduled'),
(5, 4, '2025-05-20 9:00:00', 'Scheduled'),
(6, 5, '2025-05-29 12:00:00', 'Scheduled'),
(9, 6, '2025-06-10 10:30:00', 'Scheduled'),
(10, 3, '2025-05-13 11:40:00', 'Cancelled'),
(4, 8, '2025-05-15 14:00:00', 'Scheduled'),
(8, 6, '2025-05-05 12:00:00', 'Completed');

-- Populating Medications Table 
INSERT INTO Medications (MedicationName, Dosage)
VALUES ('Paracetamol', '500mg'),
('Vitamin C', '132mg'),
('Ibuprofen',  '233mg'),
('Amoxicillin',  '256mg'),
('Metformin', '143mg'),
('Aspirin',  '225mg'),
('Anti_Malaria', '400mg'),
('Vitamin D', '125mcg'),
('Benylin', '150ml'),
('Augmentin', '750mg');
    
-- Populating Prescriptions Table 
INSERT INTO Prescriptions (AppointmentID, MedicationID, Quantity, Notes)
VALUES
(1, 1, 10, 'Take after meals'),
(2, 3, 5, 'Take twice daily for 7 days'),
(3, 7, 1, 'Single dose, as needed'),
(4, 2, 30, 'Daily supplement'),
(5, 5, 60, 'Take with food, morning and evening'),
(6, 9, 1, 'Cough syrup, 10ml three times a day'),
(7, 4, 14, 'Antibiotic, complete the course'),
(8, 6, 20, 'Pain relief, as needed'),
(9, 8, 30, 'Vitamin D supplement, once daily'),
(10, 10, 7, 'Antibiotic, finish all doses');

-- Populating Payments Table
INSERT INTO Payments (PatientID, Amount, PaymentDate, PaymentMethod)
VALUES
(1, 5000.00, '2025-05-15', 'Cash'),
(2, 7500.50, '2025-05-12', 'Card'),
(3, 2500.00, '2025-01-03', 'Bank Transfer'),
(4, 12000.00, '2025-05-15', 'Cash'),
(5, 8000.00, '2025-05-20', 'Card'),
(6, 3500.00, '2025-05-29', 'Cash'),
(7, 9500.75, '2025-06-10', 'Card'),
(8, 4000.00, '2025-05-05', 'Bank Transfer'),
(9, 6000.00, '2025-04-02', 'Cash'),
(10, 1500.00, '2025-05-13', 'Card');


# QUERY OPTIMIZATION #
-- Creating indexes for performance optimization
CREATE INDEX idx_patients_FirstName ON Patients(FirstName);
CREATE INDEX idx_appointments_doctorID ON Appointments(DoctorID);

-- TO BE SURE THE DATA WAS SUCCESSFULLY INSERTED INTO THE TABLES
SELECT * FROM Departments;
SELECT * FROM Doctors;
SELECT * FROM Patients;
SELECT * FROM Appointments;
SELECT * FROM Medications;
SELECT * FROM Prescriptions;
SELECT * FROM Payments;

-- List all upcoming appointments with patient and doctor full names
SELECT 
    a.AppointmentID,
    CONCAT(p.FirstName, ' ', p.LastName) AS PatientName,
    CONCAT(d.FirstName, ' ', d.LastName) AS DoctorName,
    a.AppointmentDate,
    a.Status
FROM 
    Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID
WHERE 
    a.AppointmentDate >= NOW()
ORDER BY 
    a.AppointmentDate;
    
-- Find the total number of appointments per doctor
SELECT 
    d.DoctorID,
    CONCAT(d.FirstName, ' ', d.LastName) AS DoctorName,
    COUNT(a.AppointmentID) AS TotalAppointments
FROM 
    Doctors d
LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID
GROUP BY 
    d.DoctorID;
    
-- Show total amount paid by each patient.
SELECT 
    p.PatientID,
    CONCAT(p.FirstName, ' ', p.LastName) AS FullName,
    SUM(pay.Amount) AS TotalPaid
FROM 
    Payments pay
JOIN Patients p ON pay.PatientID = p.PatientID
GROUP BY 
    p.PatientID;
    
-- Which medications have never been prescribe
SELECT 
    m.MedicationID,
    m.MedicationName
FROM 
    Medications m
LEFT JOIN Prescriptions p ON m.MedicationID = p.MedicationID
WHERE 
    p.PrescriptionID IS NULL;
    
-- Count the number of male and female patients.
SELECT 
    Gender,
    COUNT(*) AS Total
FROM 
    Patients
GROUP BY 
    Gender;
    
-- List appointments that were missed or cancelled.
SELECT 
    a.AppointmentID,
    CONCAT(p.FirstName, ' ', p.LastName) AS PatientName,
    a.AppointmentDate,
    a.Status
FROM 
    Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
WHERE 
    a.Status IN ('Missed', 'Cancelled');
    
-- Identify the top 5 most prescribed medications.
SELECT 
    m.MedicationName,
    COUNT(pr.PrescriptionID) AS TimesPrescribed
FROM 
    Prescriptions pr
JOIN Medications m ON pr.MedicationID = m.MedicationID
GROUP BY 
    m.MedicationID
ORDER BY 
    TimesPrescribed DESC
LIMIT 5;

-- Find the average payment amount.
SELECT 
   ROUND(AVG(Amount),2) as AveragePaymentAmount
FROM 
   Payments;






























