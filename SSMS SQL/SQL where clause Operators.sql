-- Use existing database
USE Vertocity;
GO

-- Drop the table if it already exists in the current database
IF OBJECT_ID('players', 'U') IS NOT NULL    -- OBJECT_ID returns the object ID if it exists; 'U' stands for user-defined table
    DROP TABLE players;                     -- DROP TABLE deletes the table permanently if it exists
GO                                          -- GO is a batch separator; it tells SSMS to execute the above block before continuing


-- Create players table
CREATE TABLE players (
    player_id INT PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(50),
    age INT,
    role VARCHAR(50),
    matches_played INT,
    runs INT,
    wickets INT,
    rating FLOAT
);
GO

-- Insert 10 sample rows
INSERT INTO players VALUES
(1, 'Virat Kohli', 'India', 35, 'Batsman', 270, 13000, 5, 9.5),
(2, 'Rohit Sharma', 'India', 36, 'Batsman', 240, 10000, 3, 9.0),
(3, 'MS Dhoni', 'India', 42, 'Wicket Keeper', 300, 10700, 1, 8.8),
(4, 'Bumrah', 'India', 30, 'Bowler', 150, 500, 250, 8.9),
(5, 'Ben Stokes', 'England', 32, 'All-Rounder', 180, 4500, 120, 8.6),
(6, 'Steve Smith', 'Australia', 34, 'Batsman', 210, 9200, 2, 8.7),
(7, 'Mitchell Starc', 'Australia', 33, 'Bowler', 160, 600, 220, 8.5),
(8, 'Kane Williamson', 'New Zealand', 33, 'Batsman', 190, 7500, 1, 8.9),
(9, 'Rashid Khan', 'Afghanistan', 26, 'Bowler', 140, 800, 300, 9.2),
(10, 'Shakib Al Hasan', 'Bangladesh', 37, 'All-Rounder', 250, 7000, 200, 8.4);
GO

-- 1. WHERE with equality
SELECT * FROM players WHERE country = 'India'; -- Only Indian players

-- 2. WHERE with inequality
SELECT * FROM players WHERE country != 'India'; -- All non-Indian players

-- 3. Greater than condition
SELECT * FROM players WHERE rating > 9.0; -- Highly rated players

-- 4. Less than condition
SELECT * FROM players WHERE age < 30; -- Young players

-- 5. Greater than or equal
SELECT * FROM players WHERE runs >= 10000; -- Century scorers

-- 6. Less than or equal
SELECT * FROM players WHERE matches_played <= 200; -- Less experienced players

-- 7. AND: combine multiple conditions
SELECT * FROM players WHERE age < 35 AND rating > 9; -- Young and top-rated

-- 8. OR: at least one condition true
SELECT * FROM players WHERE country = 'India' OR country = 'Australia'; -- India or Aus players

-- 9. IN: match any value from a list
SELECT * FROM players WHERE country IN ('India', 'Australia', 'England');

-- 10. NOT IN: exclude values
SELECT * FROM players WHERE country NOT IN ('India', 'Australia'); 

-- 11. BETWEEN: check range inclusive
SELECT * FROM players WHERE age BETWEEN 30 AND 35;

-- 12. NOT BETWEEN
SELECT * FROM players WHERE age NOT BETWEEN 30 AND 35;

-- 13. LIKE (starts with)
SELECT * FROM players WHERE name LIKE 'V%'; -- Starts with V

-- 14. LIKE (ends with)
SELECT * FROM players WHERE name LIKE '%an'; -- Ends with 'an'

-- 15. LIKE (contains)
SELECT * FROM players WHERE name LIKE '%sh%'; -- Contains 'sh'

-- 16. IS NULL
SELECT * FROM players WHERE wickets IS NULL; -- Check for NULLs (none here)

-- 17. IS NOT NULL
SELECT * FROM players WHERE rating IS NOT NULL; -- All players with a rating

-- 18. NOT operator
SELECT * FROM players WHERE NOT country = 'India'; -- Same as !=

-- 19. ORDER BY + WHERE
SELECT * FROM players WHERE role = 'Bowler' ORDER BY wickets DESC; -- Bowlers sorted by wickets

-- 20. TOP with WHERE
SELECT TOP 3 * FROM players WHERE role = 'Batsman' ORDER BY runs DESC; -- Top 3 batsmen by runs
