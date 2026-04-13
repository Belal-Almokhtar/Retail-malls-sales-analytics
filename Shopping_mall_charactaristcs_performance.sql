SELECT * 
FROM Shopping_Mall;
--1- Is there a relationship between mall size (area_sqm) & number of stores and total revenue?
--		To Help real estate developers justify expansion or new construction.
--		To Guide decisions on leasing additional retail units inside malls

SELECT 
	[area (sqm)],
	store_count,
	ROUND(SUM(quantity * price ),0) AS total_revenue
FROM Sales s
INNER JOIN Shopping_Mall h
ON s.shop_mall = h.shopping_mall
GROUP BY [area (sqm)],store_count
ORDER BY total_revenue DESC;

-- 2- Which California city location generates the highest retail revenue?
--		To Support regional managers in resource and budget allocation.
SELECT 
	location,
	ROUND(SUM(quantity * price ),0) AS total_revenue
FROM Sales s
INNER JOIN Shopping_Mall h
ON s.shop_mall = h.shopping_mall
GROUP BY location
ORDER BY total_revenue DESC;