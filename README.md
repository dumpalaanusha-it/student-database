# Student Database Management System

## Project Description

The Student Database Management System is a comprehensive SQL-based solution designed to store, manage, and retrieve student information efficiently. This project provides a structured database schema for maintaining student records including personal details, contact information, enrollment data, and student status tracking.

## Features

- **Student Record Management** - Create, read, update, and delete student records
- **Unique Email Validation** - Ensures each student has a unique email address
- **Student Status Tracking** - Monitor whether students are Active, Inactive, or Graduated
- **Enrollment Date Tracking** - Keep track of when students enrolled
- **Comprehensive Personal Information** - Store first name, last name, date of birth, phone number, and address
- **Easy Query Capabilities** - Pre-built queries for common operations
- **Sample Data** - Includes 5 sample student records for testing and demonstration

## Database Schema

### Students Table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| StudentID | INT | PRIMARY KEY, AUTO_INCREMENT | Unique identifier for each student |
| FirstName | VARCHAR(50) | NOT NULL | Student's first name |
| LastName | VARCHAR(50) | NOT NULL | Student's last name |
| Email | VARCHAR(100) | UNIQUE, NOT NULL | Student's email address |
| DateOfBirth | DATE | Optional | Student's date of birth |
| PhoneNumber | VARCHAR(15) | Optional | Student's phone number |
| Address | VARCHAR(255) | Optional | Student's residential address |
| EnrollmentDate | DATE | NOT NULL | Date when student enrolled |
| Status | VARCHAR(20) | DEFAULT 'Active' | Current status (Active, Inactive, Graduated) |

## Installation/Setup

### Prerequisites

- MySQL Server (5.7 or higher)
- MySQL Client or any MySQL IDE (e.g., MySQL Workbench, PhpMyAdmin)
- Basic knowledge of SQL

### Steps to Set Up

1. **Clone or download the repository** to your local machine
   ```bash
   git clone https://github.com/dumpalaanusha-it/student-database.git
   ```

2. **Access MySQL**
   ```bash
   mysql -u root -p
   ```

3. **Run the database script**
   ```sql
   SOURCE /path/to/database.sql;
   ```

4. **Verify the setup**
   ```sql
   USE StudentDB;
   SELECT * FROM Students;
   ```

## Usage

### Common Queries

#### View All Students
```sql
SELECT * FROM Students;
```

#### Find a Student by Email
```sql
SELECT * FROM Students WHERE Email = 'john.doe@example.com';
```

#### Find All Active Students
```sql
SELECT * FROM Students WHERE Status = 'Active';
```

#### Find Students by Last Name
```sql
SELECT * FROM Students WHERE LastName = 'Smith';
```

#### Count Total Students
```sql
SELECT COUNT(*) AS TotalStudents FROM Students;
```

#### Sort Students by Enrollment Date
```sql
SELECT * FROM Students ORDER BY EnrollmentDate DESC;
```

#### Update Student Status
```sql
UPDATE Students SET Status = 'Graduated' WHERE StudentID = 1;
```

#### Insert a New Student
```sql
INSERT INTO Students (FirstName, LastName, Email, DateOfBirth, PhoneNumber, Address, EnrollmentDate, Status) 
VALUES ('Alice', 'Davis', 'alice.davis@example.com', '2005-06-10', '555-0106', '987 Birch Ln, City F', '2023-09-01', 'Active');
```

#### Delete a Student
```sql
DELETE FROM Students WHERE StudentID = 5;
```

## Sample Data

The database comes pre-loaded with 5 sample students:

1. **John Doe** - john.doe@example.com - Active
2. **Jane Smith** - jane.smith@example.com - Active
3. **Michael Johnson** - michael.j@example.com - Active
4. **Sarah Williams** - sarah.w@example.com - Active
5. **David Brown** - david.brown@example.com - Inactive

## Requirements

- **MySQL Server** - Version 5.7 or higher
- **Storage** - Minimal space required for database
- **Permissions** - Administrative privileges to create databases and tables

## Contributing

Contributions are welcome! To contribute to this project:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/YourFeature
   ```
3. **Make your changes**
4. **Commit your changes**
   ```bash
   git commit -m "Add YourFeature"
   ```
5. **Push to the branch**
   ```bash
   git push origin feature/YourFeature
   ```
6. **Create a Pull Request**

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## Support

For questions or issues related to this project, please open an issue on the GitHub repository or contact the project maintainer.

**Happy Learning! 🎓**
