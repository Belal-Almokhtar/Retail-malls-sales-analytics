-- What is the total spending per age group?
--   TO Identify which age segments are the most valuable customers.
WITH avg_spend_per_age_group AS (
SELECT *,
	CASE WHEN age >= 15 AND age < 30 THEN '15-30'
		 WHEN age >= 30 AND age < 45 THEN '30-45'
		 WHEN age >= 45 AND age < 60 THEN '45-60'
		 WHEN age >= 60 AND age < 75 THEN '60-75'
		 ELSE 'Unkown'
	END AS age_segments
FROM Customers
)
SELECT 
	age_segments,
	ROUND(SUM(quantity * price ),2) AS total_revenue
FROM Sales  S
INNER JOIN  avg_spend_per_age_group A
ON S.customer_id = A.customer_id
GROUP BY age_segments
ORDER BY total_revenue DESC;
-- ---------------------------------------------------
-- 2- How does spending differ between male and female customers?
--		To Enable gender-targeted marketing campaigns and product placement.
SELECT 
	gender,
	ROUND(SUM(quantity * price),2) AS total_revenue
FROM Sales s
INNER JOIN Customers c
ON s.customer_id = c.customer_id
GROUP BY gender;
-- Female represented the 60% of customers and male 40%.

-- 3- What is the most preferred payment method per gender and age group?
--		To Help finance teams optimize payment options and offer incentives.
CREATE VIEW age_segements  AS(
SELECT *,
	CASE WHEN age >= 15 AND age < 30 THEN '15-30'
		 WHEN age >= 30 AND age < 45 THEN '30-45'
		 WHEN age >= 45 AND age < 60 THEN '45-60'
		 WHEN age >= 60 AND age < 75 THEN '60-75'
		 ELSE 'Unkown'
	END AS age_segments
FROM Customers
);
WITH ranked_groups AS (
SELECT 
	gender,
	age_segments,
	payment_method,
	COUNT(payment_method) AS num_transactions,
	RANK() OVER (PARTITION BY age_segments,gender ORDER BY COUNT(payment_method)DESC) AS rank
FROM age_segements
GROUP BY gender,
	age_segments,
	payment_method
)
SELECT 
	* 
FROM ranked_groups
WHERE rank = 1;

-- 4- How do customer demographics impact spending across different malls?
--		To Understand whether the same demographic behaves differently by location.
SELECT 
	h.location,
	a.gender,
	a.age_segments,
	ROUND(SUM(quantity * price ),0) AS total_revenue,
	RANK() OVER(PARTITION BY location ORDER BY ROUND(SUM(quantity * price ),0) DESC) AS rank
FROM Sales s
INNER JOIN age_segements a
ON s.customer_id = a.customer_id
INNER JOIN Shopping_Mall h
ON s.shop_mall = h.shopping_mall
GROUP BY h.location,
		 a.gender,
		 a.age_segments
;	