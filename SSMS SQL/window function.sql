-- Use Vertocity DB
USE Vertocity;
GO

-- Drop if exists
IF OBJECT_ID('sales_data', 'U') IS NOT NULL DROP TABLE sales_data;
GO

-- Step 1: Create Table
CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    region VARCHAR(50),
    product VARCHAR(50),
    sale_amount INT,
    sale_date DATE,
    target INT
);

-- Step 2: Insert Sample Data
INSERT INTO sales_data VALUES
(1, 'Alice', 'North', 'Laptop', 50000, '2024-01-01', 45000),
(2, 'Bob', 'South', 'Tablet', 30000, '2024-01-03', 32000),
(3, 'Charlie', 'North', 'Mobile', 40000, '2024-01-04', 35000),
(4, 'Diana', 'East', 'Laptop', 55000, '2024-01-05', 50000),
(5, 'Evan', 'West', 'Mobile', 20000, '2024-01-06', 25000),
(6, 'Fiona', 'North', 'Tablet', 35000, '2024-01-07', 30000),
(7, 'George', 'South', 'Laptop', 60000, '2024-01-08', 58000),
(8, 'Hema', 'East', 'Tablet', 32000, '2024-01-09', 30000),
(9, 'Ivan', 'West', 'Laptop', 48000, '2024-01-10', 47000),
(10, 'Jiya', 'South', 'Mobile', 37000, '2024-01-11', 36000);


---------------------------------------------------------------------

-- 1. ROW_NUMBER(): Assigns a unique row number per region based on sale_amount descending
SELECT *, ROW_NUMBER() OVER (PARTITION BY region ORDER BY sale_amount DESC) AS row_num
FROM sales_data;

-- 2. RANK(): Ranks within region with gaps
SELECT *, RANK() OVER (PARTITION BY region ORDER BY sale_amount DESC) AS sale_rank
FROM sales_data;

-- 3. DENSE_RANK(): Ranks within region without gaps
SELECT *, DENSE_RANK() OVER (PARTITION BY region ORDER BY sale_amount DESC) AS dense_rank
FROM sales_data;

-- 4. NTILE(3): Divide records into 3 equal buckets based on sale_amount
SELECT *, NTILE(3) OVER (ORDER BY sale_amount DESC) AS ntile_group
FROM sales_data;

-- 5. LAG(): Previous employee's sale in the same region
SELECT emp_name, region, sale_amount,
       LAG(sale_amount) OVER (PARTITION BY region ORDER BY sale_date) AS prev_sale
FROM sales_data;

-- 6. LEAD(): Next employee's sale in the same region
SELECT emp_name, region, sale_amount,
       LEAD(sale_amount) OVER (PARTITION BY region ORDER BY sale_date) AS next_sale
FROM sales_data;

-- 7. FIRST_VALUE(): First sale in each region
SELECT emp_name, region, sale_amount,
       FIRST_VALUE(sale_amount) OVER (PARTITION BY region ORDER BY sale_date) AS first_sale
FROM sales_data;

-- 8. LAST_VALUE(): Last sale in each region based on sale_date
SELECT emp_name, region, sale_amount,
       LAST_VALUE(sale_amount) OVER (
         PARTITION BY region ORDER BY sale_date 
         ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS last_sale
FROM sales_data;

-- 9. SUM(): Running total of sale_amount within region
SELECT emp_name, region, sale_amount,
       SUM(sale_amount) OVER (PARTITION BY region ORDER BY sale_date) AS running_total
FROM sales_data;

-- 10. AVG(): Average sale per region
SELECT emp_name, region, sale_amount,
       AVG(sale_amount) OVER (PARTITION BY region) AS avg_region_sale
FROM sales_data;

-- 11. MAX(): Maximum sale in each region
SELECT emp_name, region, sale_amount,
       MAX(sale_amount) OVER (PARTITION BY region) AS max_sale
FROM sales_data;

-- 12. MIN(): Minimum sale in each region
SELECT emp_name, region, sale_amount,
       MIN(sale_amount) OVER (PARTITION BY region) AS min_sale
FROM sales_data;

-- 13. CUME_DIST(): Cumulative distribution of sale_amount per region
SELECT emp_name, region, sale_amount,
       CUME_DIST() OVER (PARTITION BY region ORDER BY sale_amount) AS cum_dist
FROM sales_data;

-- 14. PERCENT_RANK(): Percentile rank of sale_amount per region
SELECT emp_name, region, sale_amount,
       PERCENT_RANK() OVER (PARTITION BY region ORDER BY sale_amount) AS percent_rank
FROM sales_data;

-- 15. Difference between sale and target using window
SELECT emp_name, region, sale_amount, target,
       sale_amount - target AS target_diff
FROM sales_data;
