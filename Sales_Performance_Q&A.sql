--1- What is the total revenue per shopping mall?
--		To Identify top and bottom performing malls to guide investment decisions.
SELECT 
	shop_mall,
	ROUND(SUM(quantity * price),0) AS total_revenue
FROM Sales
GROUP BY shop_mall
ORDER BY total_revenue DESC;
--2- Which 3 product categories generates the highest revenue and quantity sold & revenue contribution of each mall as a % of total California sales?
--		To Help retailers prioritize inventory and shelf space
--		To Understand market share per location for strategic planning.
WITH comulatitive_percent AS(
	SELECT 
		category,
		SUM(quantity) AS total_quantity,
		ROUND(SUM(quantity * price ),0) AS total_revenue
	FROM Sales
	GROUP BY category
)
  SELECT TOP 3
	*,
	ROUND((total_revenue / (SELECT ROUND(SUM(quantity * price),0)  FROM Sales)) * 100 ,2) AS percentag
FROM comulatitive_percent
ORDER BY total_revenue DESC;
-- category clothing is the highest revenue with percentage 45.33% 
-- the second is Shoes with percentage 26.46 and the third is Technology is 23.01 
-- this mean around 95% of revenue from these three categories.
-- ----------------------------------------------------------------

--3-  How does revenue change over time (monthly/seasonally)?
--		To Detect sales peaks to plan promotions,staffing and stock

SELECT 
	YEAR([invoice date]) AS year,
	MONTH([invoice date])AS month,
	ROUND(SUM(quantity * price ),0) AS total_revenue
FROM Sales
GROUP BY YEAR([invoice date]),
			MONTH([invoice date])
ORDER BY YEAR([invoice date]),MONTH([invoice date]);
-- -----------------------------------------------------------
-- 4- 