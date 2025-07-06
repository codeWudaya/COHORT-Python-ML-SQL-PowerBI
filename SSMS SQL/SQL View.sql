-- Recreate Tables and Views from Scratch
-- Ensure Database
IF DB_ID('Vertocity') IS NULL CREATE DATABASE Vertocity;
USE Vertocity;
GO

-- Drop tables if they exist
IF OBJECT_ID('products', 'U') IS NOT NULL DROP TABLE products;
IF OBJECT_ID('employees_extended', 'U') IS NOT NULL DROP TABLE employees_extended;
IF OBJECT_ID('departments_extended', 'U') IS NOT NULL DROP TABLE departments_extended;
IF OBJECT_ID('projects_extended', 'U') IS NOT NULL DROP TABLE projects_extended;
GO

-- Drop views if they exist
DECLARE @sql NVARCHAR(MAX) = N'';
SELECT @sql += 'DROP VIEW [' + name + '];'
FROM sys.views
WHERE name LIKE 'vw_%';
EXEC sp_executesql @sql;
GO

-- Create and insert into products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);
INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 75000, 10),
(2, 'Tablet', 'Electronics', 30000, 20),
(3, 'Mouse', 'Accessories', 1500, 100),
(4, 'Keyboard', 'Accessories', 2500, 50),
(5, 'Chair', 'Furniture', 5000, 25),
(6, 'Desk', 'Furniture', 10000, 15),
(7, 'Headphones', 'Electronics', 4000, 30);

-- Create and insert into employees_extended
CREATE TABLE employees_extended (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department_id INT,
    hire_date DATE,
    salary DECIMAL(10, 2),
    position VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20)
);
INSERT INTO employees_extended VALUES
(1, 'Amit', 101, '2022-01-10', 60000, 'Manager', 'amit@corp.com', '9999999999'),
(2, 'Sneha', 102, '2021-05-20', 55000, 'Analyst', 'sneha@corp.com', '8888888888'),
(3, 'Ravi', 101, '2020-03-15', 50000, 'Developer', 'ravi@corp.com', '7777777777'),
(4, 'Priya', 103, '2019-11-01', 65000, 'Lead', 'priya@corp.com', '6666666666'),
(5, 'Karan', 104, '2018-07-25', 62000, 'Engineer', 'karan@corp.com', '5555555555');

-- Create and insert into departments_extended
CREATE TABLE departments_extended (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location VARCHAR(100),
    head VARCHAR(100),
    budget DECIMAL(12,2),
    established_year INT,
    extension INT,
    floor INT
);
INSERT INTO departments_extended VALUES
(101, 'IT', 'Bangalore', 'Ramesh', 1000000.00, 2010, 2121, 5),
(102, 'HR', 'Mumbai', 'Sunita', 500000.00, 2012, 2122, 3),
(103, 'Finance', 'Delhi', 'Anil', 750000.00, 2011, 2123, 4),
(104, 'Sales', 'Chennai', 'Deepa', 850000.00, 2013, 2124, 2);

-- Create and insert into projects_extended
CREATE TABLE projects_extended (
    project_id INT PRIMARY KEY,
    emp_id INT,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    budget DECIMAL(12, 2),
    client_name VARCHAR(100),
    status VARCHAR(50)
);
INSERT INTO projects_extended VALUES
(1, 1, 'Alpha', '2023-01-01', '2023-06-30', 250000.00, 'ABC Corp', 'Completed'),
(2, 2, 'Beta', '2023-02-15', '2023-07-15', 300000.00, 'XYZ Ltd', 'Ongoing'),
(3, 3, 'Gamma', '2023-03-01', '2023-08-01', 150000.00, 'LMN Pvt', 'Ongoing');

-- 5 Views from single table
CREATE VIEW vw_employee_basic AS
SELECT emp_id, emp_name, position FROM employees_extended;
SELECT * FROM vw_employee_basic;

CREATE VIEW vw_employee_salary AS
SELECT emp_id, salary FROM employees_extended;
SELECT * FROM vw_employee_salary;

CREATE VIEW vw_employee_contact AS
SELECT emp_id, email, phone FROM employees_extended;
SELECT * FROM vw_employee_contact;

CREATE VIEW vw_employee_department AS
SELECT emp_id, department_id FROM employees_extended;
SELECT * FROM vw_employee_department;

CREATE VIEW vw_employee_hire AS
SELECT emp_id, hire_date FROM employees_extended;
SELECT * FROM vw_employee_hire;

-- 10 Views from join of 2 tables
CREATE VIEW vw_emp_dept_full AS
SELECT e.emp_name, d.department_name, e.salary
FROM employees_extended e
JOIN departments_extended d ON e.department_id = d.department_id;
SELECT * FROM vw_emp_dept_full;

CREATE VIEW vw_emp_location AS
SELECT e.emp_name, d.location FROM employees_extended e
JOIN departments_extended d ON e.department_id = d.department_id;
SELECT * FROM vw_emp_location;

CREATE VIEW vw_dept_heads AS
SELECT d.department_name, d.head FROM employees_extended e
JOIN departments_extended d ON e.department_id = d.department_id;
SELECT * FROM vw_dept_heads;

CREATE VIEW vw_emp_floor AS
SELECT e.emp_name, d.floor FROM employees_extended e
JOIN departments_extended d ON e.department_id = d.department_id;
SELECT * FROM vw_emp_floor;

CREATE VIEW vw_salary_budget AS
SELECT e.salary, d.budget FROM employees_extended e
JOIN departments_extended d ON e.department_id = d.department_id;
SELECT * FROM vw_salary_budget;

CREATE VIEW vw_email_dept AS
SELECT e.email, d.department_name FROM employees_extended e
JOIN departments_extended d ON e.department_id = d.department_id;
SELECT * FROM vw_email_dept;

CREATE VIEW vw_emp_established AS
SELECT e.emp_name, d.established_year FROM employees_extended e
JOIN departments_extended d ON e.department_id = d.department_id;
SELECT * FROM vw_emp_established;

CREATE VIEW vw_position_location AS
SELECT e.position, d.location FROM employees_extended e
JOIN departments_extended d ON e.department_id = d.department_id;
SELECT * FROM vw_position_location;

CREATE VIEW vw_phone_extension AS
SELECT e.phone, d.extension FROM employees_extended e
JOIN departments_extended d ON e.department_id = d.department_id;
SELECT * FROM vw_phone_extension;

CREATE VIEW vw_full_detail AS
SELECT * FROM employees_extended e
JOIN departments_extended d ON e.department_id = d.department_id;
SELECT * FROM vw_full_detail;

-- 5 Views joining 3 tables
CREATE VIEW vw_project_full AS
SELECT e.emp_name, d.department_name, p.project_name
FROM employees_extended e
JOIN departments_extended d ON e.department_id = d.department_id
JOIN projects_extended p ON e.emp_id = p.emp_id;
SELECT * FROM vw_project_full;

CREATE VIEW vw_project_status AS
SELECT e.emp_name, p.project_name, p.status
FROM employees_extended e
JOIN projects_extended p ON e.emp_id = p.emp_id;
SELECT * FROM vw_project_status;

CREATE VIEW vw_project_client AS
SELECT d.department_name, p.client_name
FROM departments_extended d
JOIN employees_extended e ON d.department_id = e.department_id
JOIN projects_extended p ON e.emp_id = p.emp_id;
SELECT * FROM vw_project_client;

CREATE VIEW vw_project_timeline AS
SELECT e.emp_name, p.project_name, p.start_date, p.end_date
FROM employees_extended e
JOIN projects_extended p ON e.emp_id = p.emp_id;
SELECT * FROM vw_project_timeline;

CREATE VIEW vw_project_budget_detail AS
SELECT e.emp_name, d.department_name, p.budget
FROM employees_extended e
JOIN departments_extended d ON e.department_id = d.department_id
JOIN projects_extended p ON e.emp_id = p.emp_id;
SELECT * FROM vw_project_budget_detail;