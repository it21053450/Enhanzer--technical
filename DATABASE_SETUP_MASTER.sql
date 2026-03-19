-- ========================================
-- Database Already In Use - Solution
-- ========================================
-- Run this INSTEAD of the previous script
-- It switches to Master database first, then drops/recreates EnhanzerDB

-- Step 1: Switch to Master database (disconnects from EnhanzerDB)
USE master;
GO

-- Step 2: Drop the existing database
DROP DATABASE IF EXISTS EnhanzerDB;
GO

-- Step 3: Create new database
CREATE DATABASE EnhanzerDB;
GO

-- Step 4: Use the new database
USE EnhanzerDB;
GO

-- Step 5: Create Location_Details Table
CREATE TABLE Location_Details (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Location_Code NVARCHAR(100) NOT NULL,
    Location_Name NVARCHAR(100) NOT NULL
);
GO

-- Step 6: Create Indexes
CREATE INDEX IX_LocationCode ON Location_Details (Location_Code);
GO
CREATE INDEX IX_LocationName ON Location_Details (Location_Name);
GO

-- Step 7: Verify Success
SELECT 'Database EnhanzerDB created successfully!' AS Status;
GO

SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Location_Details'
ORDER BY ORDINAL_POSITION;
GO

SELECT * FROM Location_Details;
GO
