-- Use the database
USE Vertocity;
GO

-- Drop the students table if it exists
IF OBJECT_ID('students', 'U') IS NOT NULL
    DROP TABLE students;
GO

-- Create students table with 15 columns
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender CHAR(1),
    department VARCHAR(50),
    year INT,
    gpa FLOAT,
    total_marks INT,
    attendance_percent FLOAT,
    sports_participation BIT,
    hostel_status BIT,
    city VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    scholarship_amount DECIMAL(10,2)
);
GO

-- Insert 15 rows into students
INSERT INTO students VALUES
(1, 'Ananya', 20, 'F', 'CSE', 2, 8.5, 450, 88.0, 1, 1, 'Delhi', 'ananya@mail.com', '9999990001', 5000),
(2, 'Rahul', 21, 'M', 'ECE', 3, 7.0, 400, 76.0, 0, 1, 'Mumbai', 'rahul@mail.com', '9999990002', 2000),
(3, 'Sneha', 19, 'F', 'EEE', 1, 9.2, 480, 93.0, 1, 0, 'Chennai', 'sneha@mail.com', '9999990003', 8000),
(4, 'Arjun', 22, 'M', 'MECH', 4, 6.5, 360, 69.5, 0, 1, 'Bangalore', 'arjun@mail.com', '9999990004', 1000),
(5, 'Priya', 20, 'F', 'CSE', 2, 7.8, 420, 85.5, 1, 1, 'Hyderabad', 'priya@mail.com', '9999990005', 3000),
(6, 'Kiran', 21, 'M', 'CIVIL', 3, 8.0, 430, 90.0, 1, 0, 'Delhi', 'kiran@mail.com', '9999990006', 4000),
(7, 'Nisha', 22, 'F', 'CSE', 4, 9.5, 490, 95.0, 1, 1, 'Mumbai', 'nisha@mail.com', '9999990007', 9000),
(8, 'Vikram', 20, 'M', 'EEE', 2, 6.8, 390, 72.5, 0, 0, 'Kolkata', 'vikram@mail.com', '9999990008', 1500),
(9, 'Riya', 21, 'F', 'ECE', 3, 8.3, 440, 87.0, 1, 1, 'Delhi', 'riya@mail.com', '9999990009', 3500),
(10, 'Amit', 19, 'M', 'MECH', 1, 7.1, 410, 80.0, 0, 0, 'Chennai', 'amit@mail.com', '9999990010', 2000),
(11, 'Meena', 20, 'F', 'CSE', 2, 9.0, 460, 92.0, 1, 1, 'Mumbai', 'meena@mail.com', '9999990011', 7500),
(12, 'Yash', 22, 'M', 'CIVIL', 4, 5.9, 340, 68.0, 0, 1, 'Bangalore', 'yash@mail.com', '9999990012', 0),
(13, 'Divya', 21, 'F', 'ECE', 3, 8.8, 470, 91.0, 1, 1, 'Hyderabad', 'divya@mail.com', '9999990013', 6000),
(14, 'Rakesh', 20, 'M', 'EEE', 2, 6.2, 370, 74.0, 0, 0, 'Delhi', 'rakesh@mail.com', '9999990014', 1000),
(15, 'Sana', 19, 'F', 'CSE', 1, 9.6, 495, 96.0, 1, 1, 'Mumbai', 'sana@mail.com', '9999990015', 10000);
GO

-- 15 CASE Statement Queries

-- 1. Label grade based on GPA
SELECT name, gpa,
  CASE 
    WHEN gpa >= 9 THEN 'A'
    WHEN gpa >= 8 THEN 'B'
    WHEN gpa >= 7 THEN 'C'
    ELSE 'D'
  END AS grade
FROM students;

-- 2. Attendance category
SELECT name, attendance_percent,
  CASE 
    WHEN attendance_percent >= 90 THEN 'Excellent'
    WHEN attendance_percent >= 75 THEN 'Good'
    ELSE 'Poor'
  END AS attendance_level
FROM students;

-- 3. Scholarship Status
SELECT name, scholarship_amount,
  CASE 
    WHEN scholarship_amount > 5000 THEN 'High'
    WHEN scholarship_amount > 0 THEN 'Moderate'
    ELSE 'None'
  END AS scholarship_status
FROM students;

-- 4. Hostel or Day Scholar
SELECT name,
  CASE 
    WHEN hostel_status = 1 THEN 'Hosteller'
    ELSE 'Day Scholar'
  END AS residence_type
FROM students;

-- 5. Sports Involvement
SELECT name,
  CASE 
    WHEN sports_participation = 1 THEN 'Active in Sports'
    ELSE 'Not in Sports'
  END AS sports_status
FROM students;

-- 6. City-wise Zone Classification
SELECT name, city,
  CASE city
    WHEN 'Delhi' THEN 'North'
    WHEN 'Mumbai' THEN 'West'
    WHEN 'Chennai' THEN 'South'
    WHEN 'Kolkata' THEN 'East'
    ELSE 'Unknown'
  END AS zone
FROM students;

-- 7. Pass or Fail based on marks
SELECT name, total_marks,
  CASE 
    WHEN total_marks >= 400 THEN 'Pass'
    ELSE 'Fail'
  END AS result
FROM students;

-- 8. Final Year Status
SELECT name, year,
  CASE 
    WHEN year = 4 THEN 'Final Year'
    ELSE 'Not Final Year'
  END AS year_status
FROM students;
-- 9. Gender Display
SELECT name, CASE gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' ELSE 'Other' END AS gender_label FROM students;
-- 10. Department Clustering
SELECT name, department, CASE WHEN department IN ('CSE', 'ECE', 'EEE') THEN 'Tech' ELSE 'Core' END AS dept_type FROM students;
-- 11. Phone carrier based on prefix
SELECT name, phone, CASE WHEN phone LIKE '999%' THEN 'Airtel/Generic' ELSE 'Unknown' END AS carrier FROM students;
-- 12. GPA Boost Eligibility
SELECT name, gpa, CASE WHEN gpa BETWEEN 6 AND 7 THEN 'Eligible for Mentorship' ELSE 'Not Needed' END AS mentoring_need FROM students;
-- 13. Fee Waiver Eligibility
SELECT name, scholarship_amount, CASE WHEN scholarship_amount >= 7000 THEN 'Full Waiver' WHEN scholarship_amount >= 3000 THEN 'Partial Waiver' ELSE 'No Waiver'
END AS fee_status FROM students;
-- 14. Email Validity Check
SELECT name, email, CASE WHEN email LIKE '%@%.com' THEN 'Valid' ELSE 'Invalid' END AS email_status FROM students;
-- 15. Young Achiever Flag
SELECT name, age, gpa, CASE WHEN age < 21 AND gpa >= 9 THEN 'Young Achiever' ELSE 'Normal' END AS achiever_tag FROM students;

