-- Step 1: Create Database and Use It
CREATE DATABASE Vertocity;

USE Vertocity;

-- Table: employees
CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(100),
    age INT,
    department VARCHAR(50)
);


-- Insert sample data into employees
INSERT INTO employees (emp_id, emp_name, age, department) VALUES
(1, 'Udaya', 24, 'IT'),
(2, 'Ravi', 26, 'HR'),
(3, 'Anita', 23, 'Finance');


-- Table: products
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock INT,
    supplier VARCHAR(100),
    manufacture_date DATE,
    expiry_date DATE,
    is_available BIT,
    rating FLOAT
);


-- Insert sample data into products
INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 60000.00, 20, 'HP India', '2024-01-10', '2027-01-10', 1, 4.5),
(102, 'Headphones', 'Electronics', 1500.00, 100, 'Boat', '2024-03-01', '2026-03-01', 1, 4.2),
(103, 'Protein Bar', 'Food', 100.00, 200, 'Nestle', '2024-05-01', '2025-05-01', 1, 3.8);


-- Table: students (with primary key)
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    email VARCHAR(100),
    city VARCHAR(50)
);


-- Insert sample student data
INSERT INTO students VALUES
(1, 'Udaya', 22, 'udaya@mail.com', 'Bangalore'),
(2, 'Ravi', 23, 'ravi@mail.com', 'Hyderabad'),
(3, 'Anita', 21, 'anita@mail.com', 'Delhi');
