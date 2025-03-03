-- PERFORM EXPLORATORY DATA ANALYSIS

-- 1. Checking the structure of the table
DESC superstore_sales_data;

-- 2. Displaying first 10 rows (sample of the dataset)
SELECT * FROM superstore_sales_data LIMIT 10;

-- 3. Counting NULL values in each column
SELECT 
    SUM(CASE WHEN `Order Priority` IS NULL THEN 1 ELSE 0 END) AS missing_order_priority,
    SUM(CASE WHEN `Discount` IS NULL THEN 1 ELSE 0 END) AS missing_discount,
    SUM(CASE WHEN `Unit Price` IS NULL THEN 1 ELSE 0 END) AS missing_unit_price,
    SUM(CASE WHEN `Shipping Cost` IS NULL THEN 1 ELSE 0 END) AS missing_shipping_cost
FROM superstore_sales_data;

-- 4. Getting summary statistics for numerical fields
SELECT 
    MIN(`Discount`) AS `Minimum Discount`, 
    MAX(`Discount`) AS `Maximum Discount`, 
    AVG(`Discount`) AS `Average Discount`, 
    MIN(`Unit Price`) AS `Minimum Unit Price`,
    MAX(`Unit Price`) AS `Maximum Unit Price`, 
    AVG(`Unit Price`) AS `Average Unit Price`, 
    MIN(`Shipping Cost`) AS `Minimum Shipping Cost`,
    MAX(`Shipping Cost`) AS `Maximum Shipping Cost`,
    AVG(`Shipping Cost`) AS `Average Shipping Cost`, 
    MIN(`Profit`) AS `Minimum Profit`,
    MAX(`Profit`) AS `Maximum Profit`,
    AVG(`Profit`) AS `Average Profit`
FROM superstore_sales_data;

-- 5.Finding Top 5 Most Profitable Products
SELECT 
	`Product Name`, 
    SUM(`Profit`) AS `Total Profit`
FROM superstore_sales_data
GROUP BY `Product Name`
ORDER BY `Total Profit` DESC
LIMIT 5;

-- 6. Displaying Sales Performance by Region
SELECT
	`Region`,
    SUM(`Sales`) AS `Total Sales`
FROM superstore_sales_data
GROUP BY `Region`
ORDER BY `Total Sales` DESC;

-- 7. Displaying Monthly Sales Trend Over Time
SELECT
	DATE_FORMAT(`Order Date`, "%Y-%m") AS `Monthly Order`,
    SUM(`Sales`) AS `Total Sales`
FROM superstore_sales_data
GROUP BY `Monthly Order`
ORDER BY `Monthly Order`;

-- 8. Counting Occurrences of Each Ship Mode
SELECT
	`Ship Mode`,
    COUNT(*) AS `Count Orders`
FROM superstore_sales_data
GROUP BY `Ship Mode`
ORDER BY `Count Orders` desc;

-- 9. Counting The Number If Returned and Not Returned Orders
SELECT 
	`Return Status`, 
    COUNT(*) AS `Total Orders`,
    ROUND((COUNT(*) * 100 / (SELECT COUNT(*) FROM superstore_sales_data)), 2) AS Percentage
FROM superstore_sales_data
GROUP BY `Return Status`;

-- 10. Comparing Profitability Across Product Categories
SELECT 
	`Product Category`,
    SUM(`Profit`) AS `Total Profit`
FROM superstore_sales_data
GROUP BY `Product Category`
ORDER BY `Total Profit` DESC;

-- 11. Displaying Order Count & Sales Distribution by Customer Segment (Understanding which customer segments contribute the most to sales.)
SELECT 
	`Customer Segment`,
    COUNT(*) AS `Total Orders`,
    SUM(`Sales`) AS `Total Sales`,
    ROUND(AVG(`Sales`), 2) AS `Average Sales Per Order`
FROM superstore_sales_data
GROUP BY `Customer Segment`
ORDER BY `Total Orders` DESC;

-- 12. Displaying Top 5 Most Sold Products
SELECT 
	`Product Name`,
    SUM(`Quantity ordered new`) AS `Total Quantity Sold`
FROM superstore_sales_data
GROUP BY `Product Name`
ORDER BY `Total Quantity Sold` DESC
LIMIT 5;

-- 13. Displaying Highest & Lowest Profit-Making Products
-- Top 5 Profitable Products
SELECT
	`Product Name`,
    SUM(`Profit`) AS `Total Profit`
FROM superstore_sales_data
GROUP BY `Product Name`
ORDER BY `Total Profit` DESC
LIMIT 5;

-- Bottom 5 Least Profitable Products
SELECT
	`Product Name`,
    SUM(`Profit`) AS `Total Profit`
FROM superstore_sales_data
GROUP BY `Product Name`
ORDER BY `Total Profit` ASC
LIMIT 5;

-- 14. Displaying Sales & Profit by Shipping Mode (Evaluates which shipping mode is most profitable)
SELECT 
	`Ship Mode`,
	COUNT(*) AS `Total Orders`,
    SUM(`Sales`) AS `Total Sales`,
    SUM(`Profit`) AS `Total Profit`
FROM superstore_sales_data
GROUP BY `Ship Mode`
ORDER BY `Total Sales` DESC;

-- 15. Displaying Sales & Profit Trends Over Time [Yearly] (Identifies growth trends over the years)
SELECT
	YEAR(`Order Date`) AS `Year`,
    SUM(`Sales`) AS `Total Sales`,
    SUM(`Profit`) AS `Total Profit`
FROM superstore_sales_data
GROUP BY `Year`
ORDER BY `Year`;

-- 16. Displaying Top Performing States by Sales
SELECT 
	`State or Province`, 
    SUM(`Sales`) AS `Total Sales`,
    SUM(`Profit`) AS `Total Profit`
FROM superstore_sales_data
GROUP BY `State or Province`
ORDER BY `Total Sales` DESC
LIMIT 10;

-- 17. Analizing Discount Impact on Profit (Helps analyze whether high discounts lead to lower profits)
SELECT 
	ROUND(`Discount`, 2) AS `Discount Rate`,
    SUM(`Sales`) AS `Total Sales`,
    SUM(`Profit`) AS `Total Profit`
FROM superstore_sales_data
GROUP BY `Discount Rate`
ORDER BY `Discount Rate` DESC;

-- 18. identifying orders causing losses
SELECT * FROM superstore_sales_data
WHERE `Profit` < 0
ORDER BY `Profit` ASC
LIMIT 10;

-- 19. Showing which product categories contribute most to sales
SELECT 
	`Product Category`,
    SUM(`Sales`) AS `Total Sales`,
    ROUND(SUM(`Sales`)*100 / (SELECT SUM(`Sales`) FROM superstore_sales_data), 2) AS `Sales Percentage`
FROM superstore_sales_data
GROUP BY `Product Category`
ORDER BY `Total Sales` DESC;

-- 20. identifying products with the highest return rates
SELECT 
	`Product Name`,
    COUNT(*) AS `Return Count`
FROM superstore_sales_data
WHERE `Return Status` = "Returned"
GROUP BY `Product Name`
ORDER BY `Return Count` DESC
LIMIT 10;