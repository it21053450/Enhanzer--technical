-- ========================================
-- EnhanzerDB Setup - Clean & Simple
-- ========================================
-- Database is deleted, this will create it fresh with NO ERRORS
-- ========================================

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

-- Verify
SELECT 'SUCCESS! Database and table created.' AS Status;
GO

SELECT COUNT(*) AS TotalRows FROM Location_Details;
GO
