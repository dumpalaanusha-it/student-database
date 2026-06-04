-- Create the Student Database
CREATE DATABASE StudentDB;

-- Use the database
USE StudentDB;

-- Create the Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    DateOfBirth DATE,
    PhoneNumber VARCHAR(15),
    Address VARCHAR(255),
    EnrollmentDate DATE NOT NULL,
    Status VARCHAR(20) DEFAULT 'Active'
);

-- Insert sample data
INSERT INTO Students (FirstName, LastName, Email, DateOfBirth, PhoneNumber, Address, EnrollmentDate, Status) VALUES
('John', 'Doe', 'john.doe@example.com', '2005-03-15', '555-0101', '123 Main St, City A', '2023-09-01', 'Active'),
('Jane', 'Smith', 'jane.smith@example.com', '2004-07-22', '555-0102', '456 Oak Ave, City B', '2023-09-01', 'Active'),
('Michael', 'Johnson', 'michael.j@example.com', '2005-11-08', '555-0103', '789 Pine Rd, City C', '2023-09-01', 'Active'),
('Sarah', 'Williams', 'sarah.w@example.com', '2004-05-30', '555-0104', '321 Elm St, City D', '2023-09-01', 'Active'),
('David', 'Brown', 'david.brown@example.com', '2005-01-12', '555-0105', '654 Maple Dr, City E', '2023-09-01', 'Inactive');

-- View all students
SELECT * FROM Students;

-- Additional useful queries

-- Find a student by email
SELECT * FROM Students WHERE Email = 'john.doe@example.com';

-- Find all active students
SELECT * FROM Students WHERE Status = 'Active';

-- Find students by last name
SELECT * FROM Students WHERE LastName = 'Smith';

-- Count total students
SELECT COUNT(*) AS TotalStudents FROM Students;

-- Sort students by enrollment date
SELECT * FROM Students ORDER BY EnrollmentDate DESC;

-- Update student status
UPDATE Students SET Status = 'Graduated' WHERE StudentID = 1;

-- Delete a student
DELETE FROM Students WHERE StudentID = 5;