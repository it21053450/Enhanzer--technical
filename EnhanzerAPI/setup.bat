@echo off
REM Setup script for EnhanzerAPI - Database migration and initialization

echo.
echo ========================================
echo   Enhanzer API - Setup Script
echo ========================================
echo.

REM Check if dotnet is installed
where dotnet >nul 2>nul
if errorlevel 1 (
    echo ERROR: .NET CLI is not installed or not in PATH
    echo Please install .NET 7.0 SDK from https://dotnet.microsoft.com/download
    pause
    exit /b 1
)

echo [1/4] Restoring NuGet packages...
dotnet restore
if errorlevel 1 (
    echo ERROR: Failed to restore packages
    pause
    exit /b 1
)
echo ✓ Packages restored successfully

echo.
echo [2/4] Building the project...
dotnet build
if errorlevel 1 (
    echo ERROR: Failed to build project
    pause
    exit /b 1
)
echo ✓ Project built successfully

echo.
echo [3/4] Creating database migration...
dotnet ef migrations add InitialCreate
if errorlevel 1 (
    echo ERROR: Failed to create migration
    echo This might happen if migration already exists. You can skip this.
    REM Don't exit here, continue to database update
)
echo ✓ Migration created

echo.
echo [4/4] Applying migrations to database...
dotnet ef database update
if errorlevel 1 (
    echo ERROR: Failed to update database
    echo Please ensure SQL Server is running and connection string is correct
    pause
    exit /b 1
)
echo ✓ Database updated successfully

echo.
echo ========================================
echo   Setup Complete!
echo ========================================
echo.
echo Database: EnhanzerDB
echo Table: Location_Details
echo.
echo To start the application, run:
echo   dotnet run
echo.
echo API will be available at:
echo   https://localhost:5001
echo   Swagger UI: https://localhost:5001/swagger
echo.
pause
