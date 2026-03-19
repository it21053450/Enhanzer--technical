# ✅ Database In Use - Quick Fix

## 🔴 The Problem

```
Cannot drop database "EnhanzerDB" because it is currently in use.
```

This means SQL Server is holding a connection to the database.

---

## ✅ The Solution

Use **DATABASE_SETUP_MASTER.sql** instead. This script:
1. Switches to **Master** database first (disconnects from EnhanzerDB)
2. Then drops and recreates EnhanzerDB

---

## 🚀 Quick Fix (Copy & Paste)

Open SQL Server Management Studio and paste:

```sql
-- Step 1: Switch to Master (disconnects from EnhanzerDB)
USE master;
GO

-- Step 2: Drop the database
DROP DATABASE IF EXISTS EnhanzerDB;
GO

-- Step 3: Create new database
CREATE DATABASE EnhanzerDB;
GO

-- Step 4: Use the database
USE EnhanzerDB;
GO

-- Step 5: Create table
CREATE TABLE Location_Details (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Location_Code NVARCHAR(100) NOT NULL,
    Location_Name NVARCHAR(100) NOT NULL
);
GO

-- Step 6: Create indexes
CREATE INDEX IX_LocationCode ON Location_Details (Location_Code);
GO
CREATE INDEX IX_LocationName ON Location_Details (Location_Name);
GO
```

Press **F5** to execute.

---

## 🎯 What Changed

| Old | New |
|-----|-----|
| `CREATE DATABASE EnhanzerDB;` | `USE master;` **first** then `DROP DATABASE` |
| Doesn't work if DB in use | Works even if DB is in use |

**Key**: `USE master;` switches context so you can drop the database.

---

## ✅ Success Result

You should see:
```
Database EnhanzerDB created successfully!
(0 rows affected)
```

---

## 📁 Use This File

**DATABASE_SETUP_MASTER.sql** - Ready to run in SSMS

---

## 🆘 Still Getting Error?

If you **still** get "in use" error:

1. First, close the **backend application** (stop `dotnet run` if running)
2. Close any **database explorer tabs** in SSMS
3. Click **New Query** in SSMS (not in connection to EnhanzerDB)
4. Paste the code above
5. Run

---

## 🔄 Workflow

1. Run the SQL script above ✅
2. Start backend: `dotnet run`
3. Start frontend: `npm start`
4. Login to app

---

Done! 🎉
