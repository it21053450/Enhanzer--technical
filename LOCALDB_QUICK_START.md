# ⚡ QUICK START - LocalDB Setup

## 📋 Configuration Details

```
Server: (localdb)\mssqllocaldb
Database: EnhanzerDB
```

✅ **appsettings.json already updated!**

---

## 🔧 Step 1: Create Database (SSMS)

Copy & Paste in SQL Server Management Studio:

```sql
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
```

Press **F5** to execute.

---

## 🚀 Step 2: Start Backend

**Terminal 1**:
```powershell
cd c:\Users\odith\OneDrive\Desktop\Assignment\EnhanzerAPI
dotnet run
```

Wait for:
```
Now listening on: https://localhost:5001
```

---

## 🎨 Step 3: Start Frontend

**Terminal 2**:
```powershell
cd c:\Users\odith\OneDrive\Desktop\Assignment\EnhanzerFrontend
npm install
npm start
```

Wait for:
```
✔ Compiled successfully
```

---

## 🌐 Step 4: Open Browser

```
http://localhost:4200
```

You'll see the **Login Page**.

---

## 🔐 Step 5: Login & Test

**Email**: test@company.com
**Password**: password123

After login, you'll see the **Purchase Bill** page.

---

## ✅ That's It!

Your complete application is now running with:
- ✅ LocalDB connection
- ✅ EnhanzerDB database
- ✅ Backend on https://localhost:5001
- ✅ Frontend on http://localhost:4200

**Done!** 🎉
