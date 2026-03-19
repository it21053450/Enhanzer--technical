# ⚡ QUICK REFERENCE CARD

## 🚀 Start Application (Copy-Paste Commands)

### Terminal 1 - Backend
```powershell
cd c:\Users\odith\OneDrive\Desktop\Assignment\EnhanzerAPI
dotnet run
```

### Terminal 2 - Frontend  
```powershell
cd c:\Users\odith\OneDrive\Desktop\Assignment\EnhanzerFrontend
npm install
npm start
```

### Browser
```
http://localhost:4200
```

---

## 🔐 Test Login
- **Email**: test@company.com (or any email)
- **Password**: password123 (minimum 3 characters)
- **Click**: Login button

---

## 📝 Test Purchase Bill

1. **Item**: Mango (select from dropdown)
2. **Batch**: Start typing location name (autocomplete)
3. **Standard Cost**: 100
4. **Standard Price**: 150
5. **Quantity**: 5
6. **Discount**: 20
7. **Click**: Add Item

**Expected Calculations**:
- Total Cost: 400 (500 - 100)
- Total Selling: 750

---

## 📍 Important URLs

| Service | URL |
|---------|-----|
| **Frontend** | http://localhost:4200 |
| **Backend** | https://localhost:5001 |
| **API Docs** | https://localhost:5001/swagger |
| **Database** | EnhanzerDB (SQL Server) |

---

## 📁 Project Locations

```
Backend:   c:\Users\odith\OneDrive\Desktop\Assignment\EnhanzerAPI
Frontend:  c:\Users\odith\OneDrive\Desktop\Assignment\EnhanzerFrontend
```

---

## 🔄 Workflow

```
Login → Validate → Call API → Save Locations → Token → Bill Page
  ↓        ↓         ↓          ↓              ↓        ↓
Form   Email/Pwd  External   Database       JWT      Add Items
Valid  Format     API        Update       24hrs      Calculate
       Min 3ch    Returns    Location     Stored     Summary
              Locations   Details
```

---

## 💾 Database Auto-Setup

Database is created automatically on first run:
- **Name**: EnhanzerDB
- **Table**: Location_Details
- **Columns**: Id, Location_Code, Location_Name

---

## 🧮 Calculations

**Total Cost**:
```
(Cost × Qty) - Discount% = Total Cost
(100 × 5) - 20% = 400
```

**Total Selling**:
```
Price × Qty = Total Selling
150 × 5 = 750
```

---

## ⚠️ Troubleshooting Quick Fix

| Problem | Solution |
|---------|----------|
| Backend won't start | Run: `dotnet build` first |
| Frontend won't load | Run: `npm install` first |
| Database error | Ensure SQL Server running |
| Port in use | Change port or kill process |
| Login fails | Check credentials format |

---

## 📚 Documentation

- **STARTUP_GUIDE.md** - Full setup (recommended read)
- **ARCHITECTURE.md** - System design & diagrams
- **DELIVERY_SUMMARY.md** - What's included
- **EnhanzerAPI/README.md** - Backend details
- **EnhanzerFrontend/README.md** - Frontend details

---

## ✅ Success Indicators

- [ ] Backend runs without errors
- [ ] Frontend loads on localhost:4200
- [ ] Login button works
- [ ] Can see Purchase Bill page
- [ ] Can add items to bill
- [ ] Calculations display correctly
- [ ] Logout works

---

## 🎯 Features Summary

✅ Login with email/password
✅ External API integration
✅ JWT authentication
✅ Auto location dropdown
✅ Real-time calculations
✅ Add/delete items
✅ Summary section
✅ Responsive design
✅ Professional UI
✅ Error handling
✅ Clean architecture

---

## 🔐 Security Features

- JWT tokens (24-hour expiration)
- Protected routes (AuthGuard)
- Input validation
- Secure HTTPS
- CORS configured
- Session management

---

## 📊 Tech Stack

**Frontend**: Angular 17, TypeScript, CSS3
**Backend**: ASP.NET Core 7, C#, EF Core
**Database**: SQL Server
**Auth**: JWT
**API**: RESTful

---

## 🎓 You Have Here

- ✅ Complete working application
- ✅ Fully functional backend
- ✅ Modern responsive frontend
- ✅ Database with migrations
- ✅ JWT authentication
- ✅ Clean architecture
- ✅ Complete documentation
- ✅ Ready to deploy

---

## 📞 Need Help?

1. Check **STARTUP_GUIDE.md** for step-by-step
2. Check **ARCHITECTURE.md** for system design
3. Check **README.md** for overview
4. Check component README.md files for specific help

---

## 🎉 YOU'RE READY!

Just run the commands above and access the app in your browser.

No additional setup needed. Everything is pre-configured.

**Enjoy!** 🚀
