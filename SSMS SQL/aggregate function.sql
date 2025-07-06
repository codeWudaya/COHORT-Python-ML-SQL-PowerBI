USE Vertocity;
GO

-- Drop the table if it already exists
IF OBJECT_ID('employee_performance', 'U') IS NOT NULL
    DROP TABLE employee_performance;
GO

-- Create the employee_performance table with 10 columns
CREATE TABLE employee_performance (
    emp_id INT PRIMARY KEY,              -- Employee ID
    emp_name VARCHAR(100),               -- Employee Name
    department VARCHAR(50),              -- Department
    age INT,                             -- Age
    experience_years INT,                -- Years of Experience
    salary DECIMAL(10,2),                -- Monthly Salary
    bonus DECIMAL(10,2),                 -- Yearly Bonus
    rating FLOAT,                        -- Performance Rating (out of 10)
    leaves_taken INT,                    -- Number of Leaves
    project_count INT                    -- Projects handled
);
GO

-- Insert sample data
INSERT INTO employee_performance VALUES
(1, 'John Doe', 'IT', 28, 4, 70000, 5000, 8.9, 5, 3),
(2, 'Jane Smith', 'HR', 35, 10, 80000, 6000, 9.2, 2, 4),
(3, 'Alice Brown', 'Finance', 40, 15, 90000, 7000, 9.0, 3, 5),
(4, 'Bob White', 'IT', 30, 6, 72000, 5500, 8.5, 6, 2),
(5, 'Charlie Black', 'Marketing', 25, 2, 65000, 4000, 8.2, 4, 3),
(6, 'Diana Prince', 'HR', 32, 8, 78000, 6200, 9.4, 2, 4),
(7, 'Evan Wright', 'Finance', 45, 20, 95000, 8000, 9.1, 1, 6),
(8, 'Fiona Green', 'IT', 29, 5, 73000, 5100, 8.7, 7, 3),
(9, 'George King', 'Marketing', 38, 12, 85000, 6300, 9.3, 2, 5),
(10, 'Helen Clark', 'HR', 36, 11, 81000, 6100, 9.0, 1, 4);
GO


-- 1. Total number of employees
SELECT COUNT(*) AS total_employees FROM employee_performance;

-- 2. Total salary paid to all employees
SELECT SUM(salary) AS total_salary FROM employee_performance;

-- 3. Average bonus across all employees
SELECT AVG(bonus) AS avg_bonus FROM employee_performance;

-- 4. Maximum rating among employees
SELECT MAX(rating) AS max_rating FROM employee_performance;

-- 5. Minimum rating among employees
SELECT MIN(rating) AS min_rating FROM employee_performance;

-- 6. Total leaves taken by employees under age 30
SELECT SUM(leaves_taken) AS leaves_young FROM employee_performance WHERE age < 30;

-- 7. Count of employees with rating above 9
SELECT COUNT(*) AS top_rated_employees FROM employee_performance WHERE rating > 9;

-- 8. Average salary of employees with experience > 10 years
SELECT AVG(salary) AS avg_senior_salary FROM employee_performance WHERE experience_years > 10;

-- 9. Total bonus of employees in HR department
SELECT SUM(bonus) AS hr_bonus FROM employee_performance WHERE department = 'HR';

-- 10. Minimum age of employees with salary > 80000
SELECT MIN(age) AS min_age_high_salary FROM employee_performance WHERE salary > 80000;

-- 11. Total projects for employees with rating > 9 OR bonus > 6000
SELECT SUM(project_count) AS total_projects_top FROM employee_performance WHERE rating > 9 OR bonus > 6000;

-- 12. Average age of employees who took < 3 leaves
SELECT AVG(age) AS avg_age_few_leaves FROM employee_performance WHERE leaves_taken < 3;

-- 13. Max bonus of employees in IT department and age < 35
SELECT MAX(bonus) AS max_it_bonus FROM employee_performance WHERE department = 'IT' AND age < 35;

-- 14. Total experience years for employees not in 'Marketing'
SELECT SUM(experience_years) AS total_exp_non_marketing FROM employee_performance WHERE department != 'Marketing';

-- 15. Count of employees with salary BETWEEN 70000 AND 80000
SELECT COUNT(*) AS mid_range_salary FROM employee_performance WHERE salary BETWEEN 70000 AND 80000;

-- 16. Average rating for employees with more than 5 projects
SELECT AVG(rating) AS avg_rating_busy_emp FROM employee_performance WHERE project_count > 5;

-- 17. Total bonus of employees with age NOT BETWEEN 30 AND 40
SELECT SUM(bonus) AS bonus_young_old FROM employee_performance WHERE age NOT BETWEEN 30 AND 40;

-- 18. Max salary among employees with rating >= 9
SELECT MAX(salary) AS max_salary_top_rated FROM employee_performance WHERE rating >= 9;

-- 19. Min salary of employees with bonus < 6000
SELECT MIN(salary) AS min_salary_low_bonus FROM employee_performance WHERE bonus < 6000;

-- 20. Count of employees with names starting with 'J'
SELECT COUNT(*) AS j_names FROM employee_performance WHERE emp_name LIKE 'J%';

-- 21. Average salary of employees whose department name contains 'a'
SELECT AVG(salary) AS avg_salary_dept_a FROM employee_performance WHERE department LIKE '%a%';

-- 22. Sum of projects for employees with NOT rating < 9
SELECT SUM(project_count) AS projects_high_rating FROM employee_performance WHERE NOT rating < 9;

-- 23. Max experience among employees aged over 40
SELECT MAX(experience_years) AS max_exp_40plus FROM employee_performance WHERE age > 40;

-- 24. Total leaves taken by employees earning < 75000
SELECT SUM(leaves_taken) AS leaves_low_income FROM employee_performance WHERE salary < 75000;

-- 25. Average bonus for employees whose project count is even
SELECT AVG(bonus) AS avg_bonus_even_projects FROM employee_performance WHERE project_count % 2 = 0;
