# Quick Start Guide

Get the Employee Performance Monitoring System up and running in minutes!

## 🚀 Prerequisites Check

Before starting, verify you have:
- [ ] Java 17+ installed (`java -version`)
- [ ] Maven 3.8.1+ installed (`mvn --version`)
- [ ] Node.js 16+ installed (`node --version`)
- [ ] npm 8+ installed (`npm --version`)

If any are missing, install from:
- Java: https://www.oracle.com/java/technologies/downloads/
- Maven: https://maven.apache.org/download.cgi
- Node.js: https://nodejs.org/

---

## 📋 System Requirements

- **RAM:** 4GB minimum, 8GB recommended
- **Disk Space:** 2GB free space
- **OS:** Windows, macOS, or Linux
- **Ports Required:** 8080 (backend), 3000 (frontend)

---

## ⚡ Quick Start (5 minutes)

### Step 1: Start Backend (Terminal 1)
```bash
cd employee-monitoring-system/backend
mvn spring-boot:run
```

✅ Wait for: `Started EmployeeMonitoringSystemApplication in X seconds`

### Step 2: Start Frontend (Terminal 2)
```bash
cd employee-monitoring-system/frontend
npm install
npm start
```

✅ Browser opens to: `http://localhost:3000`

### Step 3: Login to Admin Dashboard
- URL: http://localhost:3000/admin (or click login)
- Username: `admin`
- Password: `admin123`

---

## 🎯 What You Can Do NOW

### As Admin
1. ✅ View all employees
2. ✅ Add new employees
3. ✅ Delete employees
4. ✅ View performance metrics
5. ✅ See statistics

### As Employee
1. ✅ Search your profile by Employee ID
2. ✅ View your performance metrics
3. ✅ See performance charts/trends
4. ✅ View detailed evaluation records

---

## 📊 Test the App

### Demo Credentials
```
Username: admin
Password: admin123
```

### Test Employee IDs
- EMP001
- EMP002
- EMP003

(More can be added via admin dashboard)

---

## 📁 Project Location

```
c:\Users\dbasy\Desktop\my_app\employee-monitoring-system\
├── backend/          # Spring Boot app (Port 8080)
├── frontend/         # React app (Port 3000)
└── docs/            # Full documentation
```

---

## 🔌 API Endpoints

Quick reference:

```
Backend: http://localhost:8080/api

GET    /employees              # List employees
POST   /employees              # Add employee
DELETE /employees/{id}         # Remove employee

GET    /metrics                # List metrics
POST   /metrics                # Add metrics

POST   /auth/login             # Admin login
GET    /auth/health            # Status check
```

Full API docs: See `docs/API.md`

---

## 📖 Documentation Files

In `employee-monitoring-system/docs/`:

1. **SETUP.md** - Detailed installation & troubleshooting
2. **API.md** - Complete API reference with examples
3. **SAMPLE_DATA.md** - SQL and API commands to add test data
4. **PROJECT_STRUCTURE.md** - File organization and architecture

---

## 🛠️ Troubleshooting

### Port Already in Use
**Backend:**
```bash
# Change port in: backend/src/main/resources/application.properties
server.port=8081
```

**Frontend:**
```bash
PORT=3001 npm start
```

### Maven Issues
```bash
mvn clean install -DskipTests
```

### npm Issues
```bash
npm install --legacy-peer-deps
```

### Backend Won't Start
1. Check Java: `java -version`
2. Check port 8080: `netstat -ano | findstr :8080`
3. Check logs for errors

---

## 📝 Add Sample Data

Option A - Via Admin Dashboard:
1. Login as admin
2. Click "Show Form"
3. Add employees manually

Option B - Via API (See SAMPLE_DATA.md):
```bash
curl -X POST http://localhost:8080/api/employees \
  -H "Content-Type: application/json" \
  -d '{
    "employeeId": "EMP999",
    "name": "Your Name",
    "department": "Your Dept",
    "position": "Your Role",
    "email": "email@example.com"
  }'
```

Option C - Via H2 Console:
1. Go to http://localhost:8080/h2-console
2. Login: username=sa, password=(empty)
3. Run SQL from SAMPLE_DATA.md

---

## 🔗 Important URLs

| Service | URL | Username | Password |
|---------|-----|----------|----------|
| Admin Dashboard | http://localhost:3000/admin | admin | admin123 |
| Employee Dashboard | http://localhost:3000/employee | N/A | N/A |
| API | http://localhost:8080/api | N/A | N/A |
| API Health | http://localhost:8080/api/auth/health | N/A | N/A |
| H2 Database | http://localhost:8080/h2-console | sa | (empty) |

---

## 🎓 Learn More

### Understanding the Code

**Backend Structure:**
- Models: `backend/src/main/java/.../model/`
- Controllers: Handle HTTP requests
- Services: Business logic
- Repositories: Database queries

**Frontend Structure:**
- Pages: Full page components
- Components: Reusable UI parts
- Services: API communication
- Styles: CSS styling

### Key Technologies

- **Spring Boot:** Server framework
- **React:** UI framework
- **Chart.js:** Data visualization
- **H2 Database:** Local database
- **Axios:** HTTP client

---

## 🚀 Next Steps

1. **Explore the Admin Dashboard**
   - Add test employees
   - Add performance metrics
   - Check statistics

2. **Test Employee Dashboard**
   - Search for employees
   - View metrics
   - Analyze charts

3. **Read Full Documentation**
   - See `docs/` folder
   - Understand API structure
   - Learn about customization

4. **Customize the App**
   - Change colors inStyles
   - Add more fields
   - Integrate with Firebase
   - Deploy to production

---

## 📚 Full Documentation

See the `docs/` folder in the project:

```
docs/
├── SETUP.md                 # Installation (detailed)
├── API.md                   # API documentation
├── SAMPLE_DATA.md          # Test data & scenarios
└── PROJECT_STRUCTURE.md    # Architecture & files
```

Also check main:
```
README.md                    # Project overview
```

---

## 🌟 Features Checklist

### ✅ Completed Features

**Backend**
- [x] Spring Boot REST API
- [x] Employee CRUD operations
- [x] Performance metrics tracking
- [x] Admin authentication
- [x] CORS configuration
- [x] Error handling
- [x] Database integration (H2)

**Frontend**
- [x] React SPA
- [x] Admin login page
- [x] Employee management dashboard
- [x] Employee profile dashboard
- [x] Performance charts
- [x] Responsive design
- [x] Form validation

**DevOps**
- [x] Docker ready (can be containerized)
- [x] Environment configuration
- [x] Database initialization

---

## 💡 Tips & Tricks

1. **Keep terminals open** - Both backend and frontend must run simultaneously
2. **Check browser console** - F12 shows API errors
3. **Use H2 Console** - Useful for viewing/debugging database data
4. **Reload frontend** - Ctrl+R or Cmd+R to refresh React app
5. **Clear cache** - Ctrl+Shift+Delete if stuck on old version

---

## ✨ Getting Help

If something doesn't work:

1. **Check logs** - Backend terminal shows Spring Boot logs
2. **Check console** - Browser F12 Developer Tools
3. **Read documentation** - See docs/ folder
4. **Verify setup** - Follow SETUP.md again
5. **Check ports** - Ensure 8080 and 3000 are free

---

## 📞 Support Resources

- **API Docs:** `docs/API.md`
- **Setup Help:** `docs/SETUP.md`
- **Sample Data:** `docs/SAMPLE_DATA.md`
- **Architecture:** `docs/PROJECT_STRUCTURE.md`
- **Main Readme:** `README.md`

---

## 🎉 Ready to Go!

Your Employee Performance Monitoring System is ready!

### Next: Run These Commands

**Terminal 1 (Backend):**
```bash
cd employee-monitoring-system/backend
mvn spring-boot:run
```

**Terminal 2 (Frontend):**
```bash
cd employee-monitoring-system/frontend
npm install
npm start
```

**Browser Opens Automatically** to http://localhost:3000 ✨

---

**Happy coding!** 🚀

Questions? Check the documentation in the `docs/` folder!
