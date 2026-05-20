-- ================================================
-- EARTHFIRE PIZZA SALES ANALYSIS - SQL QUERIES
-- Tool: MySQL
-- Author: dammy8369
-- ================================================


-- ------------------------------------------------
-- A. KEY PERFORMANCE INDICATORS (KPIs)
-- ------------------------------------------------

-- 1. Total Revenue
SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales;


-- 2. Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_Order_Value 
FROM pizza_sales;


-- 3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizza_Sold 
FROM pizza_sales;


-- 4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales;


-- 5. Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order
FROM pizza_sales;


-- ------------------------------------------------
-- B. DAILY TREND FOR TOTAL ORDERS
-- ------------------------------------------------
SELECT DATENAME(DW, order_date) AS Order_Day, 
COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);


-- ------------------------------------------------
-- C. HOURLY TREND FOR TOTAL ORDERS
-- ------------------------------------------------
SELECT DATEPART(HOUR, order_time) AS Order_Hours, 
COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time);


-- ------------------------------------------------
-- D. % OF SALES BY PIZZA CATEGORY
-- ------------------------------------------------
SELECT pizza_category, 
CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;


-- ------------------------------------------------
-- E. % OF SALES BY PIZZA SIZE
-- ------------------------------------------------
SELECT pizza_size, 
CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;


-- ------------------------------------------------
-- F. TOTAL PIZZAS SOLD BY PIZZA CATEGORY
-- ------------------------------------------------
SELECT pizza_category, 
SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


-- ------------------------------------------------
-- G. TOP 5 BEST SELLERS BY TOTAL PIZZAS SOLD
-- ------------------------------------------------
SELECT TOP 5 pizza_name, 
SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC;


-- ------------------------------------------------
-- H. BOTTOM 5 WORST SELLERS BY TOTAL PIZZAS SOLD
-- ------------------------------------------------
SELECT TOP 5 pizza_name, 
SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC;


-- ================================================
-- FILTER EXAMPLES (Month, Quarter, Week)
-- ================================================

-- Filter by Month (e.g., January = 1, April = 4)
SELECT DATENAME(DW, order_date) AS Order_Day, 
COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY DATENAME(DW, order_date);

-- Filter by Quarter (e.g., Q1 = 1, Q3 = 3)
SELECT DATENAME(DW, order_date) AS Order_Day, 
COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY DATENAME(DW, order_date);
