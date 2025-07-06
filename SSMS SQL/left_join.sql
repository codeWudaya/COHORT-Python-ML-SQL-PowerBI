-- Use Vertocity DB
USE Vertocity;
GO

-- Drop if exists
IF OBJECT_ID('projects', 'U') IS NOT NULL DROP TABLE projects;
IF OBJECT_ID('employees', 'U') IS NOT NULL DROP TABLE employees;
GO

-- Create employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    gender CHAR(1),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    phone VARCHAR(15)
);

-- Create projects table
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    emp_id INT,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    status VARCHAR(50),
    budget DECIMAL(10,2)
);

-- Insert into employees (9 employees)
INSERT INTO employees VALUES
(1, 'Alice', 'F', 'IT', 75000, '2019-04-01', '999900001'),
(2, 'Bob', 'M', 'HR', 67000, '2020-06-15', '999900002'),
(3, 'Charlie', 'M', 'Finance', 80000, '2018-03-20', '999900003'),
(4, 'Diana', 'F', 'HR', 62000, '2021-01-10', '999900004'),
(5, 'Evan', 'M', 'Marketing', 60000, '2022-02-18', '999900005'),
(6, 'Fiona', 'F', 'IT', 55000, '2022-03-30', '999900006'),
(7, 'George', 'M', 'IT', 71000, '2020-10-05', '999900007'),
(8, 'Hema', 'F', 'Support', 50000, '2023-01-12', '999900008'),
(9, 'Ivan', 'M', 'Legal', 54000, '2023-04-07', '999900009');

-- Insert into projects (only some employees have projects)
INSERT INTO projects VALUES
(101, 1, 'Cloud Migration', '2024-01-01', NULL, 'Ongoing', 150000),
(102, 3, 'Financial Audit', '2023-12-01', '2024-03-01', 'Completed', 120000),
(103, 4, 'HRMS Setup', '2024-02-01', NULL, 'Ongoing', 90000),
(104, 6, 'Website Redesign', '2024-01-15', NULL, 'Ongoing', 80000),
(105, 7, 'Cybersecurity Revamp', '2024-03-01', NULL, 'Ongoing', 100000);
GO

-- ===============================
-- ✅ 15 LEFT JOIN Practice Queries
-- ===============================

-- 1. All employees and their project names (NULL if not assigned)
SELECT e.emp_name, p.project_name
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id;

-- 2. List employees who are NOT assigned to any project
SELECT e.emp_name
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
WHERE p.project_id IS NULL;

-- 3. Show employee and project status (if any)
SELECT e.emp_name, ISNULL(p.status, 'No Project') AS project_status
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id;

-- 4. Show project budget per employee (include those with no project)
SELECT e.emp_name, p.project_name, p.budget
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id;

-- 5. Count how many employees are working on each project (if any)
SELECT p.project_name, COUNT(e.emp_id) AS employee_count
FROM projects p
LEFT JOIN employees e ON p.emp_id = e.emp_id
GROUP BY p.project_name;

-- 6. Employees hired after 2021 and their project info
SELECT e.emp_name, e.hire_date, p.project_name
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
WHERE e.hire_date > '2021-01-01';

-- 7. CASE: categorize employees by whether they have a project
SELECT e.emp_name,
  CASE 
    WHEN p.project_id IS NULL THEN 'Unassigned'
    ELSE 'Assigned'
  END AS assignment_status
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id;

-- 8. Average salary of employees per project (NULL project included)
SELECT ISNULL(p.project_name, 'No Project') AS project, AVG(e.salary) AS avg_salary
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
GROUP BY p.project_name;

-- 9. List employees in 'IT' department with any projects
SELECT e.emp_name, p.project_name
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
WHERE e.department = 'IT';

-- 10. Count of employees assigned vs unassigned
SELECT 
  CASE 
    WHEN p.project_id IS NULL THEN 'Unassigned'
    ELSE 'Assigned'
  END AS assignment,
  COUNT(*) AS total
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
GROUP BY 
  CASE 
    WHEN p.project_id IS NULL THEN 'Unassigned'
    ELSE 'Assigned'
  END;

-- 11. Employees and duration of assigned projects (use DATEDIFF)
SELECT e.emp_name, p.project_name,
  DATEDIFF(DAY, p.start_date, ISNULL(p.end_date, GETDATE())) AS project_duration_days
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id;

-- 12. Employees with project budgets > 100000 (or NULL if unassigned)
SELECT e.emp_name, p.project_name, p.budget
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
WHERE p.budget > 100000 OR p.project_id IS NULL;

-- 13. Department-wise total employees assigned to a project
SELECT e.department, COUNT(p.project_id) AS project_count
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
GROUP BY e.department;

-- 14. List all employees with project end dates (if available)
SELECT e.emp_name, p.project_name, p.end_date
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id;

-- 15. Employees working on a project that started in 2024
SELECT e.emp_name, p.project_name, p.start_date
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
WHERE YEAR(p.start_date) = 2024;
