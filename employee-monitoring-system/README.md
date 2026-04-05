# Employee Performance Monitoring System

A full-stack web application for monitoring and managing employee performance metrics. Built with Spring Boot, React.js, and Firebase.

## Features

### Admin Dashboard
- Admin authentication with login credentials
- View all employees in a table format
- Add new employees (with Employee ID and Name)
- Delete employees from the system
- View performance metrics for all employees
- Summary statistics and metrics overview

### Employee Dashboard
- View personal profile information
- Search employees by Employee ID
- View personal performance metrics
- Display performance trends with charts
- Detailed metrics breakdown (Precision, Recall, F1 Score, Accuracy)

### Performance Monitoring
- Track Precision, Recall, and F1-Score
- View performance trends over time
- Category-based performance tracking
- Average performance calculations
- Visual charts and graphs

## Project Structure

```
employee-monitoring-system/
├── backend/                    # Spring Boot Backend
│   ├── src/main/
│   │   ├── java/
│   │   │   └── com/example/employeemonitoring/
│   │   │       ├── model/
│   │   │       │   ├── Employee.java
│   │   │       │   ├── PerformanceMetrics.java
│   │   │       │   └── Admin.java
│   │   │       ├── controller/
│   │   │       │   ├── EmployeeController.java
│   │   │       │   ├── PerformanceMetricsController.java
│   │   │       │   └── AdminAuthController.java
│   │   │       ├── service/
│   │   │       │   ├── EmployeeService.java
│   │   │       │   ├── PerformanceMetricsService.java
│   │   │       │   └── AdminService.java
│   │   │       ├── repository/
│   │   │       │   ├── EmployeeRepository.java
│   │   │       │   └── PerformanceMetricsRepository.java
│   │   │       └── EmployeeMonitoringSystemApplication.java
│   │   └── resources/
│   │       └── application.properties
│   └── pom.xml
├── frontend/                   # React Frontend
│   ├── public/
│   │   ├── index.html
│   │   └── manifest.json
│   ├── src/
│   │   ├── pages/
│   │   │   ├── Login.js
│   │   │   ├── AdminDashboard.js
│   │   │   └── EmployeeDashboard.js
│   │   ├── components/
│   │   │   └── PerformanceChart.js
│   │   ├── services/
│   │   │   └── api.js
│   │   ├── styles/
│   │   │   └── index.css
│   │   ├── App.js
│   │   └── index.js
│   ├── package.json
│   └── .env.example
└── docs/
    ├── SETUP.md
    ├── API.md
    └── SAMPLE_DATA.md
```

## Prerequisites

- **Java 17+** (for Spring Boot)
- **Node.js 16+** (for React)
- **npm** or **yarn** (for package management)
- **Maven** (for building Spring Boot)
- Optional: **Firebase Account** (for cloud database integration)

## 🚀 Quick Start (Windows)

### **Step 1: Check Your Setup**
```cmd
# Run the setup checker
check-setup.bat
```

This will tell you which tools are missing and need to be installed.

### **Step 2: Test with Mock Backend (Optional)**
If you want to test the frontend immediately while installing Java/Maven:

```cmd
# Install mock backend dependencies
npm install express cors

# Start mock backend
node mock-backend.js
```

### **Step 3: Install Missing Tools**
If any tools are missing, see: **[FIX-ERRORS.md](FIX-ERRORS.md)** for detailed installation instructions.

### **Step 4: Start Everything**
```cmd
# Start both backend and frontend automatically
start-all.bat
```

**Or start manually:**
```cmd
# Terminal 1 - Backend
start-backend.bat

# Terminal 2 - Frontend (after backend starts)
start-frontend.bat
```

### **Step 5: Access the Application**
- **Desktop:** http://localhost:3000
- **Mobile (Pixel 4XL):** http://172.20.10.3:3000
- **Admin Login:** admin / admin123

---

## 📋 Manual Installation & Setup

### Backend Setup (Spring Boot)

1. **Navigate to backend directory:**
   ```bash
   cd backend
   ```

2. **Install Maven dependencies:**
   ```bash
   mvn clean install
   ```

3. **Run the Spring Boot application:**
   ```bash
   mvn spring-boot:run
   ```

   The backend will start on `http://localhost:8080`

4. **Access the H2 Database Console (optional):**
   - Visit: `http://localhost:8080/h2-console`
   - JDBC URL: `jdbc:h2:mem:testdb`
   - Username: `sa`
   - Password: (leave blank)

### Frontend Setup (React)

1. **Navigate to frontend directory:**
   ```bash
   cd frontend
   ```

2. **Install dependencies:**
   ```bash
   npm install --legacy-peer-deps
   ```

3. **Create `.env` file:**
   ```bash
   cp .env.example .env
   ```

4. **Update `.env` if needed:**
   ```
   REACT_APP_API_URL=http://localhost:8080/api
   ```

5. **Start the React development server:**
   ```bash
   npm start
   ```

   The frontend will open at `http://localhost:3000`

## 🔧 Troubleshooting

### **Application Won't Start**
1. **Run the setup checker:** `check-setup.bat`
2. **Check for missing tools:** See [FIX-ERRORS.md](FIX-ERRORS.md)
3. **Common issues:**
   - Java not installed → Install Java 17
   - Maven not in PATH → Add Maven to system PATH
   - Node.js too old → Update to Node.js 16+

### **Backend Build Fails**
```bash
# Clean and rebuild
cd backend
mvn clean package -DskipTests
```

### **Frontend Dependencies Fail**
```bash
# Force install with legacy peer deps
cd frontend
npm install --legacy-peer-deps --force
```

### **Mobile Access Issues**
- Make sure both servers are running
- Use IP: `http://172.20.10.3:3000`
- Check firewall settings
- Ensure devices are on same network

### **Database Issues**
- H2 Console: `http://localhost:8080/h2-console`
- JDBC URL: `jdbc:h2:mem:testdb`
- Username: `sa`, Password: (blank)

---

## 📱 Mobile Deployment

The application is configured for mobile access on Pixel 4XL:

1. **Start the application** using the batch files
2. **Connect your Pixel 4XL** to the same WiFi network
3. **Open browser** on phone and go to: `http://172.20.10.3:3000`
4. **Login** with admin credentials: `admin` / `admin123`

**Note:** The IP address `172.20.10.3` is your computer's local IP. If this changes, update the CORS configuration in the backend.
   - **Password:** `admin123`
3. View and manage employees
4. Add new employees with details
5. Delete employees as needed
6. View performance metrics

### Employee Dashboard
1. Go to `http://localhost:3000/employee`
2. Enter your Employee ID (e.g., `EMP001`)
3. View your profile information
4. See performance metrics and trends
5. Analyze performance charts

## API Endpoints

### Employee APIs
- `GET /api/employees` - Get all employees
- `GET /api/employees/{id}` - Get employee by ID
- `POST /api/employees` - Create new employee
- `PUT /api/employees/{id}` - Update employee
- `DELETE /api/employees/{id}` - Delete employee

### Performance Metrics APIs
- `GET /api/metrics` - Get all metrics
- `GET /api/metrics/employee/{employeeId}` - Get metrics for employee
- `GET /api/metrics/employee/{employeeId}/latest` - Get latest metrics
- `GET /api/metrics/employee/{employeeId}/average` - Get average metrics
- `POST /api/metrics` - Create new metrics
- `PUT /api/metrics/{id}` - Update metrics
- `DELETE /api/metrics/{id}` - Delete metrics

### Admin Authentication APIs
- `POST /api/auth/login` - Login admin
- `POST /api/auth/verify` - Verify admin
- `GET /api/auth/health` - Health check

## Sample Data

### Default Admin User
```json
{
  "adminId": "ADMIN001",
  "username": "admin",
  "password": "admin123",
  "email": "admin@example.com",
  "role": "ADMIN"
}
```

### Sample Employees
```json
[
  {
    "id": 1,
    "employeeId": "EMP001",
    "name": "John Doe",
    "department": "Engineering",
    "position": "Senior Developer",
    "email": "john.doe@example.com"
  },
  {
    "id": 2,
    "employeeId": "EMP002",
    "name": "Jane Smith",
    "department": "Product",
    "position": "Product Manager",
    "email": "jane.smith@example.com"
  },
  {
    "id": 3,
    "employeeId": "EMP003",
    "name": "Mike Johnson",
    "department": "Engineering",
    "position": "QA Engineer",
    "email": "mike.johnson@example.com"
  }
]
```

### Sample Performance Metrics
```json
[
  {
    "id": 1,
    "employeeId": 1,
    "precision": 0.95,
    "recall": 0.92,
    "f1Score": 0.935,
    "accuracy": 0.94,
    "category": "Code Quality",
    "period": "Q1 2024",
    "evaluationDate": "2024-01-15"
  },
  {
    "id": 2,
    "employeeId": 1,
    "precision": 0.93,
    "recall": 0.95,
    "f1Score": 0.94,
    "accuracy": 0.93,
    "category": "Productivity",
    "period": "Q2 2024",
    "evaluationDate": "2024-04-15"
  }
]
```

## Firebase Integration

To integrate with Firebase:

1. **Create a Firebase project** at https://firebase.google.com

2. **Add Firebase dependencies** to `pom.xml`:
   ```xml
   <dependency>
     <groupId>com.google.firebase</groupId>
     <artifactId>firebase-admin</artifactId>
     <version>9.1.1</version>
   </dependency>
   ```

3. **Configure Firebase** in `application.properties`:
   ```properties
   firebase.project-id=YOUR_PROJECT_ID
   firebase.database-url=YOUR_DATABASE_URL
   firebase.api-key=YOUR_API_KEY
   ```

4. **Download service account key** from Firebase Console and add to project

## Technology Stack

### Backend
- **Framework:** Spring Boot 3.1.5
- **Language:** Java 17
- **Database:** H2 (local), Firebase (optional)
- **Build Tool:** Maven

### Frontend
- **Library:** React 18.2
- **Router:** React Router 6.18
- **HTTP Client:** Axios 1.6
- **Charts:** Chart.js 4.4 + React ChartJS2

### Features
- RESTful API architecture
- JWT Authentication ready
- CORS enabled for cross-origin requests
- Responsive UI design
- Real-time performance tracking

## Testing

### Test Login Credentials
```
Username: admin
Password: admin123
```

### Test Employee IDs
- EMP001
- EMP002
- EMP003

## Troubleshooting

### Backend Issues
1. **Port 8080 already in use:**
   ```bash
   # Change port in application.properties
   server.port=8081
   ```

2. **Maven build fails:**
   ```bash
   mvn clean install -DskipTests
   ```

### Frontend Issues
1. **Port 3000 already in use:**
   ```bash
   PORT=3001 npm start
   ```

2. **API connection error:**
   - Check if backend is running on `http://localhost:8080`
   - Update `REACT_APP_API_URL` in `.env`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see LICENSE file for details.

## Support

For issues and questions, please create an issue in the repository.

---

**Created:** 2024
**Last Updated:** 2024
**Version:** 1.0.0
