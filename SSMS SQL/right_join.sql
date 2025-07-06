-- Use Vertocity database
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

-- Insert into employees (7 employees)
INSERT INTO employees VALUES
(1, 'Alice', 'F', 'IT', 75000, '2019-04-01', '999900001'),
(2, 'Bob', 'M', 'HR', 67000, '2020-06-15', '999900002'),
(3, 'Charlie', 'M', 'Finance', 80000, '2018-03-20', '999900003'),
(4, 'Diana', 'F', 'HR', 62000, '2021-01-10', '999900004'),
(5, 'Evan', 'M', 'Marketing', 60000, '2022-02-18', '999900005'),
(6, 'Fiona', 'F', 'IT', 55000, '2022-03-30', '999900006'),
(7, 'George', 'M', 'Support', 50000, '2023-01-12', '999900007');

-- Insert into projects (10 projects; 3 unassigned)
INSERT INTO projects VALUES
(101, 1, 'Cloud Migration', '2024-01-01', NULL, 'Ongoing', 150000),
(102, 3, 'Financial Audit', '2023-12-01', '2024-03-01', 'Completed', 120000),
(103, 4, 'HRMS Setup', '2024-02-01', NULL, 'Ongoing', 90000),
(104, 6, 'Website Redesign', '2024-01-15', NULL, 'Ongoing', 80000),
(105, 7, 'Cybersecurity Revamp', '2024-03-01', NULL, 'Ongoing', 100000),
(106, NULL, 'AI Research', '2024-04-01', NULL, 'Planned', 200000),
(107, NULL, 'SAP Integration', '2024-05-01', NULL, 'Planned', 180000),
(108, NULL, 'Office Renovation', '2024-06-01', NULL, 'Planned', 90000),
(109, 2, 'HR Portal Upgrade', '2024-02-10', NULL, 'Ongoing', 75000),
(110, 5, 'Brand Campaign', '2024-03-20', NULL, 'Ongoing', 95000);
GO

-- ================================
-- ✅ 20 RIGHT JOIN Practice Queries
-- ================================

-- 1. List all projects and assigned employee names (NULL if no match)
SELECT p.project_name, e.emp_name
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id;

-- 2. Find projects that are NOT assigned to any employee
SELECT p.project_name
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id
WHERE e.emp_id IS NULL;

-- 3. Show employee name and project status for all projects
SELECT e.emp_name, p.project_name, p.status
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id;

-- 4. Show project budget and corresponding department (NULL if unassigned)
SELECT p.project_name, p.budget, e.department
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id;

-- 5. Count of assigned vs unassigned projects
SELECT 
  CASE 
    WHEN e.emp_id IS NULL THEN 'Unassigned'
    ELSE 'Assigned'
  END AS project_status,
  COUNT(*) AS total
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id
GROUP BY 
  CASE 
    WHEN e.emp_id IS NULL THEN 'Unassigned'
    ELSE 'Assigned'
  END;

-- 6. List of employees with their current project names (even NULLs)
SELECT e.emp_name, p.project_name
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id;

-- 7. Total budget of projects per department
SELECT e.department, SUM(p.budget) AS total_budget
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id
GROUP BY e.department;

-- 8. CASE: project assignment label
SELECT p.project_name,
  CASE 
    WHEN e.emp_id IS NULL THEN 'No Employee Assigned'
    ELSE e.emp_name
  END AS assignee
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id;

-- 9. Show project durations in days
SELECT p.project_name,
  DATEDIFF(DAY, p.start_date, ISNULL(p.end_date, GETDATE())) AS duration_days
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id;

-- 10. Average salary of employees working on projects (NULL if unassigned)
SELECT p.project_name, AVG(e.salary) AS avg_salary
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id
GROUP BY p.project_name;

-- 11. Filter projects with budget > 100000
SELECT p.project_name, p.budget
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id
WHERE p.budget > 100000;

-- 12. Project names and gender of employees (if assigned)
SELECT p.project_name, e.gender
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id;

-- 13. Employees working on projects that started in 2024
SELECT e.emp_name, p.project_name, p.start_date
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id
WHERE YEAR(p.start_date) = 2024;

-- 14. Count employees per project (can include NULL)
SELECT p.project_name, COUNT(e.emp_id) AS emp_count
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id
GROUP BY p.project_name;

-- 15. List projects with NULL end dates (ongoing or planned)
SELECT p.project_name, p.status
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id
WHERE p.end_date IS NULL;

-- 16. Employees with projects having budget under 100k
SELECT e.emp_name, p.project_name, p.budget
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id
WHERE p.budget < 100000;

-- 17. Total number of projects by status
SELECT p.status, COUNT(*) AS project_count
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id
GROUP BY p.status;

-- 18. Employee and project where employee is from 'HR'
SELECT e.emp_name, p.project_name
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id
WHERE e.department = 'HR';

-- 19. Projects not yet completed
SELECT p.project_name
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id
WHERE p.status <> 'Completed';

-- 20. Full data from both tables using RIGHT JOIN
SELECT * 
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id;
