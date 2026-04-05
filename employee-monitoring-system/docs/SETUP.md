# Setup Instructions

Complete step-by-step guide to set up and run the Employee Performance Monitoring System.

## Prerequisites

Before starting, ensure you have the following installed:

### System Requirements
- **OS:** Windows, macOS, or Linux
- **RAM:** Minimum 4GB (8GB recommended)
- **Disk Space:** 2GB for all dependencies

### Required Software
- **Java Development Kit (JDK):**
  - Version: 17 or higher
  - Download: https://www.oracle.com/java/technologies/downloads/
  - Verify: `java -version`

- **Node.js and npm:**
  - Version: Node.js 16+ and npm 8+
  - Download: https://nodejs.org/
  - Verify: `node --version` and `npm --version`

- **Maven:**
  - Version: 3.8.1 or higher
  - Download: https://maven.apache.org/download.cgi
  - Verify: `mvn --version`

- **Git (Optional):**
  - Download: https://git-scm.com/

---

## Step 1: Backend Setup (Spring Boot)

### 1.1 Navigate to Backend Directory
```bash
cd employee-monitoring-system/backend
```

### 1.2 Clean and Install Dependencies
```bash
mvn clean install
```

This will download all required dependencies (may take 2-5 minutes on first run).

### 1.3 Run the Spring Boot Application
```bash
mvn spring-boot:run
```

Or build and run JAR:
```bash
mvn clean package
java -jar target/employee-monitoring-system-1.0.0.jar
```

### 1.4 Verify Backend is Running
Open your browser and visit:
- **API Status:** http://localhost:8080/api/auth/health
- **H2 Database Console:** http://localhost:8080/h2-console

Expected output in H2 Console:
- **JDBC URL:** jdbc:h2:mem:testdb
- **Username:** sa
- **Password:** (leave blank)

---

## Step 2: Frontend Setup (React)

### 2.1 Open New Terminal Window

Keep the backend running and open a new terminal.

### 2.2 Navigate to Frontend Directory
```bash
cd employee-monitoring-system/frontend
```

### 2.3 Install Dependencies
```bash
npm install
```

This will install all React dependencies (may take 3-5 minutes on first run).

### 2.4 Create Environment File
```bash
cp .env.example .env
```

Or create `.env` file manually:
```
REACT_APP_API_URL=http://localhost:8080/api
```

### 2.5 Start React Development Server
```bash
npm start
```

The application will automatically open in your default browser at `http://localhost:3000`

---

## Step 3: Verify Installation

### Check Backend
1. Open terminal showing backend logs
2. Look for message: `Started EmployeeMonitoringSystemApplication in X seconds`

### Check Frontend
1. Check browser console (F12 → Console)
2. Should see no errors related to API connection

### Test Login
1. Navigate to http://localhost:3000/login or http://localhost:3000/admin
2. Enter credentials:
   - **Username:** admin
   - **Password:** admin123
3. Should successfully login and see Admin Dashboard

### Test Employee Dashboard
1. Navigate to http://localhost:3000/employee
2. Enter an Employee ID: `EMP001`
3. Click Search
4. Should display employee information

---

## Step 4: Load Sample Data

### Option 1: Using H2 Console (GUI)

1. Open http://localhost:8080/h2-console
2. Login with default credentials (username: sa, password: empty)
3. Run SQL commands from [SAMPLE_DATA.md](./SAMPLE_DATA.md)

### Option 2: Using API Calls

Use cURL or Postman to add sample data:

**Add Employee:**
```bash
curl -X POST http://localhost:8080/api/employees \
  -H "Content-Type: application/json" \
  -d '{
    "employeeId": "EMP001",
    "name": "John Doe",
    "department": "Engineering",
    "position": "Senior Developer",
    "email": "john.doe@example.com"
  }'
```

**Add Performance Metrics:**
```bash
curl -X POST http://localhost:8080/api/metrics \
  -H "Content-Type: application/json" \
  -d '{
    "employeeId": 1,
    "precision": 0.95,
    "recall": 0.92,
    "accuracy": 0.94,
    "category": "Code Quality",
    "period": "Q1 2024"
  }'
```

---

## Step 5: Project Navigation

### Admin Dashboard
- **URL:** http://localhost:3000/admin
- **Login:** admin / admin123
- **Features:**
  - View all employees
  - Add new employees
  - Delete employees
  - View performance metrics

### Employee Dashboard
- **URL:** http://localhost:3000/employee
- **Features:**
  - Search by Employee ID
  - View personal profile
  - View performance metrics
  - See performance trends with charts

---

## Troubleshooting

### Issue: "Port 8080 already in use"

**Solution:**
1. Find the process using port 8080:
   ```bash
   # Windows
   netstat -ano | findstr :8080
   
   # macOS/Linux
   lsof -i :8080
   ```

2. Kill the process or change port in `backend/src/main/resources/application.properties`:
   ```properties
   server.port=8081
   ```

### Issue: "Port 3000 already in use"

**Solution:**
```bash
PORT=3001 npm start
```

Then update frontend `.env`:
```
REACT_APP_API_URL=http://localhost:8080/api
```

### Issue: "Maven command not found"

**Solution:**
1. Verify Maven is installed: `mvn --version`
2. If not installed, download from: https://maven.apache.org/download.cgi
3. Add Maven to PATH environment variable

### Issue: "npm ERR! code ERESOLVE"

**Solution:**
```bash
npm install --legacy-peer-deps
```

### Issue: "Cannot GET /api/employees"

**Solution:**
1. Ensure backend is running on port 8080
2. Check http://localhost:8080/api/auth/health
3. Verify CORS is enabled in backend

### Issue: React app shows blank page

**Solution:**
1. Open browser console (F12)
2. Check for errors
3. Clear browser cache: Ctrl+Shift+Delete
4. Restart development server: `npm start`

### Issue: Database connection error

**Solution:**
1. Ensure backend is running
2. Check H2 console at http://localhost:8080/h2-console
3. Verify database settings in `application.properties`

---

## Port Configuration

Default ports used by the application:

| Service | Port | URL |
|---------|------|-----|
| Spring Boot Backend | 8080 | http://localhost:8080 |
| React Frontend | 3000 | http://localhost:3000 |
| H2 Database Console | 8080 | http://localhost:8080/h2-console |

To change ports:

**Backend (Spring Boot):**
Edit `backend/src/main/resources/application.properties`:
```properties
server.port=8081
```

**Frontend (React):**
```bash
PORT=3001 npm start
```

---

## Development Tools

### Useful Chrome Extensions
- **React Developer Tools:** Inspect React component hierarchy
- **Postman:** Test API endpoints

### IDE Recommendations
- **Backend:** IntelliJ IDEA Community, VS Code with Java extensions
- **Frontend:** VS Code, WebStorm

### Database Tools
- **H2 Console:** Built-in at http://localhost:8080/h2-console
- **DBeaver:** Third-party database management tool

---

## Building for Production

### Build Backend
```bash
cd backend
mvn clean package
# JAR will be created at: backend/target/employee-monitoring-system-1.0.0.jar
```

### Build Frontend
```bash
cd frontend
npm run build
# Build files will be created at: frontend/build/
```

---

## Environment Variables

### Backend
Create `backend/src/main/resources/application-prod.properties`:
```properties
server.port=8080
spring.jpa.hibernate.ddl-auto=validate
logging.level.root=WARN
```

Run with profile:
```bash
java -Dspring.profiles.active=prod -jar target/employee-monitoring-system-1.0.0.jar
```

### Frontend
Create `frontend/.env.production`:
```
REACT_APP_API_URL=https://api.example.com
```

Build for production:
```bash
npm run build
```

---

## Firebase Integration (Optional)

To connect Firebase instead of H2 database:

1. Create Firebase project at https://firebase.google.com
2. Download service account key
3. Update `application.properties`:
   ```properties
   firebase.project-id=your-project-id
   firebase.database-url=https://your-project.firebaseio.com
   ```
4. Add Firebase credentials to your deployment

---

## Next Steps

1. **Load Sample Data:** Follow [SAMPLE_DATA.md](./SAMPLE_DATA.md)
2. **Explore API:** See [API.md](./API.md)
3. **Customize:** Modify styles, add more features, integrate with your database
4. **Deploy:** Follow production build steps above

---

## Support

For issues:
1. Check logs in terminal
2. Open browser console (F12)
3. Review API.md documentation
4. Check backend logs for errors

---

**Setup completed!** 🎉

The application is now ready to use. Access it at:
- **Admin Dashboard:** http://localhost:3000/admin
- **Employee Dashboard:** http://localhost:3000/employee
