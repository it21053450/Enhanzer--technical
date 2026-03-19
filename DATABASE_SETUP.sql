-- ========================================
-- EnhanzerDB - SQL Server Setup Script
-- ========================================
-- Run this script in SQL Server Management Studio (SSMS)
-- to create the database and tables needed for the application
-- ========================================

-- Step 1: Create Database
-- ========================================
CREATE DATABASE EnhanzerDB;
GO

-- Step 2: Use the newly created database
-- ========================================
USE EnhanzerDB;
GO

-- Step 3: Create Location_Details Table
-- ========================================
CREATE TABLE Location_Details (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Location_Code NVARCHAR(MAX) NOT NULL,
    Location_Name NVARCHAR(MAX) NOT NULL
);
GO

-- Step 4: Create Index for faster queries
-- ========================================
CREATE INDEX IX_LocationCode ON Location_Details (Location_Code);
GO
CREATE INDEX IX_LocationName ON Location_Details (Location_Name);
GO

-- Step 5: Verify the table was created
-- ========================================
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Location_Details'
ORDER BY ORDINAL_POSITION;
GO

-- Step 6: Sample data (optional - remove if not needed)
-- ========================================
-- Uncomment the lines below to insert sample data
/*
INSERT INTO Location_Details (Location_Code, Location_Name) VALUES
    ('LOC001', 'Main Office'),
    ('LOC002', 'Branch Office'),
    ('LOC003', 'Warehouse'),
    ('LOC004', 'Distribution Center'),
    ('LOC005', 'Regional Store');
GO
*/

-- ========================================
-- DONE! Database is ready
-- ========================================
-- The Location_Details table is now created and ready to use.
-- The application will automatically populate this table when users login.
--
-- To verify data after login:
-- SELECT * FROM Location_Details;
-- GO
