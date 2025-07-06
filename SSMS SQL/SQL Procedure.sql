USE Vertocity;
GO

-- Drop and Create Table
IF OBJECT_ID('employee_info', 'U') IS NOT NULL DROP TABLE employee_info;
CREATE TABLE employee_info (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender CHAR(1),
    dob DATE,
    phone VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    department VARCHAR(50),
    position VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

-- Insert 10 Records
INSERT INTO employee_info VALUES
(1, 'John', 'Doe', 'M', '1990-01-01', '9876543210', 'john@example.com', '123 St', 'Mumbai', 'MH', 'India', 'IT', 'Developer', 80000, '2020-01-01'),
(2, 'Jane', 'Smith', 'F', '1985-02-15', '9876543211', 'jane@example.com', '234 St', 'Delhi', 'DL', 'India', 'HR', 'Manager', 90000, '2018-03-15'),
(3, 'Amit', 'Kumar', 'M', '1992-07-10', '9876543212', 'amit@example.com', '345 St', 'Bangalore', 'KA', 'India', 'IT', 'Tester', 75000, '2019-06-10'),
(4, 'Rita', 'Roy', 'F', '1988-05-05', '9876543213', 'rita@example.com', '456 St', 'Kolkata', 'WB', 'India', 'Finance', 'Analyst', 82000, '2021-01-05'),
(5, 'Vikram', 'Singh', 'M', '1991-08-20', '9876543214', 'vikram@example.com', '567 St', 'Chennai', 'TN', 'India', 'Marketing', 'Executive', 70000, '2022-02-20'),
(6, 'Priya', 'Mehta', 'F', '1993-12-12', '9876543215', 'priya@example.com', '678 St', 'Pune', 'MH', 'India', 'IT', 'Developer', 85000, '2020-09-01'),
(7, 'Rohit', 'Sharma', 'M', '1989-11-30', '9876543216', 'rohit@example.com', '789 St', 'Hyderabad', 'TS', 'India', 'Sales', 'Executive', 68000, '2017-04-25'),
(8, 'Neha', 'Patel', 'F', '1994-06-25', '9876543217', 'neha@example.com', '890 St', 'Ahmedabad', 'GJ', 'India', 'IT', 'Support', 72000, '2021-11-11'),
(9, 'Anil', 'Verma', 'M', '1987-09-09', '9876543218', 'anil@example.com', '901 St', 'Bhopal', 'MP', 'India', 'Admin', 'Clerk', 60000, '2016-06-06'),
(10, 'Sneha', 'Kapoor', 'F', '1995-03-18', '9876543219', 'sneha@example.com', '012 St', 'Lucknow', 'UP', 'India', 'HR', 'Executive', 65000, '2023-01-01');

-- Procedure 1: Get all employees
CREATE PROCEDURE sp_get_all_employees AS
BEGIN
    SELECT * FROM employee_info;
END;
-- Execute:
EXEC sp_get_all_employees;

-- Procedure 2: Get employees from IT
CREATE PROCEDURE sp_get_it_employees AS
BEGIN
    SELECT * FROM employee_info WHERE department = 'IT';
END;
-- Execute:
EXEC sp_get_it_employees;

-- Procedure 3: Get high salary employees
CREATE PROCEDURE sp_high_salary_employees AS
BEGIN
    SELECT * FROM employee_info WHERE salary > 80000;
END;
-- Execute:
EXEC sp_high_salary_employees;

-- Procedure 4: Get employees by city
CREATE PROCEDURE sp_employees_by_city @city_name VARCHAR(50) AS
BEGIN
    SELECT * FROM employee_info WHERE city = @city_name;
END;
-- Execute:
EXEC sp_employees_by_city @city_name = 'Mumbai';

-- Procedure 5: Count employees by department
CREATE PROCEDURE sp_count_by_department AS
BEGIN
    SELECT department, COUNT(*) AS emp_count FROM employee_info GROUP BY department;
END;
-- Execute:
EXEC sp_count_by_department;

-- Procedure 6: Get employee by ID
CREATE PROCEDURE sp_get_employee_by_id @id INT AS
BEGIN
    SELECT * FROM employee_info WHERE emp_id = @id;
END;
-- Execute:
EXEC sp_get_employee_by_id @id = 3;

-- Procedure 7: Get employees joined after a date
CREATE PROCEDURE sp_joined_after @date DATE AS
BEGIN
    SELECT * FROM employee_info WHERE hire_date > @date;
END;
-- Execute:
EXEC sp_joined_after @date = '2021-01-01';

-- Procedure 8: Get female employees
CREATE PROCEDURE sp_female_employees AS
BEGIN
    SELECT * FROM employee_info WHERE gender = 'F';
END;
-- Execute:
EXEC sp_female_employees;

-- Procedure 9: Update salary
CREATE PROCEDURE sp_update_salary @id INT, @newsalary DECIMAL(10,2) AS
BEGIN
    UPDATE employee_info SET salary = @newsalary WHERE emp_id = @id;
END;
-- Execute:
EXEC sp_update_salary @id = 5, @newsalary = 95000;

-- Procedure 10: Delete employee
CREATE PROCEDURE sp_delete_employee @id INT AS
BEGIN
    DELETE FROM employee_info WHERE emp_id = @id;
END;
-- Execute:
EXEC sp_delete_employee @id = 10;
