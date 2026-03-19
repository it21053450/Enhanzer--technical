# Enhanzer API - Quick Start Guide

## ✅ Project Successfully Created!

Your .NET Core 7.0 Web API project has been created with all the required components.

## 📁 What Was Created

### Project Root: `EnhanzerAPI/`

```
EnhanzerAPI/
├── Models/
│   ├── Location.cs              # ✓ Location data model
├── Data/
│   └── AppDbContext.cs          # ✓ Entity Framework DbContext with Location_Details table config
├── Controllers/
│   └── AuthController.cs        # ✓ API endpoints implementation
├── Program.cs                   # ✓ Application startup & DI configuration
├── appsettings.json             # ✓ Database connection string
├── appsettings.Development.json # ✓ Development settings
├── EnhanzerAPI.csproj           # ✓ .NET 7.0 project file
├── .gitignore                   # ✓ Git configuration
├── README.md                    # ✓ Comprehensive documentation
├── setup.bat & setup.sh         # ✓ Automated setup scripts
├── run.bat & run.sh             # ✓ Quick start scripts
└── QUICKSTART.md                # This file
```

## 🚀 Quick Start (3 Steps)

### Step 1: Run Setup (Windows)
```bash
.\setup.bat
```

Or on Mac/Linux:
```bash
chmod +x setup.sh
./setup.sh
```

**What this does:**
- ✓ Restores NuGet packages
- ✓ Builds the project
- ✓ Creates database migration
- ✓ Applies migrations (creates EnhanzerDB and Location_Details table)

### Step 2: Start the Application

Windows:
```bash
.\run.bat
```

Or on Mac/Linux:
```bash
chmod +x run.sh
./run.sh
```

Or manually:
```bash
dotnet run
```

### Step 3: Test the API

1. Open browser and go to: `https://localhost:5001/swagger`
2. Use Swagger UI to test endpoints:
   - **POST** `/api/auth/login` - Authenticate and sync locations
   - **GET** `/api/auth/locations` - Retrieve saved locations

## 📋 Implementation Summary

### ✅ Database
- [x] SQL Server integration
- [x] Entity Framework Core 7.0.0
- [x] Database: `EnhanzerDB`
- [x] Table: `Location_Details` with Id, Location_Code, Location_Name

### ✅ API Endpoints

#### POST /api/auth/login
```json
Request:
{
  "email": "user@company.com",
  "password": "password123"
}

Response (Success):
{
  "message": "Login successful",
  "email": "user@company.com"
}

Response (Failure):
"Login Failed"
```

**Features:**
- ✓ Calls external API: `https://ez-staging-api.azurewebsites.net/api/External_Api/POS_Api/Invoke`
- ✓ Sends correct request format with API_Action, Device_Id, Company_Code
- ✓ Extracts User_Locations from response
- ✓ Clears existing locations before inserting
- ✓ Saves locations to Location_Details table

#### GET /api/auth/locations
```json
Response (Success):
[
  {
    "id": 1,
    "location_Code": "LOC001",
    "location_Name": "Main Office"
  },
  {
    "id": 2,
    "location_Code": "LOC002",
    "location_Name": "Branch Office"
  }
]

Response (Failure):
"Error retrieving locations: {error message}"
```

### ✅ Configuration

#### CORS
- ✓ Enabled for all origins (suitable for development)
- ✓ Allows all HTTP methods
- ✓ Allows all headers

#### Dependency Injection
- ✓ DbContext registered with SQL Server
- ✓ HttpClientFactory for API calls
- ✓ CORS policy configured

#### Code Quality
- ✓ Async/await throughout
- ✓ Proper error handling with try-catch
- ✓ Clean separation of concerns
- ✓ HttpClient for external API integration

## 🔧 Configuration Details

### Connection String (appsettings.json)
```json
"ConnectionStrings": {
  "DefaultConnection": "Server=.;Database=EnhanzerDB;Trusted_Connection=true;TrustServerCertificate=true;"
}
```

**Notes:**
- Uses local SQL Server instance (`.` = local)
- Uses Windows Authentication
- Database auto-creates on first migration

### External API
- Base URL: `https://ez-staging-api.azurewebsites.net/api/External_Api/POS_Api/Invoke`
- Request Format: JSON with API_Action, Device_Id, Company_Code, API_Body

## 📦 Dependencies

- **Framework:** .NET 7.0
- **ORM:** Entity Framework Core 7.0.0
- **Database:** SQL Server
- **Database Tools:** EF Core Tools 7.0.0
- **API Docs:** Swashbuckle/Swagger 6.5.0

## ⚙️ Manual Setup (If Setup Script Fails)

```bash
# 1. Restore packages
dotnet restore

# 2. Build project
dotnet build

# 3. Add Entity Framework Tools (if needed)
dotnet tool install --global dotnet-ef

# 4. Create migration
dotnet ef migrations add InitialCreate

# 5. Apply migration
dotnet ef database update

# 6. Run application
dotnet run
```

## 🔍 Verify Installation

After running setup, verify that:
- ✓ Project builds without errors: `dotnet build`
- ✓ Database exists: Check SQL Server for `EnhanzerDB`
- ✓ Table created: Query `SELECT * FROM Location_Details`
- ✓ API runs: `dotnet run` and visit `https://localhost:5001/swagger`

## 🐛 Troubleshooting

**"Could not connect to database"**
- Ensure SQL Server is running
- Check connection string in appsettings.json
- Verify Windows Authentication is enabled

**"External API call fails"**
- Check internet connection
- Verify API endpoint is accessible
- Check firewall/proxy settings

**"Migration fails"**
- Delete the `Migrations` folder if it exists
- Run: `dotnet ef migrations add InitialCreate`
- Then: `dotnet ef database update`

**"Build errors"**
- Run: `dotnet clean`
- Delete `bin/` and `obj/` folders
- Run: `dotnet build`

## 📖 Documentation Files

- **README.md** - Complete API documentation and setup guide
- **QUICKSTART.md** - This file, quick reference

## 🎯 Next Steps

1. Run setup script: `.\setup.bat`
2. Start application: `.\run.bat`
3. Open Swagger: `https://localhost:5001/swagger`
4. Test endpoints with sample credentials

## ✨ Key Features Implemented

- [x] SQL Server Database with Entity Framework Core
- [x] POST /api/auth/login with external API integration
- [x] GET /api/auth/locations endpoint
- [x] Proper DbContext configuration
- [x] CORS enabled for all origins
- [x] Async/await pattern throughout
- [x] Dependency injection setup
- [x] Error handling
- [x] Swagger/OpenAPI documentation
- [x] Clean code structure (Models, Data, Controllers)

## 📞 Support

For more detailed information, see:
- `README.md` - Full documentation
- `Program.cs` - Startup configuration
- `Controllers/AuthController.cs` - Endpoint implementation
- `Data/AppDbContext.cs` - Database configuration

---

**Status:** ✅ Ready to use!
**Build Status:** ✅ Compiles without errors
**Setup:** Quick setup scripts provided
