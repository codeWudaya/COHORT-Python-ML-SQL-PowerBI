-- Use Vertocity DB
USE Vertocity;
GO

-- Drop if exists
IF OBJECT_ID('support_tickets', 'U') IS NOT NULL DROP TABLE support_tickets;
IF OBJECT_ID('logins', 'U') IS NOT NULL DROP TABLE logins;
IF OBJECT_ID('orders', 'U') IS NOT NULL DROP TABLE orders;
IF OBJECT_ID('users', 'U') IS NOT NULL DROP TABLE users;
GO

-- Master Table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    email VARCHAR(100),
    registration_date DATE,
    city VARCHAR(100)
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    status VARCHAR(20)
);

-- Logins Table
CREATE TABLE logins (
    login_id INT PRIMARY KEY,
    user_id INT,
    login_time DATETIME,
    device_type VARCHAR(50)
);

-- Support Tickets Table
CREATE TABLE support_tickets (
    ticket_id INT PRIMARY KEY,
    user_id INT,
    issue_type VARCHAR(100),
    created_at DATE,
    resolved BIT
);

-- Insert users (master table)
INSERT INTO users VALUES
(1, 'Alice', 'alice@mail.com', '2023-01-01', 'Delhi'),
(2, 'Bob', 'bob@mail.com', '2023-02-01', 'Mumbai'),
(3, 'Charlie', 'charlie@mail.com', '2023-03-01', 'Chennai'),
(4, 'Diana', 'diana@mail.com', '2023-04-01', 'Bangalore'),
(5, 'Evan', 'evan@mail.com', '2023-05-01', 'Hyderabad'),
(6, 'Fiona', 'fiona@mail.com', '2023-06-01', 'Kolkata');

-- Insert orders (some users only)
INSERT INTO orders VALUES
(101, 1, '2023-08-01', 1200, 'Completed'),
(102, 2, '2023-08-05', 300, 'Pending'),
(103, 4, '2023-08-07', 450, 'Completed');

-- Insert logins
INSERT INTO logins VALUES
(201, 1, '2023-08-10 09:00', 'Mobile'),
(202, 2, '2023-08-10 10:00', 'Web'),
(203, 1, '2023-08-11 11:00', 'Web'),
(204, 5, '2023-08-12 12:00', 'Mobile');

-- Insert support tickets
INSERT INTO support_tickets VALUES
(301, 2, 'Payment Issue', '2023-08-11', 1),
(302, 3, 'Login Error', '2023-08-12', 0),
(303, 1, 'Refund Request', '2023-08-13', 1);



-------------------------------------------------------------------------------------
-- 1. All users and their order amount (if any)
SELECT u.user_name, o.amount
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id;

-- 2. All users and their last login device
SELECT u.user_name, l.device_type
FROM users u
LEFT JOIN logins l ON u.user_id = l.user_id;

-- 3. Users with no orders
SELECT u.user_name
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
WHERE o.user_id IS NULL;

-- 4. Users and whether they raised any support tickets
SELECT u.user_name, s.issue_type
FROM users u
LEFT JOIN support_tickets s ON u.user_id = s.user_id;

-- 5. Total amount ordered by each user (if any)
SELECT u.user_name, SUM(o.amount) AS total_spent
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_name;

-- 6. Count of logins per user
SELECT u.user_name, COUNT(l.login_id) AS login_count
FROM users u
LEFT JOIN logins l ON u.user_id = l.user_id
GROUP BY u.user_name;

-- 7. Count of support tickets per user
SELECT u.user_name, COUNT(s.ticket_id) AS ticket_count
FROM users u
LEFT JOIN support_tickets s ON u.user_id = s.user_id
GROUP BY u.user_name;

-- 8. Users and latest login time (if any)
SELECT u.user_name, MAX(l.login_time) AS last_login
FROM users u
LEFT JOIN logins l ON u.user_id = l.user_id
GROUP BY u.user_name;

-- 9. Users and CASE: show 'Yes' if placed order
SELECT u.user_name,
  CASE WHEN o.user_id IS NULL THEN 'No' ELSE 'Yes' END AS has_ordered
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id;

-- 10. Users who submitted tickets but have no orders
SELECT u.user_name
FROM users u
LEFT JOIN support_tickets s ON u.user_id = s.user_id
LEFT JOIN orders o ON u.user_id = o.user_id
WHERE s.ticket_id IS NOT NULL AND o.user_id IS NULL;

-- 11. City-wise total login count
SELECT u.city, COUNT(l.login_id) AS login_count
FROM users u
LEFT JOIN logins l ON u.user_id = l.user_id
GROUP BY u.city;

-- 12. Show unresolved tickets and user name
SELECT u.user_name, s.issue_type
FROM users u
LEFT JOIN support_tickets s ON u.user_id = s.user_id
WHERE s.resolved = 0;

-- 13. User and total no. of linked tables they appear in
SELECT u.user_name,
    COUNT(DISTINCT o.order_id) + COUNT(DISTINCT l.login_id) + COUNT(DISTINCT s.ticket_id) AS activity_score
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
LEFT JOIN logins l ON u.user_id = l.user_id
LEFT JOIN support_tickets s ON u.user_id = s.user_id
GROUP BY u.user_name;

-- 14. User, login method (Web/Mobile), and order status
SELECT u.user_name, l.device_type, o.status
FROM users u
LEFT JOIN logins l ON u.user_id = l.user_id
LEFT JOIN orders o ON u.user_id = o.user_id;

-- 15. List all users and whether they have any data in any table
SELECT u.user_name,
  CASE WHEN o.user_id IS NOT NULL THEN 'Yes' ELSE 'No' END AS has_orders,
  CASE WHEN l.user_id IS NOT NULL THEN 'Yes' ELSE 'No' END AS has_logins,
  CASE WHEN s.user_id IS NOT NULL THEN 'Yes' ELSE 'No' END AS has_tickets
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
LEFT JOIN logins l ON u.user_id = l.user_id
LEFT JOIN support_tickets s ON u.user_id = s.user_id;
