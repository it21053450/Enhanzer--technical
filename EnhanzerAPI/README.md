# Enhanzer API - .NET Core Web API

A .NET Core 7.0 Web API project with SQL Server integration and external API integration for user authentication and location management.

## Project Structure

```
EnhanzerAPI/
├── Models/
│   ├── Location.cs              # Location model for database
├── Data/
│   └── AppDbContext.cs          # Entity Framework Core DbContext
├── Controllers/
│   └── AuthController.cs        # API endpoints (Login, GetLocations)
├── Program.cs                   # Application startup and configuration
├── appsettings.json             # Configuration with connection string
├── appsettings.Development.json # Development-specific settings
├── EnhanzerAPI.csproj           # Project file
└── README.md                    # This file
```

## Prerequisites

- .NET 7.0 SDK or higher
- SQL Server (Local or Remote)
- Visual Studio Code or Visual Studio

## Setup Instructions

### 1. Database Setup

The application is configured to use the local SQL Server instance. The database will be created automatically when you run the migrations.

**Update Connection String** (if needed):
- Open `appsettings.json`
- Modify the `ConnectionStrings:DefaultConnection` to match your SQL Server instance:
  - For local: `.` (dot) or `localhost`
  - For remote: provide server address and authentication details

### 2. Restore NuGet Packages

```bash
dotnet restore
```

### 3. Create Database and Apply Migrations

```bash
# Add initial migration
dotnet ef migrations add InitialCreate

# Apply migration to create database
dotnet ef database update
```

This will create:
- Database: `EnhanzerDB`
- Table: `Location_Details` with columns:
  - `Id` (int, Primary Key)
  - `Location_Code` (string)
  - `Location_Name` (string)

### 4. Build the Project

```bash
dotnet build
```

### 5. Run the Application

```bash
dotnet run
```

The API will be available at:
- HTTPS: `https://localhost:5001`
- HTTP: `http://localhost:5000`

Swagger UI: Open your browser and navigate to `https://localhost:5001/swagger` to view and test the API.

## API Endpoints

### POST /api/auth/login

**Purpose**: Authenticate user and sync locations from external API.

**Request Body:**
```json
{
  "email": "user@company.com",
  "password": "password123"
}
```

**Process:**
1. Calls external API: `https://ez-staging-api.azurewebsites.net/api/External_Api/POS_Api/Invoke`
2. Sends authentication request with Device_Id "D001"
3. If successful, extracts `User_Locations` array from response
4. Clears existing locations from database
5. Inserts new locations into `Location_Details` table

**Success Response (200 OK):**
```json
{
  "message": "Login successful",
  "email": "user@company.com"
}
```

**Failure Response (400 Bad Request):**
```json
"Login Failed"
```

### GET /api/auth/locations

**Purpose**: Retrieve all saved locations from the database.

**Response (200 OK):**
```json
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
```

**Failure Response (400 Bad Request):**
```json
"Error retrieving locations: {error message}"
```

## Configuration Details

### Connection String
- Location: `appsettings.json`
- Default: `Server=.;Database=EnhanzerDB;Trusted_Connection=true;TrustServerCertificate=true;`
- Supports Windows Authentication

### CORS Policy
- Enabled for all origins (`*`)
- Allows all HTTP methods and headers
- Configured for development purposes; restrict for production

### External API Integration
- Base URL: `https://ez-staging-api.azurewebsites.net/api/External_Api/POS_Api/Invoke`
- Uses `IHttpClientFactory` for HTTP client management
- Sends requests with `API_Action: "GetLoginData"`
- Device ID: "D001"

## Key Features

✓ **Entity Framework Core** - ORM for database operations
✓ **SQL Server Integration** - Robust database with proper schema
✓ **External API Integration** - Calls external authentication service
✓ **Async/Await** - Non-blocking operations throughout
✓ **Dependency Injection** - Proper DI configuration
✓ **CORS Enabled** - Cross-origin requests supported
✓ **Swagger/OpenAPI** - Built-in API documentation
✓ **Error Handling** - Try-catch blocks with meaningful messages

## Project Design

### Models
- `Location.cs` - Represents location data with code and name

### Data Access
- `AppDbContext.cs` - Entity Framework DbContext with:
  - Proper entity configuration
  - Database table mapping
  - Property constraints

### API Controller
- `AuthController.cs` - Handles:
  - `POST /api/auth/login` - Authentication and location sync
  - `GET /api/auth/locations` - Location retrieval
  - External API integration
  - Error handling

### Services Configuration
- HttpClientFactory for HTTP requests
- DbContext dependency injection
- CORS policy for all origins
- Swagger/Swashbuckle for API documentation

## Troubleshooting

**Database Connection Issues:**
- Verify SQL Server is running
- Check connection string in `appsettings.json`
- For Windows Auth, ensure user has SQL Server permissions

**External API Connection Issues:**
- Verify internet connectivity
- Check firewall/proxy settings
- Ensure API endpoint is accessible

**Build Errors:**
- Run `dotnet clean` then `dotnet build`
- Delete `bin` and `obj` folders and rebuild
- Ensure .NET 7.0 SDK is installed

## Dependencies

- **Microsoft.EntityFrameworkCore** (7.0.0)
- **Microsoft.EntityFrameworkCore.SqlServer** (7.0.0)
- **Microsoft.EntityFrameworkCore.Tools** (7.0.0)
- **Swashbuckle.AspNetCore** (6.5.0)

## License

This project is provided as-is for educational and commercial use.
