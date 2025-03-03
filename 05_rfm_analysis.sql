WITH rfm AS(
	SELECT
		`Customer ID`,
        `Customer Name`,
        DATEDIFF(CURDATE(), MAX(`Order Date`)) AS `Recency`,
        COUNT(DISTINCT `Order ID`) AS `Frequency`,
		SUM(`Sales`) AS `Monetary`
	FROM superstore_sales_data
    GROUP BY `Customer ID`, `Customer Name`
),
rfm_scores AS (
	SELECT
		`Customer ID`,
        `Customer Name`,
        `Recency`,
        `Frequency`,
        `Monetary`,
        NTILE(5) OVER (ORDER BY `Recency` DESC) AS `Recency Score`,
        NTILE(5) OVER (ORDER BY `Frequency` ASC) AS `Frequency Score`,
        NTILE(5) OVER (ORDER BY `Monetary` ASC) AS `Monetary Score`
	FROM rfm
)
SELECT 
	*, (`Recency Score` + `Frequency Score` + `Monetary Score`) AS `RFM Total Score`,
	CASE
		WHEN `Recency Score` = 5 AND `Frequency Score` = 5 AND `Monetary Score` = 5 THEN "Best Customers"
        WHEN `Recency Score` >= 4 AND `Frequency Score` >= 4  THEN "Loyal Customers"
        WHEN `Recency Score` >= 4 AND `Monetary Score` >= 4  THEN "Big Spenders"
        WHEN `Recency Score` >= 3 AND `Frequency Score` >= 3  THEN "Potential Loyalists"
        WHEN `Recency Score` <= 2 AND `Frequency Score` <= 2  THEN "At Risk Customers"
        WHEN `Recency Score` = 1 AND `Frequency Score` = 1 AND `Monetary Score` = 1 THEN "Lost Customers"
        ELSE "Other"
	END AS `Customer Segment`
FROM rfm_scores
ORDER BY `Customer Segment`, `Monetary` DESC;