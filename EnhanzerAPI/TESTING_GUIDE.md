# Enhanzer API - Testing Guide

## Testing the API

You can test the API using:
1. **Swagger UI** (Easiest) - `https://localhost:5001/swagger`
2. **curl commands** (Command line)
3. **Postman** (App-based)
4. **Visual Studio Code REST Client** (VS Code extension)

---

## 🎯 Swagger UI (Recommended for Beginners)

1. Start the application: `.\run.bat`
2. Open browser: `https://localhost:5001/swagger`
3. Click on endpoint to expand
4. Click "Try it out"
5. Enter request body and click "Execute"

---

## 📝 CURL Commands

### Test Login Endpoint

```bash
# POST /api/auth/login
curl -X POST https://localhost:5001/api/auth/login ^
  -H "Content-Type: application/json" ^
  -d "{\"email\":\"user@company.com\",\"password\":\"password123\"}" ^
  --insecure
```

**Windows CMD Alternative:**
```cmd
curl -X POST https://localhost:5001/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"user@company.com\",\"password\":\"password123\"}" --insecure
```

**PowerShell:**
```powershell
$body = @{
    email = "user@company.com"
    password = "password123"
} | ConvertTo-Json

Invoke-WebRequest -Uri "https://localhost:5001/api/auth/login" `
  -Method POST `
  -ContentType "application/json" `
  -Body $body `
  -SkipCertificateCheck
```

### Test Get Locations Endpoint

```bash
# GET /api/auth/locations
curl -X GET https://localhost:5001/api/auth/locations --insecure
```

**PowerShell:**
```powershell
Invoke-WebRequest -Uri "https://localhost:5001/api/auth/locations" `
  -Method GET `
  -SkipCertificateCheck | ConvertTo-Json
```

---

## 🧪 Using Postman

### Setup Postman
1. Download and install [Postman](https://www.postman.com/downloads/)
2. Create a new collection "Enhanzer API"
3. Add requests below

### Request 1: Login

**Type:** POST  
**URL:** `https://localhost:5001/api/auth/login`  
**Headers:**
```
Content-Type: application/json
```

**Body (JSON):**
```json
{
  "email": "user@company.com",
  "password": "password123"
}
```

**Settings:** Turn off SSL certificate verification (temporary for testing)

### Request 2: Get Locations

**Type:** GET  
**URL:** `https://localhost:5001/api/auth/locations`  
**Headers:**
```
Content-Type: application/json
```

---

## 🔌 Using VS Code REST Client Extension

### Install Extension
1. Open VS Code
2. Go to Extensions (Ctrl+Shift+X)
3. Search for "REST Client"
4. Install by Hu Wenyi

### Create Test File
Create `api-test.http` in your project:

```http
### Variables
@baseUrl = https://localhost:5001
@email = user@company.com
@password = password123

### Test Login
POST {{baseUrl}}/api/auth/login
Content-Type: application/json

{
  "email": "{{email}}",
  "password": "{{password}}"
}

### Test Get Locations
GET {{baseUrl}}/api/auth/locations
Content-Type: application/json

```

### Run Tests
- Click "Send Request" above each request
- View response in the side panel

---

## 📊 Expected Responses

### Successful Login Response
```json
{
  "message": "Login successful",
  "email": "user@company.com"
}
```

### Failed Login Response
```json
"Login Failed"
```

### Get Locations Response
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

### Empty Locations Response
```json
[]
```

---

## 🔐 SSL Certificate Warning

When testing with HTTPS on localhost, you may get SSL certificate warnings:
- **curl:** Use `--insecure` flag
- **PowerShell:** Use `-SkipCertificateCheck`
- **Postman:** Disable SSL verification in settings

This is normal for development. In production, use proper certificates.

---

## 🚀 Test Workflow

1. **Start Application**
   ```bash
   .\run.bat
   ```

2. **Open Swagger UI**
   ```
   https://localhost:5001/swagger
   ```

3. **Test Login** (External API will be called)
   - Click POST /api/auth/login
   - Enter email and password
   - Click Execute
   - Verify response

4. **Test Get Locations**
   - Click GET /api/auth/locations
   - Click Execute
   - Should see locations from database

---

## 🐛 Debugging Tips

### Check if API is running
```bash
# Should return redirect to swagger
curl https://localhost:5001 --insecure
```

### Test database connection
The API will fail gracefully if DB isn't available. Check:
- SQL Server is running
- EnhanzerDB exists
- Location_Details table exists
- Connection string in appsettings.json is correct

### View API Logs
Logs appear in console when running `dotnet run`

### Test External API connectivity
Verify the external API is reachable:
```bash
curl https://ez-staging-api.azurewebsites.net -v
```

---

## 📱 Testing from Frontend

When integrating with your frontend:

```javascript
// JavaScript Example
const loginData = {
  email: "user@company.com",
  password: "password123"
};

fetch('https://localhost:5001/api/auth/login', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify(loginData)
})
.then(response => response.json())
.then(data => console.log('Login Response:', data))
.catch(error => console.error('Error:', error));
```

```python
# Python Example
import requests
import json

url = "https://localhost:5001/api/auth/login"
data = {
    "email": "user@company.com",
    "password": "password123"
}

response = requests.post(url, json=data, verify=False)
print("Status Code:", response.status_code)
print("Response:", response.json())
```

---

## ✅ Checklist for Testing

- [ ] Application starts without errors (`dotnet run`)
- [ ] Database is created (EnhanzerDB)
- [ ] Location_Details table is created
- [ ] Swagger UI is accessible at `https://localhost:5001/swagger`
- [ ] POST /api/auth/login endpoint is callable
- [ ] GET /api/auth/locations endpoint is callable
- [ ] Login returns appropriate response (success or failure)
- [ ] Locations are saved to database after successful login
- [ ] CORS allows frontend origin

---

## 🔗 Useful Links

- **Swagger UI:** `https://localhost:5001/swagger`
- **Postman Download:** https://www.postman.com/downloads/
- **REST Client Extension:** https://marketplace.visualstudio.com/items?itemName=humao.rest-client
- **External API:** https://ez-staging-api.azurewebsites.net

---

## 📞 Need Help?

Refer to:
- [README.md](README.md) - Full documentation
- [QUICKSTART.md](QUICKSTART.md) - Quick reference
- [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) - Implementation summary
