# 🔧 SQL Code for SQL Server Manager

## 📋 Copy & Paste SQL Code

### **COPY ALL CODE BELOW AND RUN IN SSMS**

```sql
-- Drop old database if it exists (safe to run multiple times)
DROP DATABASE IF EXISTS EnhanzerDB;
GO

-- Create Database
CREATE DATABASE EnhanzerDB;
GO

-- Use the database
USE EnhanzerDB;
GO

-- Create Location_Details Table
CREATE TABLE Location_Details (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Location_Code NVARCHAR(100) NOT NULL,
    Location_Name NVARCHAR(100) NOT NULL
);
GO

-- Create Indexes (optional, improves performance)
CREATE INDEX IX_LocationCode ON Location_Details (Location_Code);
GO
CREATE INDEX IX_LocationName ON Location_Details (Location_Name);
GO

-- Verify success
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Location_Details'
ORDER BY ORDINAL_POSITION;
GO
```

---

## 📌 What This Does

| Code | Purpose |
|------|---------|
| `CREATE DATABASE EnhanzerDB;` | Creates the database |
| `CREATE TABLE Location_Details` | Creates the table for locations |
| `Id INT IDENTITY(1,1) PRIMARY KEY` | Auto-incrementing ID column |
| `Location_Code NVARCHAR(MAX) NOT NULL` | Location code (required) |
| `Location_Name NVARCHAR(MAX) NOT NULL` | Location name (required) |
| Indexes | Speed up search queries |

---

## ⚡ Quick Steps

1. **Open SQL Server Management Studio**
2. **Connect to SQL Server** (Server: `.` or `local`)
3. **New Query** (Ctrl + N)
4. **Paste the code above**
5. **Execute** (F5 or Click Execute button)
6. **Done!** ✅

---

## ✅ Success Indicator

You should see:
```
3 rows affected
```
or
```
Command(s) completed successfully.
```

---

## 🔍 Verify Data (Optional)

After creating, check the table:

```sql
USE EnhanzerDB;
SELECT * FROM Location_Details;
```

Should return empty result (0 rows) - this is correct.

---

## 📝 Connection String (Reference Only)

Your app uses:
```
Server=.
Database=EnhanzerDB
Trusted_Connection=true
TrustServerCertificate=true
```

---

## 🚀 Next

1. Save this SQL
2. Run in SSMS
3. Start backend: `dotnet run`
4. Start frontend: `npm start`
5. Login (locations auto-populate)

---

## 📞 Issues?

See **DATABASE_SETUP_GUIDE.md** for troubleshooting
