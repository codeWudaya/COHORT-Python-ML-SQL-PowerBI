-- Use Vertocity database
USE Vertocity;
GO

-- Drop the employee_summary table if it already exists
IF OBJECT_ID('employee_summary', 'U') IS NOT NULL
    DROP TABLE employee_summary;
GO

-- Create the employee_summary table with 10 columns
CREATE TABLE employee_summary (
    emp_id INT PRIMARY KEY,                -- Unique Employee ID
    emp_name VARCHAR(100),                 -- Name of Employee
    department VARCHAR(50),                -- Department Name
    role VARCHAR(50),                      -- Job Role
    age INT,                               -- Age
    experience INT,                        -- Experience in Years
    salary DECIMAL(10,2),                  -- Monthly Salary
    bonus DECIMAL(10,2),                   -- Annual Bonus
    rating FLOAT,                          -- Performance Rating
    location VARCHAR(50)                   -- Work Location
);
GO

-- Insert 10 sample rows into the employee_summary table
INSERT INTO employee_summary VALUES
(1, 'John Doe', 'IT', 'Engineer', 28, 4, 70000, 5000, 8.9, 'Delhi'),
(2, 'Jane Smith', 'HR', 'Manager', 35, 10, 80000, 6000, 9.2, 'Mumbai'),
(3, 'Alice Brown', 'Finance', 'Analyst', 40, 15, 90000, 7000, 9.0, 'Delhi'),
(4, 'Bob White', 'IT', 'Engineer', 30, 6, 72000, 5500, 8.5, 'Chennai'),
(5, 'Charlie Black', 'Marketing', 'Executive', 25, 2, 65000, 4000, 8.2, 'Mumbai'),
(6, 'Diana Prince', 'HR', 'Executive', 32, 8, 78000, 6200, 9.4, 'Chennai'),
(7, 'Evan Wright', 'Finance', 'Manager', 45, 20, 95000, 8000, 9.1, 'Delhi'),
(8, 'Fiona Green', 'IT', 'Manager', 29, 5, 73000, 5100, 8.7, 'Mumbai'),
(9, 'George King', 'Marketing', 'Manager', 38, 12, 85000, 6300, 9.3, 'Delhi'),
(10, 'Helen Clark', 'HR', 'Manager', 36, 11, 81000, 6100, 9.0, 'Delhi');
GO

-- 1. Avg rating > 8.5 by department
SELECT department, AVG(rating) AS avg_rating
FROM employee_summary
GROUP BY department
HAVING AVG(rating) > 8.5;

-- 2. Sum salary > 200000 by department
SELECT department, SUM(salary) AS total_salary
FROM employee_summary
GROUP BY department
HAVING SUM(salary) > 200000;

-- 3. Count > 2 by role
SELECT role, COUNT(emp_id) AS total_employees
FROM employee_summary
GROUP BY role
HAVING COUNT(emp_id) > 2;

-- 4. Max bonus > 6000 by location
SELECT location, MAX(bonus) AS max_bonus
FROM employee_summary
GROUP BY location
HAVING MAX(bonus) > 6000;

-- 5. Sum bonus BETWEEN 10000 AND 15000 by department
SELECT department, SUM(bonus) AS total_bonus
FROM employee_summary
GROUP BY department
HAVING SUM(bonus) BETWEEN 10000 AND 15000;

-- 6. Min rating > 8 by role
SELECT role, MIN(rating) AS min_rating
FROM employee_summary
GROUP BY role
HAVING MIN(rating) > 8;

-- 7. Avg salary < 80000 by location
SELECT location, AVG(salary) AS avg_salary
FROM employee_summary
GROUP BY location
HAVING AVG(salary) < 80000;

-- 8. Sum experience >= 10 by department-role
SELECT department, role, SUM(experience) AS total_exp
FROM employee_summary
GROUP BY department, role
HAVING SUM(experience) >= 10;

-- 9. Avg bonus = 6000 by role
SELECT role, AVG(bonus) AS avg_bonus
FROM employee_summary
GROUP BY role
HAVING AVG(bonus) = 6000;

-- 10. Max salary <= 95000 by department
SELECT department, MAX(salary) AS max_salary
FROM employee_summary
GROUP BY department
HAVING MAX(salary) <= 95000;

-- 11. Sum rating > 25 by role
SELECT role, SUM(rating) AS total_rating
FROM employee_summary
GROUP BY role
HAVING SUM(rating) > 25;

-- 12. Count != 3 by location
SELECT location, COUNT(*) AS emp_count
FROM employee_summary
GROUP BY location
HAVING COUNT(*) != 3;

-- 13. Avg age > 30 by department-location
SELECT department, location, AVG(age) AS avg_age
FROM employee_summary
GROUP BY department, location
HAVING AVG(age) > 30;

-- 14. Sum bonus IN (10000, 12000, 14000) by role
SELECT role, SUM(bonus) AS total_bonus
FROM employee_summary
GROUP BY role
HAVING SUM(bonus) IN (10000, 12000, 14000);

-- 15. Avg experience NOT BETWEEN 5 AND 15 by department
SELECT department, AVG(experience) AS avg_exp
FROM employee_summary
GROUP BY department
HAVING AVG(experience) NOT BETWEEN 5 AND 15;

-- 16. Min bonus >= 5000 by location-role
SELECT location, role, MIN(bonus) AS min_bonus
FROM employee_summary
GROUP BY location, role
HAVING MIN(bonus) >= 5000;

-- 17. Manager count > 1 by department
SELECT department, COUNT(*) AS mgr_count
FROM employee_summary
WHERE role = 'Manager'
GROUP BY department
HAVING COUNT(*) > 1;

-- 18. Total bonus NOT IN (10000, 20000) by location
SELECT location, SUM(bonus) AS total_bonus
FROM employee_summary
GROUP BY location
HAVING SUM(bonus) NOT IN (10000, 20000);

-- 19. Count BETWEEN 1 AND 3 by role
SELECT role, COUNT(emp_id) AS emp_count
FROM employee_summary
GROUP BY role
HAVING COUNT(emp_id) BETWEEN 1 AND 3;

-- 20. Avg salary != 80000 by department
SELECT department, AVG(salary) AS avg_salary
FROM employee_summary
GROUP BY department
HAVING AVG(salary) != 80000;
