# 📊 Enhanzer Architecture & Component Diagram

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         CLIENT BROWSER                          │
│                    [http://localhost:4200]                      │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ HTTP/HTTPS
                              │
        ┌─────────────────────┴─────────────────────┐
        │                                           │
┌───────▼──────────┐                     ┌─────────▼────────┐
│  Login Page      │                     │ Purchase Bill    │
│                  │                     │    Page          │
│ - Email input    │   AuthGuard         │                  │
│ - Password input │   Checks Token      │ - Item Form      │
│ - Login button   │   on Route          │ - Add Item btn   │
│ - Validation     │   Navigation        │ - Items Table    │
└────────┬─────────┘                     │ - Summary        │
         │                               └────────┬─────────┘
         │                                        │
         └─────────────────┬──────────────────────┘
                           │
                    ┌──────▼──────┐
                    │   Services  │
                    │             │
                    │ - AuthService
                    │ - Location  │
                    │  Service    │
                    │ - HttpClient│
                    └──────┬──────┘
                           │
        ┌──────────────────┴──────────────────┐
        │                                     │
        │  HTTPS: localhost:5001              │
        │                                     │
   ┌────▼─────────────────────────────────┐
   │   ASP.NET Core 7 Web API             │
   │                                      │
   │  AuthController                      │
   │  ├─ POST /api/auth/login             │
   │  └─ GET /api/auth/locations          │
   │                                      │
   │  ↓                                    │
   │                                      │
   │  AuthService                         │
   │  ├─ LoginAsync()                     │
   │  ├─ External API Call                │
   │  └─ Location Sync                    │
   │                                      │
   │  ↓                                    │
   │                                      │
   │  JwtTokenService                     │
   │  └─ GenerateToken()                  │
   │                                      │
   └────┬──────────────────────────────────┘
        │
        │
   ┌────▼──────────────────────────────────┐
   │   SQL Server Database                │
   │                                      │
   │   EnhanzerDB                         │
   │   └─ Location_Details               │
   │      ├─ Id (int, PK)                │
   │      ├─ Location_Code               │
   │      └─ Location_Name               │
   │                                      │
   └────────────────────────────────────┘
        △
        │
        │ External API Integration
        │ (On Login Success)
        │
   ┌────┴──────────────────────────────────┐
   │  External Authentication API         │
   │  ez-staging-api.azurewebsites.net    │
   │                                      │
   │  POST /api/External_Api/             │
   │       POS_Api/Invoke                 │
   │                                      │
   │  Request:                            │
   │  - API_Action: "GetLoginData"        │
   │  - Device_Id: "D001"                 │
   │  - Company_Code: email               │
   │  - API_Body: {Username, Pw}          │
   │                                      │
   │  Response:                           │
   │  - IsSuccess: true/false             │
   │  - ResponseData:                     │
   │    - User_Locations: [...]           │
   │                                      │
   └────────────────────────────────────┘
```

---

## Component Hierarchy

```
App Module
│
├── AppComponent (Root)
│   └── <router-outlet>
│
├── Routes
│   ├── /login → LoginComponent
│   └── /purchase-bill → PurchaseBillComponent (Protected)
│       └── CanActivate: AuthGuard
│
└── Shared Services
    ├── AuthService
    ├── LocationService
    ├── JwtTokenService
    └── AuthGuard
```

---

## Data Flow: Login Process

```
┌──────────────────────────┐
│   User Login              │
│  (Email + Password)       │
└──────────┬───────────────┘
           │
           ▼
┌──────────────────────────┐
│ Validation (Frontend)    │
│ - Email format           │
│ - Password min length    │
└──────────┬───────────────┘
           │
           ▼
┌──────────────────────────┐
│ POST /api/auth/login     │
│ Auth Service             │
└──────────┬───────────────┘
           │
           ▼
┌──────────────────────────┐
│ Call External API        │
│ Validate Credentials     │
└──────────┬───────────────┘
           │
        ┌──┴──┐
        │     │
   ┌────▼─┐ ┌─▼────┐
   │ Fail │ │ Pass │
   └────┬─┘ └─┬────┘
        │      │
     Status  ▼
      400   ┌──────────────────────────┐
            │ Extract User_Locations   │
            │ Clear old records        │
            │ Save new locations       │
            └────────┬─────────────────┘
                     │
                     ▼
            ┌──────────────────────────┐
            │ Generate JWT Token       │
            │ Set Expiration: 24hrs    │
            └────────┬─────────────────┘
                     │
                     ▼
            ┌──────────────────────────┐
            │ Return Token to Frontend │
            │ Status: 200              │
            └────────┬─────────────────┘
                     │
                     ▼
            ┌──────────────────────────┐
            │ Store in LocalStorage    │
            │ Set CurrentUser          │
            └────────┬─────────────────┘
                     │
                     ▼
            ┌──────────────────────────┐
            │ Redirect to:             │
            │ /purchase-bill           │
            └──────────────────────────┘
```

---

## Data Flow: Add Purchase Item

```
┌──────────────────────────┐
│   User Enters:           │
│   - Item (Mango)         │
│   - Batch (Location)     │
│   - Cost/Price/Qty/Disc  │
└──────────┬───────────────┘
           │
           ▼
┌──────────────────────────┐
│  Validation              │
│  - All fields required   │
│  - Values >= 0           │
│  - Qty >= 1              │
│  - Discount 0-100%       │
└──────────┬───────────────┘
           │
           ▼
┌──────────────────────────┐
│  Real-time Calculations  │
│                          │
│  Total Cost:             │
│  = (Cost × Qty)          │
│    - (Discount%)         │
│                          │
│  Total Selling:          │
│  = (Price × Qty)         │
└──────────┬───────────────┘
           │
           ▼
┌──────────────────────────┐
│  User Clicks "Add Item"  │
└──────────┬───────────────┘
           │
           ▼
┌──────────────────────────┐
│  Create PurchaseBillItem │
│  Add to items[] array    │
└──────────┬───────────────┘
           │
           ▼
┌──────────────────────────┐
│  Display in Table:       │
│  - All item details      │
│  - Calculated amounts    │
│  - Delete button         │
└──────────┬───────────────┘
           │
           ▼
┌──────────────────────────┐
│  Update Summary:         │
│  - Total Items count     │
│  - Total Quantity sum    │
└──────────────────────────┘
```

---

## File Organization

```
Frontend (Angular 17)
│
├── src/
│   ├── app/
│   │   │
│   │   ├── components/
│   │   │   ├── login/
│   │   │   │   ├── login.component.ts       [Component Logic]
│   │   │   │   ├── login.component.html     [Template]
│   │   │   │   └── login.component.css      [Styles]
│   │   │   │
│   │   │   └── purchase-bill/
│   │   │       ├── purchase-bill.component.ts
│   │   │       ├── purchase-bill.component.html
│   │   │       └── purchase-bill.component.css
│   │   │
│   │   ├── services/
│   │   │   ├── auth.service.ts              [Auth API calls]
│   │   │   └── location.service.ts          [Location API calls]
│   │   │
│   │   ├── guards/
│   │   │   └── auth.guard.ts                [Route Protection]
│   │   │
│   │   ├── models/
│   │   │   └── index.ts                     [TypeScript Interfaces]
│   │   │
│   │   ├── app.module.ts                    [Root Module]
│   │   ├── app-routing.module.ts            [Route Config]
│   │   ├── app.component.ts                 [Root Component]
│   │   └── app.component.html               [Root Template]
│   │
│   ├── environments/
│   │   ├── environment.ts                   [Dev Config]
│   │   └── environment.prod.ts              [Prod Config]
│   │
│   ├── index.html                           [HTML Entry]
│   ├── main.ts                              [Bootstrap]
│   └── styles.css                           [Global Styles]
│
├── package.json                             [Dependencies]
├── angular.json                             [Angular Config]
├── tsconfig.json                            [TypeScript Config]
└── README.md                                [Documentation]


Backend (.NET Core 7)
│
├── Controllers/
│   └── AuthController.cs                    [API Endpoints]
│
├── Services/
│   ├── IAuthService.cs
│   ├── AuthService.cs                       [Auth Logic]
│   ├── ITokenService.cs
│   └── JwtTokenService.cs                   [Token Generation]
│
├── Models/
│   └── Location.cs                          [Data Model]
│
├── Data/
│   └── AppDbContext.cs                      [Database Context]
│
├── Program.cs                               [Startup Config]
├── appsettings.json                         [App Settings]
├── EnhanzerAPI.csproj                       [Project File]
└── README.md                                [Documentation]
```

---

## Authentication Flow Diagram

```
User logs in with email/password
           │
           ▼
    Local validation
     (Frontend)
           │
           ▼
AuthService.login()
     (HTTP POST)
           │
           ▼
POST /api/auth/login
   (Backend)
           │
           ▼
AuthService.LoginAsync()
           │
           ▼
Call External API
           │
        ┌──┴──┐
        │     │
    Fail    Success
        │     │
    Return  ▼
     400   Extract
          Locations
           │
           ▼
        Save to DB
        Location_Details
           │
           ▼
     Generate JWT
        Token
           │
           ▼
        Return
      Token + User
           │
           ▼
   Frontend receives
     response
           │
           ▼
   Store token in
    LocalStorage
           │
           ▼
   Navigate to
   /purchase-bill
           │
           ▼
   AuthGuard allows
     access
           │
           ▼
 Purchase Bill Page
      Loads
```

---

## Database Schema

```
┌─────────────────────────────────────────┐
│        EnhanzerDB                       │
├─────────────────────────────────────────┤
│         Location_Details                │
├─────────────────────────────────────────┤
│ Column          │ Type       │ Notes    │
├─────────────────┼────────────┼──────────┤
│ Id              │ INT        │ PK, Auto │
│ Location_Code   │ NVARCHAR   │ Not Null │
│ Location_Name   │ NVARCHAR   │ Not Null │
└─────────────────────────────────────────┘

Relationships:
- Populated from External API on login
- Displayed in Purchase Bill dropdown
- Cleared and refreshed on each login
```

---

## API Contracts

### Login Request/Response

```json
POST /api/auth/login

Request:
{
  "email": "user@company.com",
  "password": "password123"
}

Response (200 OK):
{
  "message": "Login successful",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "email": "user@company.com"
}

Response (400 Bad Request):
"Login Failed"
```

### Locations Request/Response

```json
GET /api/auth/locations

Response (200 OK):
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

---

## Technology Stack Visualization

```
Frontend Layer
┌──────────────────────────────────────────┐
│  Angular 17                              │
│  ├─ TypeScript 5.2                       │
│  ├─ Reactive Forms                       │
│  ├─ RxJS Observables                     │
│  ├─ Angular Router                       │
│  ├─ HttpClient                           │
│  └─ CSS3 (Grid, Flexbox)                 │
└──────────────────────────────────────────┘
              ↕ HTTP/HTTPS
Application Layer
┌──────────────────────────────────────────┐
│  ASP.NET Core 7                          │
│  ├─ Web API                              │
│  ├─ JWT Authentication                   │
│  ├─ Dependency Injection                 │
│  ├─ Service Layer                        │
│  └─ Error Handling                       │
└──────────────────────────────────────────┘
              ↕ Entity Framework
Data Layer
┌──────────────────────────────────────────┐
│  Entity Framework Core 7                 │
│  ├─ ORM                                  │
│  ├─ Migrations                           │
│  ├─ LINQ Queries                         │
│  └─ Async/Await                          │
└──────────────────────────────────────────┘
              ↕ SQL Driver
┌──────────────────────────────────────────┐
│  SQL Server                              │
│  └─ EnhanzerDB                           │
│     └─ Location_Details Table            │
└──────────────────────────────────────────┘
```

---

## Deployment Architecture (Production)

```
┌────────────────────────────────────────────────┐
│        CDN / Static Hosting                     │
│  (Frontend - Angular built files)              │
│  https://yourdomain.com                        │
└────────────────────────────────────────────────┘
                    ↕ HTTPS
┌────────────────────────────────────────────────┐
│    API Gateway / Load Balancer                 │
│  (Optional - for production scaling)           │
└────────────────────────────────────────────────┘
                    ↕ HTTPS
┌────────────────────────────────────────────────┐
│    Web Server (IIS / Kestrel)                  │
│  (ASP.NET Core 7 Backend)                      │
│  https://api.yourdomain.com                    │
└────────────────────────────────────────────────┘
                    ↕
┌────────────────────────────────────────────────┐
│    SQL Server Database                         │
│  (Backup, Monitoring)                          │
└────────────────────────────────────────────────┘
```

---

## Key Implementation Details

### JWT Token Structure
```
Header.Payload.Signature

Header:
{
  "alg": "HS256",
  "typ": "JWT"
}

Payload:
{
  "email": "user@company.com",
  "nameid": "user@company.com",
  "iat": 1710864000,
  "exp": 1710950400  // +24 hours
}

Signature: HMAC-SHA256(secret)
```

### Form Validation Rules
```
Login Form:
- Email: required + valid format
- Password: required + min 3 chars

Purchase Bill Form:
- Item: required
- Batch: required
- StandardCost: required + >= 0
- StandardPrice: required + >= 0
- Quantity: required + >= 1
- Discount: required + 0-100%
```

### Calculation Logic
```
Total Cost:
  subtotal = standardCost * quantity
  discount_amount = subtotal * (discount / 100)
  total_cost = subtotal - discount_amount

Total Selling:
  total_selling = standardPrice * quantity

Summary:
  total_items = items.length
  total_quantity = SUM(items[].quantity)
```

---

## Security Implementation

```
┌─────────────────────────────────┐
│    Client Browser               │
│  (LocalStorage)                 │
│  - JWT Token                    │
│  - User Info                    │
└──────────────┬──────────────────┘
               │
        Every Request Includes:
        Authorization: Bearer TOKEN
               │
               ▼
┌─────────────────────────────────┐
│    Frontend Middleware          │
│  Validate Token exists          │
│  and is not expired             │
└──────────────┬──────────────────┘
               │
               ▼
┌─────────────────────────────────┐
│    Backend Middleware           │
│  JWT Bearer Token Validation    │
│  - Verify Signature             │
│  - Check Expiration             │
│  - Extract Claims               │
└──────────────┬──────────────────┘
               │
            ┌──┴──┐
            │     │
         Invalid Valid
            │     │
         401   Continue to
        Fail  Endpoint
               │
               ▼
       ┌─────────────────┐
       │ Protected Route │
       │ Executed        │
       └─────────────────┘
```

---

## Error Handling Flow

```
User Action
    │
    ▼
Try-Catch Block
    │
    ├─ Validation Error → Display to User
    ├─ Network Error → Retry or Error Message
    ├─ Auth Error (401) → Redirect to Login
    ├─ Server Error (5xx) → Generic Error Message
    └─ Success → Process Response
    
Error Message Display:
- Frontend: Error alert under form
- Validation: Field-specific messages
- Network: "Connection failed, try again"
```

---

This comprehensive architecture ensures:
✅ Clean separation of concerns
✅ Secure authentication & authorization
✅ Responsive user experience
✅ Scalable & maintainable code
✅ Professional error handling
✅ Production-ready implementation
