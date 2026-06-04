-- ============================================================
-- STUDENT MANAGEMENT SYSTEM - DATABASE SCHEMA
-- Complete SQL for Student Management Project
-- ============================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS StudentManagementDB;
USE StudentManagementDB;

-- ============================================================
-- TABLE 1: Students Table
-- ============================================================
CREATE TABLE IF NOT EXISTS Students (
    serial_number       INT             NOT NULL AUTO_INCREMENT,
    name                VARCHAR(100)    NOT NULL,
    class               VARCHAR(50)     NOT NULL,
    place               VARCHAR(100)    NOT NULL,
    mobile_number       CHAR(10)        NOT NULL UNIQUE,
    year_of_study       TINYINT         NOT NULL CHECK (year_of_study BETWEEN 1 AND 6),
    year_of_passout     YEAR            NOT NULL,
    email               VARCHAR(150)    UNIQUE,
    gpa                 DECIMAL(3,2)    DEFAULT 0.00 CHECK (gpa BETWEEN 0 AND 10),
    enrollment_date     DATE            DEFAULT CURRENT_DATE,
    created_at          TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP       DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (serial_number)
);

-- ============================================================
-- TABLE 2: Attendance Table
-- ============================================================
CREATE TABLE IF NOT EXISTS Attendance (
    attendance_id       INT             NOT NULL AUTO_INCREMENT,
    serial_number       INT             NOT NULL,
    attendance_date     DATE            NOT NULL,
    status              ENUM('Present', 'Absent', 'Leave') DEFAULT 'Present',
    
    PRIMARY KEY (attendance_id),
    FOREIGN KEY (serial_number) REFERENCES Students(serial_number) ON DELETE CASCADE,
    UNIQUE KEY unique_attendance (serial_number, attendance_date)
);

-- ============================================================
-- TABLE 3: Grades Table
-- ============================================================
CREATE TABLE IF NOT EXISTS Grades (
    grade_id            INT             NOT NULL AUTO_INCREMENT,
    serial_number       INT             NOT NULL,
    subject             VARCHAR(100)    NOT NULL,
    marks_obtained      DECIMAL(5,2)    NOT NULL CHECK (marks_obtained BETWEEN 0 AND 100),
    total_marks         DECIMAL(5,2)    NOT NULL DEFAULT 100,
    grade               CHAR(1),
    exam_date           DATE            NOT NULL,
    
    PRIMARY KEY (grade_id),
    FOREIGN KEY (serial_number) REFERENCES Students(serial_number) ON DELETE CASCADE
);

-- ============================================================
-- SECTION 2: INSERT SAMPLE DATA
-- ============================================================

-- Insert Students
INSERT INTO Students (name, class, place, mobile_number, year_of_study, year_of_passout, email, gpa)
VALUES
    ('Arun Kumar',        'B.Tech CSE',     'Chennai',      '9876543210', 3, 2026, 'arun@mail.com',      8.75),
    ('Priya Sharma',      'B.Tech ECE',     'Delhi',        '9123456780', 2, 2027, 'priya@mail.com',     9.10),
    ('Rahul Verma',       'BCA',            'Mumbai',       '9988776655', 4, 2025, 'rahul@mail.com',     7.50),
    ('Sneha Nair',        'B.Sc CS',        'Kochi',        '8765432109', 1, 2028, 'sneha@mail.com',     8.00),
    ('Mohammed Rafi',     'M.Tech AI',      'Hyderabad',    '7890123456', 2, 2026, 'rafi@mail.com',      9.50),
    ('Divya Reddy',       'BCA',            'Bangalore',    '9000112233', 3, 2026, 'divya@mail.com',     8.20),
    ('Karan Mehta',       'B.Tech IT',      'Pune',         '8123456789', 1, 2028, 'karan@mail.com',     7.90),
    ('Anitha Raj',        'B.Sc CS',        'Coimbatore',   '9345678901', 4, 2025, 'anitha@mail.com',    8.60),
    ('Vijay Patel',       'M.Tech CSE',     'Ahmedabad',    '7012345678', 2, 2026, 'vijay@mail.com',     9.00),
    ('Lakshmi Devi',      'B.Tech CSE',     'Tirupati',     '8901234567', 3, 2026, 'lakshmi@mail.com',   8.40);

-- ============================================================
-- SECTION 3: SELECT QUERIES
-- ============================================================

-- 3a. View all students
SELECT * FROM Students ORDER BY serial_number;

-- 3b. View specific columns
SELECT serial_number, name, class, place, gpa FROM Students;

-- 3c. Students by passout year
SELECT name, class, year_of_passout, gpa FROM Students 
WHERE year_of_passout = 2026 
ORDER BY gpa DESC;

-- 3d. Students from specific place
SELECT name, class, mobile_number, email FROM Students 
WHERE place = 'Chennai';

-- 3e. High performers (GPA > 8.5)
SELECT name, class, gpa FROM Students 
WHERE gpa > 8.5 
ORDER BY gpa DESC;

-- 3f. Count students by class
SELECT class, COUNT(*) AS total_students 
FROM Students 
GROUP BY class 
ORDER BY total_students DESC;

-- 3g. Students in year 1 and 2
SELECT name, class, year_of_study FROM Students 
WHERE year_of_study IN (1, 2) 
ORDER BY year_of_study;

-- 3h. Search students by name pattern
SELECT * FROM Students 
WHERE name LIKE 'A%';

-- 3i. Top 5 students by GPA
SELECT serial_number, name, class, gpa FROM Students 
ORDER BY gpa DESC 
LIMIT 5;

-- 3j. Average GPA by class
SELECT class, ROUND(AVG(gpa), 2) AS avg_gpa, COUNT(*) AS student_count
FROM Students 
GROUP BY class 
ORDER BY avg_gpa DESC;

-- ============================================================
-- SECTION 4: UPDATE QUERIES
-- ============================================================

-- 4a. Update student's GPA
UPDATE Students 
SET gpa = 9.25 
WHERE serial_number = 1;

-- 4b. Update multiple students' email
UPDATE Students 
SET email = CONCAT(LOWER(REPLACE(name, ' ', '.')), '@newdomain.com')
WHERE email IS NULL;

-- 4c. Update place
UPDATE Students 
SET place = 'Bangalore' 
WHERE serial_number = 6;

-- Verify update
SELECT serial_number, name, place, email, gpa FROM Students WHERE serial_number IN (1, 6);

-- ============================================================
-- SECTION 5: DELETE QUERIES
-- ============================================================

-- 5a. Delete a specific student (commented for safety)
-- DELETE FROM Students WHERE serial_number = 10;

-- 5b. Delete students with low GPA (commented for safety)
-- DELETE FROM Students WHERE gpa < 6.0;

-- Check remaining records
SELECT COUNT(*) AS total_active_students FROM Students;

-- ============================================================
-- SECTION 6: ADVANCED QUERIES
-- ============================================================

-- 6a. Create INDEX for faster searches
CREATE INDEX idx_student_name ON Students (name);
CREATE INDEX idx_student_class ON Students (class);
CREATE INDEX idx_student_mobile ON Students (mobile_number);

-- 6b. Create VIEW for active students
CREATE VIEW Active_Students AS
SELECT 
    serial_number, name, class, place, mobile_number, 
    year_of_study, year_of_passout, gpa, email
FROM Students 
WHERE year_of_passout >= YEAR(CURRENT_DATE)
ORDER BY name;

-- Query the view
SELECT * FROM Active_Students;

-- 6c. Students with above-average GPA (Subquery)
SELECT name, class, gpa,
    CASE 
        WHEN gpa >= 9.0 THEN 'Distinction'
        WHEN gpa >= 8.0 THEN 'First Class'
        WHEN gpa >= 6.5 THEN 'Second Class'
        ELSE 'Pass'
    END AS grade_category
FROM Students 
WHERE gpa > (SELECT AVG(gpa) FROM Students)
ORDER BY gpa DESC;

-- 6d. Detailed student report with statistics
SELECT 
    serial_number AS 'S.No',
    name AS 'Student Name',
    class AS 'Class',
    place AS 'Place',
    mobile_number AS 'Mobile',
    year_of_study AS 'Year',
    year_of_passout AS 'Passout',
    gpa AS 'GPA',
    CASE 
        WHEN gpa >= 9.0 THEN '⭐⭐⭐ Excellent'
        WHEN gpa >= 8.0 THEN '⭐⭐ Good'
        WHEN gpa >= 6.5 THEN '⭐ Average'
        ELSE 'Need Improvement'
    END AS 'Performance'
FROM Students 
ORDER BY gpa DESC;

-- 6e. Database Statistics
SELECT 
    COUNT(*) AS Total_Students,
    ROUND(AVG(gpa), 2) AS Average_GPA,
    MAX(gpa) AS Highest_GPA,
    MIN(gpa) AS Lowest_GPA,
    COUNT(DISTINCT class) AS Total_Classes,
    COUNT(DISTINCT place) AS Total_Places
FROM Students;

-- 6f. Class-wise detailed report
SELECT 
    class,
    COUNT(*) AS student_count,
    ROUND(AVG(gpa), 2) AS avg_gpa,
    MAX(gpa) AS max_gpa,
    MIN(gpa) AS min_gpa
FROM Students 
GROUP BY class 
HAVING COUNT(*) > 0
ORDER BY avg_gpa DESC;

-- ============================================================
-- SECTION 7: USEFUL PROCEDURES (Optional)
-- ============================================================

-- Create a stored procedure to add student
DELIMITER $$
CREATE PROCEDURE AddStudent(
    IN p_name VARCHAR(100),
    IN p_class VARCHAR(50),
    IN p_place VARCHAR(100),
    IN p_mobile CHAR(10),
    IN p_year TINYINT,
    IN p_passout YEAR,
    IN p_email VARCHAR(150),
    IN p_gpa DECIMAL(3,2)
)
BEGIN
    INSERT INTO Students (name, class, place, mobile_number, year_of_study, year_of_passout, email, gpa)
    VALUES (p_name, p_class, p_place, p_mobile, p_year, p_passout, p_email, p_gpa);
END$$
DELIMITER ;

-- Usage: CALL AddStudent('John Doe', 'B.Tech CSE', 'Mumbai', '9999999999', 3, 2026, 'john@mail.com', 8.50);

-- ============================================================
-- SECTION 8: CLEANUP (Commented for safety)
-- ============================================================

-- Drop views, indexes, procedures (if needed)
-- DROP VIEW Active_Students;
-- DROP PROCEDURE AddStudent;
-- DROP TABLE Attendance;
-- DROP TABLE Grades;
-- DROP TABLE Students;
-- DROP DATABASE StudentManagementDB;

-- ============================================================
-- END OF STUDENT MANAGEMENT DATABASE
-- ============================================================
