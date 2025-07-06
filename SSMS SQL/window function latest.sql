-- ================================
-- WINDOW FUNCTION MASTER PRACTICE
-- ================================
use Vertocity

-- Drop existing tables
IF OBJECT_ID('sales_data', 'U') IS NOT NULL DROP TABLE sales_data;
IF OBJECT_ID('employee_performance', 'U') IS NOT NULL DROP TABLE employee_performance;
IF OBJECT_ID('monthly_bonus', 'U') IS NOT NULL DROP TABLE monthly_bonus;
GO

-- Create sales_data table
CREATE TABLE sales_data (
    sale_id INT,
    region VARCHAR(50),
    sales_rep VARCHAR(50),
    product VARCHAR(50),
    sale_amount DECIMAL(10,2),
    quantity INT,
    sale_date DATE,
    category VARCHAR(50)
);
-- Insert data
INSERT INTO sales_data VALUES
(1, 'North', 'Amit', 'Laptop', 70000, 2, '2024-01-01', 'Electronics'),
(2, 'North', 'Amit', 'Mouse', 2000, 5, '2024-01-02', 'Accessories'),
(3, 'South', 'Sneha', 'Chair', 8000, 2, '2024-01-03', 'Furniture'),
(4, 'East', 'Ravi', 'Keyboard', 2500, 3, '2024-01-04', 'Accessories'),
(5, 'West', 'Karan', 'Laptop', 75000, 1, '2024-01-05', 'Electronics'),
(6, 'East', 'Ravi', 'Mouse', 1800, 4, '2024-01-06', 'Accessories'),
(7, 'South', 'Sneha', 'Desk', 12000, 1, '2024-01-07', 'Furniture'),
(8, 'North', 'Amit', 'Tablet', 30000, 1, '2024-01-08', 'Electronics'),
(9, 'West', 'Karan', 'Chair', 5000, 2, '2024-01-09', 'Furniture'),
(10, 'East', 'Ravi', 'Tablet', 28000, 1, '2024-01-10', 'Electronics');

-- Create employee_performance table
CREATE TABLE employee_performance (
    emp_id INT,
    emp_name VARCHAR(100),
    month VARCHAR(20),
    score INT
);
INSERT INTO employee_performance VALUES
(1, 'Amit', 'Jan', 85),
(1, 'Amit', 'Feb', 80),
(1, 'Amit', 'Mar', 88),
(2, 'Sneha', 'Jan', 90),
(2, 'Sneha', 'Feb', 88),
(2, 'Sneha', 'Mar', 92),
(3, 'Ravi', 'Jan', 78),
(3, 'Ravi', 'Feb', 82),
(3, 'Ravi', 'Mar', 79);

-- Create monthly_bonus table
CREATE TABLE monthly_bonus (
    emp_id INT,
    emp_name VARCHAR(100),
    month VARCHAR(20),
    bonus INT
);
INSERT INTO monthly_bonus VALUES
(1, 'Amit', 'Jan', 5000),
(1, 'Amit', 'Feb', 5500),
(1, 'Amit', 'Mar', 6000),
(2, 'Sneha', 'Jan', 6000),
(2, 'Sneha', 'Feb', 6200),
(2, 'Sneha', 'Mar', 6400),
(3, 'Ravi', 'Jan', 4500),
(3, 'Ravi', 'Feb', 4700),
(3, 'Ravi', 'Mar', 4800);

-- =========================================
-- SUM WINDOW FUNCTION (3 examples)
-- =========================================
-- Q1: Show total sales per region
SELECT *, SUM(sale_amount) OVER (PARTITION BY region) AS sum_by_region FROM sales_data;

-- Q2: Show total quantity sold per category
SELECT *, SUM(quantity) OVER (PARTITION BY category) AS sum_qty_category FROM sales_data;

-- Q3: Show total sale amount per sales representative
SELECT *, SUM(sale_amount) OVER (PARTITION BY sales_rep) AS total_sales_rep FROM sales_data;

-- =========================================
-- AVG WINDOW FUNCTION (3 examples)
-- =========================================
-- Q1: Show average sales per region
SELECT *, AVG(sale_amount) OVER (PARTITION BY region) AS avg_sales_region FROM sales_data;

-- Q2: Show average quantity sold per category
SELECT *, AVG(quantity) OVER (PARTITION BY category) AS avg_qty_category FROM sales_data;

-- Q3: Show average sales per sales representative
SELECT *, AVG(sale_amount) OVER (PARTITION BY sales_rep) AS avg_sales_rep FROM sales_data;

-- =========================================
-- COUNT WINDOW FUNCTION (3 examples)
-- =========================================
-- Q1: Count number of sales per region
SELECT *, COUNT(*) OVER (PARTITION BY region) AS total_sales_count_region FROM sales_data;

-- Q2: Count products sold per category
SELECT *, COUNT(product) OVER (PARTITION BY category) AS product_count_category FROM sales_data;

-- Q3: Count number of sales entries per sales representative
SELECT *, COUNT(*) OVER (PARTITION BY sales_rep) AS count_by_rep FROM sales_data;

-- =========================================
-- MIN WINDOW FUNCTION (3 examples)
-- =========================================
-- Q1: Find minimum sale amount per category
SELECT *, MIN(sale_amount) OVER (PARTITION BY category) AS min_amt_category FROM sales_data;

-- Q2: Find minimum quantity sold per region
SELECT *, MIN(quantity) OVER (PARTITION BY region) AS min_qty_region FROM sales_data;

-- Q3: Find overall minimum sale amount
SELECT *, MIN(sale_amount) OVER () AS overall_min_sale FROM sales_data;

-- =========================================
-- MAX WINDOW FUNCTION (3 examples)
-- =========================================
-- Q1: Show maximum sale amount per region
SELECT *, MAX(sale_amount) OVER (PARTITION BY region) AS max_amt_region FROM sales_data;

-- Q2: Show maximum quantity per sales rep
SELECT *, MAX(quantity) OVER (PARTITION BY sales_rep) AS max_qty_rep FROM sales_data;

-- Q3: Show maximum sale amount overall
SELECT *, MAX(sale_amount) OVER () AS max_sale_overall FROM sales_data;

-- =========================================
-- ROW_NUMBER FUNCTION (3 examples)
-- =========================================
-- Q1: Assign row number to employee records per employee ordered by month
SELECT *, ROW_NUMBER() OVER (PARTITION BY emp_id ORDER BY month) AS row_no FROM employee_performance;

-- Q2: Assign row number per region by sale date
SELECT *, ROW_NUMBER() OVER (PARTITION BY region ORDER BY sale_date) AS row_num_region FROM sales_data;

-- Q3: Assign row number to sales per rep by highest sale amount
SELECT *, ROW_NUMBER() OVER (PARTITION BY sales_rep ORDER BY sale_amount DESC) AS sales_priority FROM sales_data;

-- =========================================
-- RANK FUNCTION (3 examples)
-- =========================================
-- Q1: Rank scores of employees per emp_id
SELECT *, RANK() OVER (PARTITION BY emp_id ORDER BY score DESC) AS rank_score FROM employee_performance;

-- Q2: Rank sales amounts within each region
SELECT *, RANK() OVER (PARTITION BY region ORDER BY sale_amount DESC) AS sale_rank_region FROM sales_data;

-- Q3: Rank sales globally by amount
SELECT *, RANK() OVER (ORDER BY sale_amount DESC) AS global_sales_rank FROM sales_data;

-- =========================================
-- DENSE_RANK FUNCTION (3 examples)
-- =========================================
-- Q1: Dense rank scores per employee
SELECT *, DENSE_RANK() OVER (PARTITION BY emp_id ORDER BY score DESC) AS dense_rank_score FROM employee_performance;

-- Q2: Dense rank of sale amount per category
SELECT *, DENSE_RANK() OVER (PARTITION BY category ORDER BY sale_amount DESC) AS cat_dense_rank FROM sales_data;

-- Q3: Dense rank of quantity sold across all
SELECT *, DENSE_RANK() OVER (ORDER BY quantity DESC) AS quantity_dense_rank FROM sales_data;

-- =========================================
-- LEAD FUNCTION (3 examples)
-- =========================================
-- Q1: Show next month's bonus per employee
SELECT *, LEAD(bonus) OVER (PARTITION BY emp_id ORDER BY month) AS next_bonus FROM monthly_bonus;

-- Q2: Show bonus 2 months later
SELECT *, LEAD(bonus, 2) OVER (PARTITION BY emp_id ORDER BY month) AS bonus_2_months_later FROM monthly_bonus;

-- Q3: Difference to next month’s bonus
SELECT *, bonus - LEAD(bonus) OVER (PARTITION BY emp_id ORDER BY month) AS drop_next_bonus FROM monthly_bonus;

-- =========================================
-- LAG FUNCTION (3 examples)
-- =========================================
-- Q1: Show previous month’s bonus
SELECT *, LAG(bonus) OVER (PARTITION BY emp_id ORDER BY month) AS previous_bonus FROM monthly_bonus;

-- Q2: Show bonus 2 months ago
SELECT *, LAG(bonus, 2) OVER (PARTITION BY emp_id ORDER BY month) AS bonus_2_months_ago FROM monthly_bonus;

-- Q3: Difference from previous bonus
SELECT *, bonus - LAG(bonus) OVER (PARTITION BY emp_id ORDER BY month) AS change_from_prev FROM monthly_bonus;
