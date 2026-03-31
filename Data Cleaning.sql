-- ========================================
-- DATA CLEANING & UPDATING THE SOURCE TABLE
-- ========================================

-- Checked the Data Type of all the columns
DESCRIBE superstore;

-- Check for Null Values in each column
SELECT *         
FROM superstore
WHERE CustomerID IS NULL;

-- ===================================================================================
-- Check for Duplicate Values in RowID column since its the PRIMARY KEY
SELECT RowID, count(*)      
FROM superstore
GROUP BY 1
HAVING 	count(*) >1;
-- Found 2 Distinct CustomerID sharing same RowID but everything else is unique for them
SELECT *
FROM superstore
WHERE RowID = 4918;  
-- First, find the max RowID in the table to assign a safe new one:
SELECT MAX(RowID) FROM superstore; -- 9994
-- Then update one of the duplicate records with a new RowID:
UPDATE superstore
SET RowID = 9995
WHERE RowID = 4918 AND CustomerID = 'MB-17305'
LIMIT 1;
-- Verify the fix:
SELECT * FROM superstore WHERE RowID = 4918;
SELECT * FROM superstore WHERE RowID = (SELECT MAX(RowID) FROM superstore);
-- ============================================================================================

-- Check Null Values in Returns Column
SELECT Returns, COUNT(*)
FROM superstore
WHERE Returns = 0
GROUP BY Returns;

-- Update the Returns Column with 0 where NULL
UPDATE superstore
SET Returns = 0
WHERE Returns IS NULL;

-- Dropped unwanted column (ind1)for analysis
ALTER TABLE superstore
DROP COLUMN ind1;
-- Dropped unwanted column (ind2)for analysis
ALTER TABLE superstore
DROP COLUMN ind2;
