-- Adding a New DATE Column
ALTER TABLE superstore_sales_data
ADD COLUMN New_Order_Date DATE,
ADD COLUMN New_Ship_Date DATE;

-- Converting the Text Values to Dates
UPDATE superstore_sales_data
SET New_Order_Date = DATE_ADD("1899-12-30", INTERVAL CAST(`Order Date` AS UNSIGNED) DAY),
	New_Ship_Date = DATE_ADD("1899-12-30", INTERVAL CAST(`Ship Date` AS UNSIGNED) DAY);

-- Dropping Old Columns 
ALTER TABLE superstore_sales_data DROP COLUMN `Order Date`, DROP COLUMN `Ship Date`;

-- Renaming New Columns
ALTER TABLE superstore_sales_data
CHANGE COLUMN New_Order_Date `Order Date` DATE,
CHANGE COLUMN New_Ship_Date `Ship Date` DATE;