#!/bin/bash

# Setup script for EnhanzerAPI - Database migration and initialization

echo ""
echo "========================================"
echo "   Enhanzer API - Setup Script"
echo "========================================"
echo ""

# Check if dotnet is installed
if ! command -v dotnet &> /dev/null; then
    echo "ERROR: .NET CLI is not installed or not in PATH"
    echo "Please install .NET 7.0 SDK from https://dotnet.microsoft.com/download"
    exit 1
fi

echo "[1/4] Restoring NuGet packages..."
dotnet restore
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to restore packages"
    exit 1
fi
echo "✓ Packages restored successfully"

echo ""
echo "[2/4] Building the project..."
dotnet build
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to build project"
    exit 1
fi
echo "✓ Project built successfully"

echo ""
echo "[3/4] Creating database migration..."
dotnet ef migrations add InitialCreate
if [ $? -ne 0 ]; then
    echo "Warning: Failed to create migration (might already exist)"
fi
echo "✓ Migration created/verified"

echo ""
echo "[4/4] Applying migrations to database..."
dotnet ef database update
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to update database"
    echo "Please ensure SQL Server is running and connection string is correct"
    exit 1
fi
echo "✓ Database updated successfully"

echo ""
echo "========================================"
echo "   Setup Complete!"
echo "========================================"
echo ""
echo "Database: EnhanzerDB"
echo "Table: Location_Details"
echo ""
echo "To start the application, run:"
echo "   dotnet run"
echo ""
echo "API will be available at:"
echo "   https://localhost:5001"
echo "   Swagger UI: https://localhost:5001/swagger"
echo ""
