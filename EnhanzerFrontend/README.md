# Enhanzer - Full Stack Application

Complete full-stack web application built with Angular 17 (Frontend) and ASP.NET Core 7 (Backend).

## Project Overview

A 2-page web application for managing purchase bills with:
- **Login Page** - User authentication via external API
- **Purchase Bill Page** - Create and manage purchase bills with dynamic calculations

## Technology Stack

### Frontend
- **Angular 17** - Latest version
- **TypeScript** - Strongly typed JavaScript
- **Reactive Forms** - For form handling with validation
- **Angular Router** - Client-side routing with route guards
- **HttpClient** - For API communication
- **CSS3** - Modern styling with Flexbox and Grid

### Backend
- **ASP.NET Core 7** - Web API framework
- **Entity Framework Core 7** - ORM for database
- **SQL Server** - Database
- **JWT** - Token-based authentication

## Project Structure

```
Assignment/
├── EnhanzerAPI/                    # ASP.NET Core Backend
│   ├── Models/
│   │   └── Location.cs
│   ├── Data/
│   │   └── AppDbContext.cs
│   ├── Controllers/
│   │   └── AuthController.cs
│   ├── Services/
│   │   ├── IAuthService.cs
│   │   ├── AuthService.cs
│   │   ├── ITokenService.cs
│   │   └── JwtTokenService.cs
│   ├── Program.cs
│   ├── appsettings.json
│   └── EnhanzerAPI.csproj
│
└── EnhanzerFrontend/               # Angular Frontend
    ├── src/
    │   ├── app/
    │   │   ├── models/
    │   │   │   └── index.ts
    │   │   ├── services/
    │   │   │   ├── auth.service.ts
    │   │   │   └── location.service.ts
    │   │   ├── guards/
    │   │   │   └── auth.guard.ts
    │   │   ├── components/
    │   │   │   ├── login/
    │   │   │   │   ├── login.component.ts
    │   │   │   │   ├── login.component.html
    │   │   │   │   └── login.component.css
    │   │   │   └── purchase-bill/
    │   │   │       ├── purchase-bill.component.ts
    │   │   │       ├── purchase-bill.component.html
    │   │   │       └── purchase-bill.component.css
    │   │   ├── app.module.ts
    │   │   ├── app-routing.module.ts
    │   │   ├── app.component.ts
    │   │   └── app.component.html
    │   ├── environments/
    │   │   ├── environment.ts
    │   │   └── environment.prod.ts
    │   ├── main.ts
    │   ├── index.html
    │   └── styles.css
    ├── package.json
    ├── angular.json
    ├── tsconfig.json
    └── README.md
```

## Features Implemented

### ✅ Authentication
- Login with email and password
- External API integration for credentials verification
- JWT token generation on successful login
- Token stored in localStorage
- Auto-logout on token expiration

### ✅ Database
- SQL Server with Entity Framework Core
- Automatic location sync from external API
- Location data persisted in database

### ✅ Purchase Bill Management
- Add items to bill
- Autocomplete for fruit selection
- Dynamic dropdown for batch locations
- Real-time calculations:
  - Total Cost = (Standard Cost × Quantity) - Discount%
  - Total Selling = Standard Price × Quantity
- Add multiple items
- View items in table
- Delete items from bill
- Summary with total items and quantity

### ✅ Security
- Protected routes (Auth Guard)
- JWT authentication
- Logout functionality
- Session management

### ✅ UI/UX
- Clean, modern design
- Responsive layout
- Form validation
- Error handling
- Success messages
- Loading states

## Setup and Installation

### Backend Setup (.NET)

1. **Navigate to backend directory**
   ```bash
   cd EnhanzerAPI
   ```

2. **Run setup script (Windows)**
   ```bash
   .\setup.bat
   ```

   Or manually:
   ```bash
   # Restore packages
   dotnet restore

   # Build project
   dotnet build

   # Apply migrations
   dotnet ef migrations add InitialCreate
   dotnet ef database update

   # Run application
   dotnet run
   ```

3. **Backend URL**: `https://localhost:5001`

### Frontend Setup (Angular)

1. **Navigate to frontend directory**
   ```bash
   cd EnhanzerFrontend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Start development server**
   ```bash
   npm start
   ```

4. **Frontend URL**: `http://localhost:4200`

## Running the Application

### Prerequisites
- .NET 7.0 SDK
- Node.js 18+ with npm
- SQL Server
- Visual Studio or VS Code

### Step 1: Start Backend
```bash
cd EnhanzerAPI
dotnet run
# Backend runs on https://localhost:5001
```

### Step 2: Start Frontend
```bash
cd EnhanzerFrontend
npm install  # First time only
npm start
# Frontend runs on http://localhost:4200
```

### Step 3: Access Application
- Open browser to `http://localhost:4200`
- Login page will be displayed
- Use credentials to login (external API will be called)
- After successful login, redirected to Purchase Bill page

## API Endpoints

### Backend Endpoints

**POST /api/auth/login**
- Authenticate user and save locations
- Request: `{ email: string, password: string }`
- Response: `{ message: string, token: string, email: string }`

**GET /api/auth/locations**
- Get all saved locations for dropdown
- Response: `Location[]`

### Environment Configuration

**Frontend** (`src/environments/environment.ts`):
```typescript
export const environment = {
  production: false,
  apiUrl: 'https://localhost:5001/api'
};
```

**Backend** (`appsettings.json`):
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=.;Database=EnhanzerDB;..."
  },
  "Jwt": {
    "SecretKey": "your-secret-key",
    "Issuer": "EnhanzerAPI",
    "Audience": "EnhanzerClient"
  }
}
```

## Usage Guide

### Login Page
1. Enter email address
2. Enter password (minimum 3 characters)
3. Click "Login"
4. External API validates credentials
5. Locations are synced from API response
6. JWT token is generated and stored
7. Redirected to Purchase Bill page

### Purchase Bill Page
1. **Add Item:**
   - Select fruit from autocomplete (Mango, Apple, Banana, etc.)
   - Type or select batch location from dropdown
   - Enter Standard Cost
   - Enter Standard Price
   - Enter Quantity
   - Enter Discount percentage

2. **View Calculations:**
   - Total Cost automatically calculated with discount deducted
   - Total Selling automatically calculated
   - Formulas shown in real-time

3. **Add to Bill:**
   - Click "Add Item" button
   - Item appears in table below
   - Summary updates with total items and quantity

4. **Manage Items:**
   - View all added items in table
   - Click "Delete" to remove items
   - Summary updates automatically

5. **Logout:**
   - Click "Logout" button in header
   - Redirected to login page
   - Session cleared

## Key Technologies

### Frontend Features
- **Angular 17** - Latest Angular framework
- **Reactive Forms** - FormBuilder, FormGroup, Validators
- **Angular Router** - Route guards, canActivate
- **HTTP Interceptor** - API communication
- **LocalStorage** - Token and user session persistence
- **RxJS** - Observable streams
- **CSS Grid & Flexbox** - Responsive layout

### Backend Features
- **ASP.NET Core 7** - Web API
- **Entity Framework Core** - Database ORM
- **JWT Authentication** - Secure token generation
- **Dependency Injection** - Service registration
- **CORS** - Cross-origin requests
- **Async/Await** - Non-blocking operations

## Form Validations

### Login Form
✓ Email is required and valid format
✓ Password is required, minimum 3 characters

### Purchase Bill Form
✓ Item is required
✓ Batch is required
✓ Standard Cost is required and >= 0
✓ Standard Price is required and >= 0
✓ Quantity is required and >= 1
✓ Discount is required and 0-100%

## Calculations Example

**Total Cost Calculation:**
```
Standard Cost: 100
Quantity: 5
Discount: 20%

Calculation:
Subtotal = 100 × 5 = 500
Discount = 500 × 20% = 100
Total Cost = 500 - 100 = 400
```

**Total Selling Calculation:**
```
Standard Price: 150
Quantity: 5

Total Selling = 150 × 5 = 750
```

## Security Features

- **JWT Token** - Secure authentication
- **Protected Routes** - AuthGuard prevents unauthorized access
- **HTTPS** - All API calls use HTTPS
- **CORS** - Configured for specific origin
- **Token Storage** - localStorage for client-side persistence
- **Logout** - Clears all stored session data

## Responsive Design

The application is fully responsive for:
- Desktop (1200px+)
- Tablet (768px - 1200px)
- Mobile (< 768px)

CSS Grid layout automatically adjusts on smaller screens.

## Error Handling

- **Login Errors** - Display error messages from API
- **Network Errors** - Graceful error handling
- **Validation Errors** - Form validation feedback
- **Not Found** - Default redirect to login

## Common Issues & Solutions

### Backend won't start
- Ensure SQL Server is running
- Check connection string in appsettings.json
- Verify .NET 7.0 SDK is installed

### Frontend won't connect to backend
- Verify backend is running on https://localhost:5001
- Check CORS configuration in Program.cs
- Verify environment.ts has correct API URL

### Login fails
- Verify external API is accessible
- Check email/password format
- Review backend logs for errors

### Locations not loading
- Ensure login was successful first
- Verify database has location data
- Check GET /api/auth/locations endpoint

## Build for Production

### Backend
```bash
cd EnhanzerAPI
dotnet publish -c Release
# Output: bin/Release/net7.0/publish
```

### Frontend
```bash
cd EnhanzerFrontend
npm run build
# Output: dist/enhanzer-frontend
```

## Future Enhancements

- Add database persistence for purchase bills
- Implement bill export (PDF/Excel)
- Add user profile management
- Multiple language support
- Dark mode theme
- Real-time updates with SignalR

## Files Summary

### Backend Files (7 files)
- 1 Controller
- 2 Services + 2 Interfaces
- 1 Model
- 1 DbContext
- Configuration files

### Frontend Files (15+ files)
- 2 Components with templates and styles
- 2 Services
- 1 Guard
- 1 Module with routing
- 2 Models/Interfaces
- Configuration and environment files

## Support & Documentation

- Backend: See [EnhanzerAPI/README.md](../EnhanzerAPI/README.md)
- API: Swagger UI available at `https://localhost:5001/swagger`
- Angular: Official docs at `https://angular.io`

## License

This project is provided as-is for educational and commercial use.

---

**Status:** ✅ Complete and Ready to Use  
**Last Updated:** March 19, 2026
