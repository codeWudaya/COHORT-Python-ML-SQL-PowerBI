-- Use Vertocity database
USE Vertocity;
GO

-- Drop existing tables if any
IF OBJECT_ID('emp', 'U') IS NOT NULL DROP TABLE emp;
IF OBJECT_ID('dept', 'U') IS NOT NULL DROP TABLE dept;
GO

-- Create dept table
CREATE TABLE dept (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100),
    location VARCHAR(100),
    floor_no INT,
    head_name VARCHAR(100),
    phone_ext VARCHAR(10),
    budget DECIMAL(10,2),
    established_year INT
);
GO

-- Create emp table
CREATE TABLE emp (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    gender CHAR(1),
    salary DECIMAL(10,2),
    job_title VARCHAR(100),
    join_date DATE,
    email VARCHAR(100),
    phone VARCHAR(15),
    dept_id INT FOREIGN KEY REFERENCES dept(dept_id)
);
GO

-- Insert into dept
INSERT INTO dept VALUES
(1, 'IT', 'Delhi', 3, 'Ravi Kumar', '1001', 500000, 2005),
(2, 'HR', 'Mumbai', 2, 'Neha Singh', '1002', 200000, 2010),
(3, 'Finance', 'Chennai', 4, 'Amit Roy', '1003', 400000, 2008),
(4, 'Marketing', 'Bangalore', 5, 'Divya Nair', '1004', 300000, 2012),
(5, 'Support', 'Hyderabad', 1, 'Karan Yadav', '1005', 150000, 2015);
GO

-- Insert into emp
INSERT INTO emp VALUES
(101, 'John', 'M', 75000, 'Dev Engineer', '2019-04-01', 'john@company.com', '999900001', 1),
(102, 'Alice', 'F', 67000, 'QA Analyst', '2020-06-15', 'alice@company.com', '999900002', 1),
(103, 'David', 'M', 80000, 'HR Manager', '2018-03-20', 'david@company.com', '999900003', 2),
(104, 'Sara', 'F', 62000, 'HR Exec', '2021-01-10', 'sara@company.com', '999900004', 2),
(105, 'James', 'M', 60000, 'Accountant', '2022-02-18', 'james@company.com', '999900005', 3),
(106, 'Rita', 'F', 55000, 'Marketing Exec', '2022-03-30', 'rita@company.com', '999900006', 4),
(107, 'Arun', 'M', 71000, 'Marketing Lead', '2020-10-05', 'arun@company.com', '999900007', 4),
(108, 'Maya', 'F', 50000, 'Support Rep', '2023-01-12', 'maya@company.com', '999900008', 5),
(109, 'Vikram', 'M', 54000, 'Support Lead', '2023-04-07', 'vikram@company.com', '999900009', 5);
GO

-- =========================
-- 🔟 Queries using INNER JOIN (explicit)
-- =========================

-- 1. Employee and department name
SELECT e.emp_name, d.dept_name
FROM emp e INNER JOIN dept d ON e.dept_id = d.dept_id;

-- 2. Employee job title and department location
SELECT e.emp_name, e.job_title, d.location
FROM emp e INNER JOIN dept d ON e.dept_id = d.dept_id;

-- 3. Employees in departments with budget > 300000
SELECT e.emp_name, d.dept_name, d.budget
FROM emp e INNER JOIN dept d ON e.dept_id = d.dept_id
WHERE d.budget > 300000;

-- 4. Count of employees in each department
SELECT d.dept_name, COUNT(*) AS employee_count
FROM emp e INNER JOIN dept d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- 5. Highest salary in each department
SELECT d.dept_name, MAX(e.salary) AS max_salary
FROM emp e INNER JOIN dept d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- 6. Department heads with total employee salary
SELECT d.head_name, SUM(e.salary) AS total_salary
FROM emp e INNER JOIN dept d ON e.dept_id = d.dept_id
GROUP BY d.head_name;

-- 7. Employees joined after 2021 in Finance
SELECT e.emp_name, e.join_date
FROM emp e INNER JOIN dept d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Finance' AND e.join_date > '2021-01-01';

-- 8. Gender-wise average salary per department
SELECT d.dept_name, e.gender, AVG(e.salary) AS avg_salary
FROM emp e INNER JOIN dept d ON e.dept_id = d.dept_id
GROUP BY d.dept_name, e.gender;

-- 9. CASE: salary bucket by department
SELECT e.emp_name, d.dept_name,
  CASE
    WHEN e.salary >= 75000 THEN 'High'
    WHEN e.salary >= 60000 THEN 'Medium'
    ELSE 'Low'
  END AS salary_band
FROM emp e INNER JOIN dept d ON e.dept_id = d.dept_id;

-- 10. Department-wise latest joiner
SELECT d.dept_name, e.emp_name, e.join_date
FROM emp e INNER JOIN dept d ON e.dept_id = d.dept_id
WHERE e.join_date = (
    SELECT MAX(join_date) FROM emp WHERE dept_id = d.dept_id
);

-- =========================
-- 🔟 Queries using JOIN (same as INNER JOIN)
-- =========================

-- 11. All employees with department and city
SELECT e.emp_name, d.dept_name, d.location
FROM emp e JOIN dept d ON e.dept_id = d.dept_id;

-- 12. List employees whose dept is on floor 3 or higher
SELECT e.emp_name, d.floor_no
FROM emp e JOIN dept d ON e.dept_id = d.dept_id
WHERE d.floor_no >= 3;

-- 13. Department budget per employee
SELECT e.emp_name, d.dept_name, d.budget
FROM emp e JOIN dept d ON e.dept_id = d.dept_id;

-- 14. Employees from departments established before 2010
SELECT e.emp_name, d.established_year
FROM emp e JOIN dept d ON e.dept_id = d.dept_id
WHERE d.established_year < 2010;

-- 15. Job title and department head name
SELECT e.job_title, d.head_name
FROM emp e JOIN dept d ON e.dept_id = d.dept_id;

-- 16. Employees with salary greater than department budget / 10
SELECT e.emp_name, e.salary, d.budget
FROM emp e JOIN dept d ON e.dept_id = d.dept_id
WHERE e.salary > d.budget / 10;

-- 17. Employees with matching dept name containing 't'
SELECT e.emp_name, d.dept_name
FROM emp e JOIN dept d ON e.dept_id = d.dept_id
WHERE d.dept_name LIKE '%t%';

-- 18. Employees working in IT or Support
SELECT e.emp_name, d.dept_name
FROM emp e JOIN dept d ON e.dept_id = d.dept_id
WHERE d.dept_name IN ('IT', 'Support');

-- 19. Count of employees joined in each year by dept
SELECT d.dept_name, YEAR(e.join_date) AS join_year, COUNT(*) AS total
FROM emp e JOIN dept d ON e.dept_id = d.dept_id
GROUP BY d.dept_name, YEAR(e.join_date);

-- 20. Full details from both tables
SELECT * FROM emp e JOIN dept d ON e.dept_id = d.dept_id;
