-- ========================================
-- OPTION 1: START FRESH (Drop & Recreate)
-- ========================================
-- Use this if you want to completely remove and recreate the database
-- WARNING: This will delete ALL data in the database!

DROP DATABASE IF EXISTS EnhanzerDB;
GO

CREATE DATABASE EnhanzerDB;
GO

USE EnhanzerDB;
GO

CREATE TABLE Location_Details (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Location_Code NVARCHAR(100) NOT NULL,
    Location_Name NVARCHAR(100) NOT NULL
);
GO

CREATE INDEX IX_LocationCode ON Location_Details (Location_Code);
GO
CREATE INDEX IX_LocationName ON Location_Details (Location_Name);
GO

SELECT 'Database created successfully!' AS Status;
GO

-- ========================================
-- OPTION 2: SAFE (Only if doesn't exist)
-- ========================================
-- Use this if the database already exists and you just want to verify it

USE EnhanzerDB;
GO

-- View existing table structure
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Location_Details'
ORDER BY ORDINAL_POSITION;
GO

-- View existing data
SELECT * FROM Location_Details;
GO

SELECT 'EnhanzerDB setup is complete!' AS Status;
GO
