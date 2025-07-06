-- Use the Vertocity database
USE Vertocity;
GO

-- Drop the table if it already exists
IF OBJECT_ID('master_students', 'U') IS NOT NULL
    DROP TABLE master_students;
GO

-- Create master_students table
CREATE TABLE master_students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    gender CHAR(1),
    age INT,
    department VARCHAR(50),
    year INT,
    total_marks INT,
    gpa FLOAT,
    attendance FLOAT,
    scholarship DECIMAL(10,2),
    sports BIT,
    city VARCHAR(100),
    hostel BIT,
    email VARCHAR(100),
    phone VARCHAR(15)
);
GO

-- Insert 15 rows into master_students
INSERT INTO master_students VALUES
(1, 'Ananya', 'F', 20, 'CSE', 2, 450, 8.5, 88.0, 5000, 1, 'Delhi', 1, 'ananya@uni.com', '999900001'),
(2, 'Rahul', 'M', 21, 'ECE', 3, 400, 7.0, 76.0, 2000, 0, 'Mumbai', 1, 'rahul@uni.com', '999900002'),
(3, 'Sneha', 'F', 19, 'EEE', 1, 480, 9.2, 93.0, 8000, 1, 'Chennai', 0, 'sneha@uni.com', '999900003'),
(4, 'Arjun', 'M', 22, 'MECH', 4, 360, 6.5, 69.5, 1000, 0, 'Bangalore', 1, 'arjun@uni.com', '999900004'),
(5, 'Priya', 'F', 20, 'CSE', 2, 420, 7.8, 85.5, 3000, 1, 'Hyderabad', 1, 'priya@uni.com', '999900005'),
(6, 'Kiran', 'M', 21, 'CIVIL', 3, 430, 8.0, 90.0, 4000, 1, 'Delhi', 0, 'kiran@uni.com', '999900006'),
(7, 'Nisha', 'F', 22, 'CSE', 4, 490, 9.5, 95.0, 9000, 1, 'Mumbai', 1, 'nisha@uni.com', '999900007'),
(8, 'Vikram', 'M', 20, 'EEE', 2, 390, 6.8, 72.5, 1500, 0, 'Kolkata', 0, 'vikram@uni.com', '999900008'),
(9, 'Riya', 'F', 21, 'ECE', 3, 440, 8.3, 87.0, 3500, 1, 'Delhi', 1, 'riya@uni.com', '999900009'),
(10, 'Amit', 'M', 19, 'MECH', 1, 410, 7.1, 80.0, 2000, 0, 'Chennai', 0, 'amit@uni.com', '999900010'),
(11, 'Meena', 'F', 20, 'CSE', 2, 460, 9.0, 92.0, 7500, 1, 'Mumbai', 1, 'meena@uni.com', '999900011'),
(12, 'Yash', 'M', 22, 'CIVIL', 4, 340, 5.9, 68.0, 0, 0, 'Bangalore', 1, 'yash@uni.com', '999900012'),
(13, 'Divya', 'F', 21, 'ECE', 3, 470, 8.8, 91.0, 6000, 1, 'Hyderabad', 1, 'divya@uni.com', '999900013'),
(14, 'Rakesh', 'M', 20, 'EEE', 2, 370, 6.2, 74.0, 1000, 0, 'Delhi', 0, 'rakesh@uni.com', '999900014'),
(15, 'Sana', 'F', 19, 'CSE', 1, 495, 9.6, 96.0, 10000, 1, 'Mumbai', 1, 'sana@uni.com', '999900015');
GO

-- 25 SQL Practice Queries

-- 1. Basic SELECT
SELECT * FROM master_students;

-- 2. Show only unique departments
SELECT DISTINCT department FROM master_students;

-- 3. Get top 5 highest GPAs
SELECT TOP 5 name, gpa FROM master_students ORDER BY gpa DESC;

-- 4. Get all students older than 20
SELECT name, age FROM master_students WHERE age > 20;

-- 5. Students from Delhi or Mumbai
SELECT name, city FROM master_students WHERE city IN ('Delhi', 'Mumbai');

-- 6. Students with attendance >= 90 and GPA > 9
SELECT name FROM master_students WHERE attendance >= 90 AND gpa > 9;

-- 7. Count of male and female students
SELECT gender, COUNT(*) AS count FROM master_students GROUP BY gender;

-- 8. Average GPA by department
SELECT department, AVG(gpa) AS avg_gpa FROM master_students GROUP BY department;

-- 9. Sum of all scholarships
SELECT SUM(scholarship) AS total_scholarship FROM master_students;

-- 10. Minimum and maximum total_marks by department
SELECT department, MIN(total_marks) AS min_marks, MAX(total_marks) AS max_marks FROM master_students GROUP BY department;

-- 11. Total sports participants
SELECT COUNT(*) AS sports_count FROM master_students WHERE sports = 1;

-- 12. Departments with average GPA above 8.0
SELECT department, AVG(gpa) AS avg_gpa FROM master_students GROUP BY department HAVING AVG(gpa) > 8.0;

-- 13. CASE - Scholarship level classification
SELECT name, scholarship,
  CASE 
    WHEN scholarship >= 7000 THEN 'High'
    WHEN scholarship >= 3000 THEN 'Medium'
    WHEN scholarship > 0 THEN 'Low'
    ELSE 'None'
  END AS scholarship_category
FROM master_students;

-- 14. CASE - Attendance label
SELECT name, attendance,
  CASE 
    WHEN attendance >= 90 THEN 'Excellent'
    WHEN attendance >= 75 THEN 'Good'
    ELSE 'Poor'
  END AS attendance_level
FROM master_students;

-- 15. City-wise student count
SELECT city, COUNT(*) AS student_count FROM master_students GROUP BY city;

-- 16. GPA-wise top student per department
SELECT department, name, gpa FROM master_students AS m
WHERE gpa = (
    SELECT MAX(gpa) FROM master_students WHERE department = m.department
);

-- 17. Departments with more than 3 students
SELECT department, COUNT(*) AS total FROM master_students GROUP BY department HAVING COUNT(*) > 3;

-- 18. Average attendance by gender
SELECT gender, AVG(attendance) AS avg_attendance FROM master_students GROUP BY gender;

-- 19. Count of hostel students by department
SELECT department, COUNT(*) AS hostel_count FROM master_students WHERE hostel = 1 GROUP BY department;

-- 20. Email list of all CSE students
SELECT name, email FROM master_students WHERE department = 'CSE';

-- 21. Students without any scholarship
SELECT name FROM master_students WHERE scholarship = 0;

-- 22. Top 3 students from ECE by marks
SELECT TOP 3 name, total_marks FROM master_students WHERE department = 'ECE' ORDER BY total_marks DESC;

-- 23. Cities having more than 2 students
SELECT city, COUNT(*) AS count FROM master_students GROUP BY city HAVING COUNT(*) > 2;

-- 24. Students with phone starting with '9999'
SELECT name, phone FROM master_students WHERE phone LIKE '9999%';

-- 25. Combined CASE + AGGREGATE (attendance category count)
SELECT 
  CASE 
    WHEN attendance >= 90 THEN 'Excellent'
    WHEN attendance >= 75 THEN 'Good'
    ELSE 'Needs Improvement'
  END AS attendance_status,
  COUNT(*) AS total_students
FROM master_students
GROUP BY 
  CASE 
    WHEN attendance >= 90 THEN 'Excellent'
    WHEN attendance >= 75 THEN 'Good'
    ELSE 'Needs Improvement'
  END;
