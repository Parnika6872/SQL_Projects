CREATE DATABASE IF NOT EXISTS SalesDataWalmart;
CREATE TABLE IF NOT EXISTS Sales(
invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
branch VARCHAR(5)NOT NULL,
City VARCHAR(30) NOT NULL,
Customer_Type VARCHAR(30) NOT NULL,
Gender VARCHAR(10) NOT NULL,
Product_line VARCHAR(100) NOT NULL,
unit_price DECIMAL(10,2) NOT NULL,
quantity INT NOT NULL,
VAT FLOAT(6,4) NOT NULL,
total DECIMAL(12,4) NOT NULL,
date DATETIME NOT NULL,
time TIME NOT NULL,
payment_method VARCHAR(15) NOT NULL,
cogs DECIMAL(10,2) NOT NULL,
gross_margin_pct FLOAT(11,9),
gross_income DECIMAL(12,4) NOT NULL,
rating FLOAT(2,1)
);




SELECT
time,
(CASE
WHEN 'time' BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
WHEN 'time' BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
ELSE "Evening"
END
) AS time_of_day
FROM Sales;

ALTER TABLE Sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE Sales
SET time_of_day = (
CASE 
WHEN 'time' BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
WHEN 'time' BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
ELSE "Evening"
END


);
-- day time

SELECT 
date,
DAYNAME(date)
FROM sales;

alter table Sales ADD COLUMN day_name VARCHAR(10);

SET SQL_SAFE_UPDATES = 0;

UPDATE Sales
SET day_name = DAYNAME(date);


-- month name

SELECT 
date,
MONTHNAME(date)
FROM Sales;



ALTER TABLE Sales ADD COLUMN months_name VARCHAR(10);

UPDATE Sales
SET months_name = MONTHNAME(date);

-- -------------------------
-- 1.how many unique cities does the data have

SELECT
DISTINCT city 
FROM sales;

-- 2. how. many branches in each city

SELECT
DISTINCT branch 
FROM sales;


SELECT
DISTINCT city,
branch
FROM sales;

-- Product details
-- 1.how many unique products

SELECT
DISTINCT product_line
FROM sales;

-- most common payment method

SELECT
payment_method,
COUNT(payment_method) AS cnt
FROM Sales
GROUP BY payment_method
ORDER BY cnt DESC;

-- what product line has the largest VAT
SELECT
product_line,
AVG(VAT) AS avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax;


-- which branch sold more products than average product sold

SELECT
branch,
SUM(quantity) AS gty
FROM Sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

