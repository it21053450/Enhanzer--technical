# 🚀 Enhanzer Full-Stack Application - STARTUP GUIDE

## 📋 Overview

Complete working full-stack application with:
- **Backend**: ASP.NET Core 7 Web API with JWT authentication
- **Frontend**: Angular 17 with responsive UI
- **Database**: SQL Server with automatic migration
- **External API**: Integration for user authentication

**Status**: ✅ Ready to run immediately

---

## ⚡ Quick Start (5 minutes)

### Terminal 1: Start Backend
```bash
cd c:\Users\odith\OneDrive\Desktop\Assignment\EnhanzerAPI
dotnet run
```
**Output**: Backend running on `https://localhost:5001`

### Terminal 2: Start Frontend
```bash
cd c:\Users\odith\OneDrive\Desktop\Assignment\EnhanzerFrontend
npm install
npm start
```
**Output**: Frontend running on `http://localhost:4200`

### Browser
Open: `http://localhost:4200`

---

## 🎯 Step-by-Step Setup

### Prerequisites Check
- [ ] .NET 7.0 SDK installed: `dotnet --version`
- [ ] Node.js 18+ installed: `node --version` and `npm --version`
- [ ] SQL Server running and accessible
- [ ] Two terminal windows open

### STEP 1: Backend Setup (Terminal 1)

```bash
# Navigate to backend
cd c:\Users\odith\OneDrive\Desktop\Assignment\EnhanzerAPI

# First time only: Restore packages
dotnet restore

# Build the project
dotnet build
```

**Expected Output:**
```
Build succeeded with X warning(s)
```

### STEP 2: Database Setup (Terminal 1)

```bash
# Create and apply database migrations
dotnet ef migrations add InitialCreate
dotnet ef database update
```

**Expected Output:**
```
Build started...
Database updated successfully
```

This creates:
- Database: `EnhanzerDB`
- Table: `Location_Details`

### STEP 3: Start Backend (Terminal 1)

```bash
dotnet run
```

**Expected Output:**
```
Now listening on: https://localhost:5001
Now listening on: http://localhost:5000
Application started. Press Ctrl+C to shut down.
```

✅ Backend is ready!

### STEP 4: Frontend Setup (Terminal 2)

```bash
# Navigate to frontend
cd c:\Users\odith\OneDrive\Desktop\Assignment\EnhanzerFrontend

# Install dependencies (first time only)
npm install
```

**Expected Output:**
```
added XXX packages
up to date in X.XXs
```

### STEP 5: Start Frontend (Terminal 2)

```bash
npm start
```

**Expected Output:**
```
✔ Compiled successfully.
⠸ Compiling...
✔ Built successfully.
Listening on localhost:4200
```

✅ Frontend is ready!

### STEP 6: Access Application

1. Open browser and go to: `http://localhost:4200`
2. Login page will display
3. Use any valid credentials (external API will validate)
4. After login, Purchase Bill page loads
5. Add items and manage bills

---

## 📱 Login & Features

### Test Credentials
Use any email/password combination. External API will validate:
- **Email**: example@company.com
- **Password**: any3chars (minimum 3 characters)

### Login Flow
1. Enter email and password
2. Backend calls external API for validation
3. Locations are synced from API response
4. JWT token generated
5. Redirected to Purchase Bill page

### Purchase Bill Features
✅ Fruit autocomplete (Mango, Apple, Banana, etc.)
✅ Batch selection from database locations
✅ Real-time cost calculations with discount
✅ Add multiple items to bill
✅ View items in table
✅ Delete items
✅ Summary with total items and quantity

---

## 🗂️ Project Structure

```
EnhanzerAPI/                          Backend (.NET Core)
├── Controllers/AuthController.cs      API endpoints
├── Services/
│   ├── AuthService.cs                 Authentication logic
│   └── JwtTokenService.cs             JWT token generation
├── Models/Location.cs                 Database model
├── Data/AppDbContext.cs               Database context
├── Program.cs                         Startup config
└── appsettings.json                   Configuration

EnhanzerFrontend/                     Frontend (Angular 17)
├── src/app/
│   ├── components/
│   │   ├── login/                     Login page
│   │   └── purchase-bill/             Purchase bill page
│   ├── services/
│   │   ├── auth.service.ts            Auth service
│   │   └── location.service.ts        Location service
│   ├── guards/auth.guard.ts           Route protection
│   └── models/                        Interfaces
├── src/environments/                  Configuration
└── src/index.html                     Entry point
```

---

## 🔐 Authentication Flow

```
1. User enters email & password
   ↓
2. Frontend sends to: POST /api/auth/login
   ↓
3. Backend calls external API
   ↓
4. If login succeeds:
   - Locations saved to database
   - JWT token generated
   - Return token to frontend
   ↓
5. Frontend stores token in localStorage
   ↓
6. Frontend redirects to Purchase Bill page
   ↓
7. AuthGuard protects the route
```

---

## 🧮 Purchase Bill Calculations

### Total Cost Formula
```
Total Cost = (Standard Cost × Quantity) - (Discount %)
```

**Example:**
- Standard Cost: 100
- Quantity: 5
- Subtotal: 100 × 5 = 500
- Discount 20%: 500 × 0.20 = 100
- **Final Total Cost: 400**

### Total Selling Formula
```
Total Selling = Standard Price × Quantity
```

**Example:**
- Standard Price: 150
- Quantity: 5
- **Total Selling: 750**

---

## 🔌 API Endpoints

### Login
```
POST https://localhost:5001/api/auth/login

Request:
{
  "email": "user@example.com",
  "password": "password123"
}

Response:
{
  "message": "Login successful",
  "token": "eyJhbG...",
  "email": "user@example.com"
}
```

### Get Locations
```
GET https://localhost:5001/api/auth/locations

Response:
[
  {
    "id": 1,
    "location_Code": "LOC001",
    "location_Name": "Main Office"
  },
  ...
]
```

### Swagger UI
Available at: `https://localhost:5001/swagger`

---

## 🛠️ Troubleshooting

### Backend won't start
```
Error: "Could not connect to database"
```
**Solution:**
1. Verify SQL Server is running
2. Check connection string in `appsettings.json`
3. Run: `dotnet ef database update`

### Frontend won't connect to backend
```
Error: "Failed to connect to https://localhost:5001"
```
**Solution:**
1. Verify backend is running
2. Check browser console for errors
3. Verify `apiUrl` in `src/environments/environment.ts`

### Login fails
```
Error: "Login Failed"
```
**Solution:**
1. Verify your email format is valid
2. Password must be minimum 3 characters
3. Check backend logs for external API errors

### Port already in use
```
Error: "Port 5001 already in use" or "Port 4200 already in use"
```
**Solution:**
1. Kill existing process: `netstat -ano | findstr :5001`
2. Or use different port: `dotnet run --urls "https://localhost:5002"`

### npm install fails
```
Error: "npm ERR!"
```
**Solution:**
```bash
# Clear npm cache
npm cache clean --force

# Try install again
npm install
```

---

## 📊 Testing the Application

### Test Login
1. Go to `http://localhost:4200`
2. Enter any valid email: `test@example.com`
3. Enter password: `password` (3+ chars)
4. Click Login
5. Should redirect to Purchase Bill page

### Test Purchase Bill
1. Select item: "Mango"
2. Type/select batch: Start typing location name
3. Enter Standard Cost: 100
4. Enter Standard Price: 150
5. Enter Quantity: 5
6. Enter Discount: 20
7. Click "Add Item"
8. View calculations and item in table

### Test Logout
1. Click "Logout" button
2. Should return to login page

---

## 🚪 Environment URLs

| Component | URL | Port |
|-----------|-----|------|
| Frontend | http://localhost:4200 | 4200 |
| Backend | https://localhost:5001 | 5001 |
| Swagger UI | https://localhost:5001/swagger | 5001 |
| Database | localhost or . | (SQL Server) |
| External API | https://ez-staging-api.azurewebsites.net | - |

---

## 📋 Project Features Checklist

### ✅ Backend Features
- [x] ASP.NET Core 7 Web API
- [x] JWT authentication
- [x] External API integration
- [x] SQL Server with Entity Framework Core
- [x] Automatic database creation
- [x] Location sync from external API
- [x] Dependency injection
- [x] CORS enabled
- [x] Swagger documentation
- [x] Clean architecture (Services, Controller)

### ✅ Frontend Features
- [x] Angular 17 latest version
- [x] Login page with validation
- [x] Protected routes with AuthGuard
- [x] Purchase bill page
- [x] Item autocomplete dropdown
- [x] Batch location dropdown
- [x] Real-time calculations
- [x] Dynamic item table
- [x] Add/Delete items
- [x] Summary section
- [x] Responsive design
- [x] Clean UI with CSS Grid/Flexbox
- [x] Form validation
- [x] Error handling
- [x] JWT token storage

---

## 🔄 Workflow Example

### Complete User Journey
```
1. User opens http://localhost:4200
                ↓
2. Login page displayed
                ↓
3. User enters credentials
                ↓
4. Click "Login"
                ↓
5. Frontend calls POST /api/auth/login
                ↓
6. Backend validates via external API
                ↓
7. Backend saves locations to database
                ↓
8. Backend generates JWT token
                ↓
9. Frontend stores token
                ↓
10. AuthGuard allows access
                ↓
11. Purchase Bill page displays
                ↓
12. Locations loaded in dropdown
                ↓
13. User selects item, batch, values
                ↓
14. Calculations update in real-time
                ↓
15. Click "Add Item"
                ↓
16. Item added to table
                ↓
17. Summary updates
                ↓
18. Click "Logout"
                ↓
19. Session cleared
                ↓
20. Redirect to login
```

---

## 💾 Database Schema

### Location_Details Table
```sql
CREATE TABLE Location_Details (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Location_Code NVARCHAR(255) NOT NULL,
    Location_Name NVARCHAR(255) NOT NULL
)
```

Populated from external API response on login.

---

## 🎨 UI Components

### Login Component
- Email input with validation
- Password input with validation
- Login button with loading state
- Error message display
- Clean gradient background

### Purchase Bill Component
- Header with logout button
- Form with 6 fields
- Autocomplete dropdowns
- Real-time calculation display
- Item table with actions
- Summary section
- Success/error messages
- Responsive grid layout

---

## 🔒 Security

✅ **JWT Authentication**: Secure token-based auth
✅ **Protected Routes**: AuthGuard blocks unauthorized access
✅ **HTTPS**: All API calls use HTTPS
✅ **CORS**: Configured for security
✅ **Password Validation**: Minimum length required
✅ **Email Validation**: Valid email format required
✅ **Session Management**: LocalStorage with token

---

## 📦 Dependencies

### Backend
- Microsoft.EntityFrameworkCore (7.0.0)
- Microsoft.EntityFrameworkCore.SqlServer (7.0.0)
- System.IdentityModel.Tokens.Jwt (7.1.2)
- Microsoft.AspNetCore.Authentication.JwtBearer (7.0.0)
- Swashbuckle.AspNetCore (6.5.0)

### Frontend
- @angular/core (17.0.0)
- @angular/forms (17.0.0)
- @angular/router (17.0.0)
- @angular/platform-browser (17.0.0)
- rxjs (7.8.0)

---

## 📞 Support

### Backend Issues
Refer to: `EnhanzerAPI/README.md`

### Frontend Issues
Refer to: `EnhanzerFrontend/README.md`

### API Documentation
Swagger UI: `https://localhost:5001/swagger`

---

## 🎉 Success Checklist

After starting both applications:

- [ ] Backend running on `https://localhost:5001`
- [ ] Frontend running on `http://localhost:4200`
- [ ] Database `EnhanzerDB` created
- [ ] Table `Location_Details` created
- [ ] Login page displays in browser
- [ ] Can login with valid credentials
- [ ] Locations appear in dropdown
- [ ] Can add items to bill
- [ ] Calculations work correctly
- [ ] Can delete items
- [ ] Summary updates
- [ ] Logout works
- [ ] Redirected to login after logout

---

## 🚀 Next Steps

1. **Customize Configuration**
   - Update JWT secret key in `appsettings.json`
   - Change API URL in production environment

2. **Add Features**
   - Save purchase bills to database
   - Generate PDF/Excel export
   - User profile management
   - Multi-user support

3. **Deploy**
   - Publish backend: `dotnet publish -c Release`
   - Build frontend: `npm run build`
   - Deploy to Azure/AWS/hosting service

4. **Monitor**
   - Review application logs
   - Monitor database performance
   - Track API response times

---

## 📄 Project Status

✅ **Development**: Complete
✅ **Testing**: Ready
✅ **Documentation**: Comprehensive
✅ **Deployment**: Ready for production

---

**Good to go! Enjoy your application! 🚀**
