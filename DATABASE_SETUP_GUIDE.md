# 🗄️ SQL Server Database Setup Guide

## 📋 Overview

This guide shows you how to set up the **EnhanzerDB** database in SQL Server Manager using the provided SQL script.

---

## 📂 Files You Have

- **DATABASE_SETUP.sql** - Complete SQL script to create database and tables
- This file is located at: `c:\Users\odith\OneDrive\Desktop\Assignment\DATABASE_SETUP.sql`

---

## ⚙️ Prerequisites

1. **SQL Server** installed and running
2. **SQL Server Management Studio (SSMS)** installed
3. SQL Server authentication enabled (or Windows Authentication)

---

## 🚀 Step-by-Step Setup

### Step 1: Open SQL Server Management Studio
```
Click Start Menu → Search "SQL Server Management Studio" → Click it
```

### Step 2: Connect to Your SQL Server
```
Server name: . (dot) or (local) or your-server-name
Authentication: Windows Authentication (or SQL Server Authentication)
Click "Connect"
```

### Step 3: Open the SQL Script
```
File → Open → File
Navigate to: c:\Users\odith\OneDrive\Desktop\Assignment\DATABASE_SETUP.sql
Click Open
```

### Step 4: Execute the Script
```
Click "Execute" button (or press CTRL + E / F5)
```

Expected output:
```
Command(s) completed successfully.
```

---

## 📊 What Was Created

The script creates:

```
Database: EnhanzerDB
│
└── Table: Location_Details
    ├── Column: Id (INT, Primary Key, Auto-increment)
    ├── Column: Location_Code (NVARCHAR(MAX), Required)
    └── Column: Location_Name (NVARCHAR(MAX), Required)
```

---

## ✅ Verify Setup Success

Run this query to confirm the table exists:

```sql
SELECT * FROM EnhanzerDB.Location_Details;
```

Expected result:
```
(0 rows affected)
```
This is normal - the table is empty until users login.

---

## 🔍 View Table Structure

To see the table structure, run:

```sql
USE EnhanzerDB;
GO

SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Location_Details'
ORDER BY ORDINAL_POSITION;
```

Expected output:
```
TABLE_NAME        | COLUMN_NAME    | DATA_TYPE    | IS_NULLABLE
Location_Details  | Id             | int          | NO
Location_Details  | Location_Code  | nvarchar(max)| NO
Location_Details  | Location_Name  | nvarchar(max)| NO
```

---

## 📝 Connection String Reference

Your application uses this connection string (from appsettings.json):

```
Server=.;
Database=EnhanzerDB;
Trusted_Connection=true;
TrustServerCertificate=true;
```

**This means:**
- Server: Local machine (`.`)
- Database: EnhanzerDB (the one you just created)
- Authentication: Windows Authentication

---

## 🧪 Test Data (Optional)

To add sample locations, run:

```sql
USE EnhanzerDB;
GO

INSERT INTO Location_Details (Location_Code, Location_Name) VALUES
    ('LOC001', 'Main Office'),
    ('LOC002', 'Branch Office'),
    ('LOC003', 'Warehouse');
GO

SELECT * FROM Location_Details;
```

---

## ⚠️ Troubleshooting

### Error: "Database already exists"

**Solution 1: Start Fresh (Delete old database)**

Use the **DATABASE_SETUP_FIXED.sql** file - it includes:
```sql
DROP DATABASE IF EXISTS EnhanzerDB;
GO
```

This safely removes the old database and creates a new one.

**Solution 2: Keep Existing Database**

Just verify it exists by running:
```sql
USE EnhanzerDB;
GO
SELECT * FROM Location_Details;
GO
```

**I Provided**: `DATABASE_SETUP_FIXED.sql` has both options.

### Error: "Cannot open file"
Make sure the path is correct:
```
c:\Users\odith\OneDrive\Desktop\Assignment\DATABASE_SETUP.sql
```

### Error: "Login failed"
- Check if SQL Server is running
- Verify your authentication method (Windows or SQL Server Auth)
- Ensure you have admin rights

### Error: "Syntax Errors"
- Make sure you copied the entire script
- Try executing just the CREATE DATABASE part first:

```sql
CREATE DATABASE EnhanzerDB;
GO
```

---

## 📌 Next Steps

1. ✅ Run the DATABASE_SETUP.sql script (what you just did)
2. Start the backend: `cd c:\Users\odith\OneDrive\Desktop\Assignment\EnhanzerAPI` → `dotnet run`
3. Start the frontend: `cd c:\Users\odith\OneDrive\Desktop\Assignment\EnhanzerFrontend` → `npm start`
4. Login to the application
5. The application will automatically populate the Location_Details table

---

## 🔄 Auto-Population When User Logs In

When a user logs in:
1. Backend calls external API
2. API returns list of locations
3. Backend **clears** Location_Details table
4. Backend **inserts** new locations from API
5. Frontend dropdown shows updated locations

---

## 📚 Related Files

- Connection string: `appsettings.json` in EnhanzerAPI folder
- Database context: `EnhanzerAPI/Data/AppDbContext.cs`
- Location model: `EnhanzerAPI/Models/Location.cs`
- Backend service: `EnhanzerAPI/Services/AuthService.cs`

---

## 🎯 You're Done!

Your database is now ready. The backend will connect to it automatically when you run `dotnet run`.

No additional setup needed! 🚀

---

## 💡 Quick Reference

| Task | Command |
|------|---------|
| **Create DB** | Run DATABASE_SETUP.sql |
| **View data** | `SELECT * FROM EnhanzerDB.Location_Details;` |
| **Clear data** | `DELETE FROM EnhanzerDB.Location_Details;` |
| **Drop DB** | `DROP DATABASE EnhanzerDB;` |
| **Backup** | Right-click DB → Tasks → Backup |

---

## 📞 Need Help?

Check these files in order:
1. QUICK_REFERENCE.md - Quick commands
2. STARTUP_GUIDE.md - Full setup guide
3. ARCHITECTURE.md - System design
4. This file - Database setup details
