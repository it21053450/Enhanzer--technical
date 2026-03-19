# 🚀 Complete Project Setup - LocalDB

## ✅ Settings Updated

Your project is now configured with:
- **Server**: (localdb)\mssqllocaldb
- **Database**: EnhanzerDB

---

## 📋 Step-by-Step Setup

### Step 1: Create Database in SQL Server

**Open SQL Server Management Studio**

Connection details:
- **Server name**: (localdb)\mssqllocaldb
- **Authentication**: Windows Authentication
- Click **Connect**

**Run this SQL script**:

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

Or use file: `DATABASE_LOCALDB.sql`

---

### Step 2: Start Backend

**Open PowerShell / Command Prompt**

```powershell
cd c:\Users\odith\OneDrive\Desktop\Assignment\EnhanzerAPI
dotnet run
```

**Expected output**:
```
info: Microsoft.Hosting.Lifetime[14]
      Now listening on: https://localhost:5001
```

✅ **Backend is running when you see above message**

---

### Step 3: Start Frontend

**Open Another PowerShell / Command Prompt**

```powershell
cd c:\Users\odith\OneDrive\Desktop\Assignment\EnhanzerFrontend
npm install
npm start
```

**Expected output**:
```
✔ Compiled successfully
○ Compiled successfully with 0 warnings
```

✅ **Frontend is running when compilation is successful**

---

### Step 4: Open in Browser

```
http://localhost:4200
```

You should see the **Login Page**.

---

## 🔐 Test Login

1. **Email**: test@company.com
2. **Password**: password123
3. **Click**: Login button

---

## 📝 Test Purchase Bill

1. After login, you'll see the **Purchase Bill** page
2. Select an **Item** from dropdown
3. Select a **Batch** (from Location_Details)
4. Enter values:
   - **Standard Cost**: 100
   - **Standard Price**: 150
   - **Quantity**: 5
   - **Discount**: 20
5. **Click**: Add Item

**Expected Results**:
- Total Cost: 400
- Total Selling: 750

---

## ✅ Configuration Summary

| Item | Value |
|------|-------|
| **Server** | (localdb)\mssqllocaldb |
| **Database** | EnhanzerDB |
| **Backend Port** | 5001 |
| **Frontend Port** | 4200 |
| **Frontend URL** | http://localhost:4200 |
| **Backend URL** | https://localhost:5001 |

---

## 📁 Files Changed

✅ **appsettings.json** - Connection string updated to use LocalDB

---

## 🎯 Your Application is Ready!

Everything is configured. Just:

1. ✅ Run SQL script in SSMS
2. ✅ Start backend (`dotnet run`)
3. ✅ Start frontend (`npm start`)
4. ✅ Open browser to http://localhost:4200

---

## 🆘 Troubleshooting

| Issue | Solution |
|-------|----------|
| Backend won't start | Check if port 5001 is free |
| Frontend won't start | Run `npm install` first |
| Database error | Run the SQL script in SSMS |
| Login fails | Check network/API |
| Can't connect to DB | Verify (localdb)\mssqllocaldb is running |

---

## 📊 Full Project Structure

```
c:/Users/odith/OneDrive/Desktop/Assignment/
├── EnhanzerAPI/                (Backend)
│   ├── Program.cs              (Startup config)
│   ├── appsettings.json        ✅ UPDATED
│   ├── Controllers/
│   │   └── AuthController.cs
│   ├── Services/
│   │   ├── AuthService.cs
│   │   └── JwtTokenService.cs
│   ├── Data/
│   │   └── AppDbContext.cs
│   └── Models/
│       └── Location.cs
│
├── EnhanzerFrontend/           (Frontend)
│   ├── src/
│   │   ├── index.html
│   │   ├── main.ts
│   │   ├── styles.css
│   │   └── app/
│   │       ├── components/
│   │       │   ├── login/
│   │       │   └── purchase-bill/
│   │       ├── services/
│   │       ├── guards/
│   │       └── models/
│   └── package.json
│
└── DATABASE_LOCALDB.sql        ✅ USE THIS
```

---

## 🔄 Complete Startup Sequence

```
Terminal 1: cd EnhanzerAPI → dotnet run
         ↓
         (wait for "listening on https://localhost:5001")
         ↓
Terminal 2: cd EnhanzerFrontend → npm install → npm start
         ↓
         (wait for "Compiled successfully")
         ↓
Browser: http://localhost:4200
         ↓
See Login Page
```

---

## 🎉 YOU'RE READY!

All configurations are done. Follow the steps above to run your complete application!
