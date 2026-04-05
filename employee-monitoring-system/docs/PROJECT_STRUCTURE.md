# Project Structure Overview

Complete directory structure of the Employee Performance Monitoring System.

```
employee-monitoring-system/
│
├── backend/                                    # Spring Boot Backend
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/
│   │   │   │   └── com/example/employeemonitoring/
│   │   │   │       ├── EmployeeMonitoringSystemApplication.java    # Main Spring Boot class
│   │   │   │       ├── model/                                       # Data Models
│   │   │   │       │   ├── Employee.java                            # Employee entity
│   │   │   │       │   ├── PerformanceMetrics.java                  # Performance metrics entity
│   │   │   │       │   └── Admin.java                               # Admin model
│   │   │   │       ├── controller/                                  # REST Controllers
│   │   │   │       │   ├── EmployeeController.java                  # Employee endpoints
│   │   │   │       │   ├── PerformanceMetricsController.java        # Metrics endpoints
│   │   │   │       │   └── AdminAuthController.java                 # Authentication endpoints
│   │   │   │       ├── service/                                     # Business Logic
│   │   │   │       │   ├── EmployeeService.java                     # Employee operations
│   │   │   │       │   ├── PerformanceMetricsService.java           # Metrics operations
│   │   │   │       │   └── AdminService.java                        # Admin authentication
│   │   │   │       ├── repository/                                  # Database Access
│   │   │   │       │   ├── EmployeeRepository.java                  # Employee queries
│   │   │   │       │   └── PerformanceMetricsRepository.java        # Metrics queries
│   │   │   │       └── config/                                      # Configuration
│   │   │   └── resources/
│   │   │       └── application.properties                           # Spring Boot configuration
│   │   └── test/
│   │       └── java/com/example/employeemonitoring/
│   │           └── (test files)
│   ├── pom.xml                                # Maven dependencies and build configuration
│   └── .gitignore                             # Git ignore rules
│
├── frontend/                                  # React Frontend
│   ├── public/
│   │   ├── index.html                         # HTML entry point
│   │   ├── manifest.json                      # PWA manifest
│   │   └── favicon.ico                        # App icon
│   ├── src/
│   │   ├── pages/                             # Page Components
│   │   │   ├── Login.js                       # Admin login page
│   │   │   ├── AdminDashboard.js              # Admin dashboard with employee management
│   │   │   └── EmployeeDashboard.js           # Employee profile and metrics page
│   │   ├── components/                        # Reusable Components
│   │   │   └── PerformanceChart.js            # Chart.js visualization component
│   │   ├── services/                          # API Services
│   │   │   └── api.js                         # Axios API client and endpoints
│   │   ├── styles/                            # Stylesheets
│   │   │   └── index.css                      # Global styles
│   │   ├── App.js                             # Main App component with routing
│   │   └── index.js                           # React DOM rendering
│   ├── package.json                           # NPM dependencies
│   ├── .env.example                           # Environment variables template
│   ├── .gitignore                             # Git ignore rules
│   └── README.md                              # Frontend documentation
│
├── docs/                                      # Documentation
│   ├── SETUP.md                               # Installation and setup instructions
│   ├── API.md                                 # Complete API documentation
│   ├── SAMPLE_DATA.md                         # Sample data and test scenarios
│   └── PROJECT_STRUCTURE.md                   # This file
│
└── README.md                                  # Main project README
```

---

## Key Files Description

### Backend Files

#### Spring Boot Application
- **EmployeeMonitoringSystemApplication.java**
  - Entry point for the Spring Boot application
  - Configures CORS for React frontend
  - Sets up embedded H2 database

#### Models (Entities)
- **Employee.java**
  - Represents employee record with ID, name, department, position, email
  - JPA entity mapped to `employees` table

- **PerformanceMetrics.java**
  - Represents performance metrics with precision, recall, F1-score
  - Includes automatic F1-score calculation
  - Supports multiple evaluation periods

- **Admin.java**
  - Represents admin user for authentication
  - Contains credentials and role information

#### Controllers (REST Endpoints)
- **EmployeeController.java**
  - GET /employees - List all employees
  - GET /employees/{id} - Get employee by ID
  - POST /employees - Create employee
  - PUT /employees/{id} - Update employee
  - DELETE /employees/{id} - Delete employee

- **PerformanceMetricsController.java**
  - GET /metrics - List all metrics
  - GET /metrics/employee/{id} - Get employee metrics
  - POST /metrics - Create metrics
  - PUT /metrics/{id} - Update metrics
  - DELETE /metrics/{id} - Delete metrics

- **AdminAuthController.java**
  - POST /auth/login - Admin login
  - POST /auth/verify - Verify admin
  - GET /auth/health - Health check

#### Services (Business Logic)
- **EmployeeService.java** - Employee CRUD operations and validation
- **PerformanceMetricsService.java** - Metrics management and calculations
- **AdminService.java** - Admin authentication and verification

#### Repositories (Database Access)
- **EmployeeRepository.java** - JPA repository for employee queries
- **PerformanceMetricsRepository.java** - JPA repository for metrics queries

#### Configuration
- **application.properties** - Spring Boot configuration
  - Server port (8080)
  - H2 database settings
  - JPA/Hibernate configuration
  - Logging levels

---

### Frontend Files

#### Pages
- **Login.js**
  - Admin login form
  - Form validation and error handling
  - LocalStorage for session management
  - Demo credentials display

- **AdminDashboard.js**
  - Employee management interface
  - Add/delete employee functionality
  - Performance metrics summary table
  - Statistics cards
  - Logout functionality

- **EmployeeDashboard.js**
  - Employee search by ID
  - Personal profile display
  - Performance metrics visualization
  - Average metrics calculation
  - Performance trend charts

#### Components
- **PerformanceChart.js**
  - Line chart for performance trends
  - Bar chart for metrics comparison
  - Chart.js integration
  - Responsive chart sizing

#### Services
- **api.js**
  - Axios HTTP client setup
  - Employee API methods
  - Metrics API methods
  - Admin authentication methods
  - Base URL configuration from .env

#### Styles
- **index.css**
  - Global styles for all components
  - Responsive design with media queries
  - Custom CSS variables
  - Grid and flexbox layouts
  - Animation keyframes

#### App Configuration
- **App.js**
  - React Router setup
  - Route definitions
  - Authentication state management
  - Login session persistence
  - Protected routes

- **index.js**
  - ReactDOM rendering
  - App component initialization

#### Configuration Files
- **package.json** - NPM dependencies and scripts
- **.env.example** - Environment variables template
- **.gitignore** - Git ignore rules
- **public/index.html** - HTML template
- **public/manifest.json** - PWA configuration

---

## Database Schema

### EMPLOYEES Table
```sql
CREATE TABLE employees (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  employee_id VARCHAR(50) NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  department VARCHAR(100),
  position VARCHAR(100),
  email VARCHAR(255),
  created_date TIMESTAMP
);
```

### PERFORMANCE_METRICS Table
```sql
CREATE TABLE performance_metrics (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  employee_id BIGINT NOT NULL,
  precision DOUBLE,
  recall DOUBLE,
  f1_score DOUBLE,
  accuracy DOUBLE,
  category VARCHAR(100),
  period VARCHAR(50),
  evaluation_date DATE,
  FOREIGN KEY (employee_id) REFERENCES employees(id)
);
```

---

## API Endpoints Map

### Employee Management
```
POST   /api/employees              - Create employee
GET    /api/employees              - List all employees
GET    /api/employees/{id}         - Get by ID
PUT    /api/employees/{id}         - Update employee
DELETE /api/employees/{id}         - Delete employee
GET    /api/employees/count/total  - Get count
```

### Performance Metrics
```
POST   /api/metrics                                - Create metrics
GET    /api/metrics                                - List all metrics
GET    /api/metrics/{id}                           - Get by ID
GET    /api/metrics/employee/{id}                  - Get for employee
GET    /api/metrics/employee/{id}/latest           - Get latest
GET    /api/metrics/employee/{id}/average          - Get average
PUT    /api/metrics/{id}                           - Update metrics
DELETE /api/metrics/{id}                           - Delete metrics
GET    /api/metrics/category/{category}            - Get by category
```

### Authentication
```
POST /api/auth/login       - Admin login
POST /api/auth/verify      - Verify admin
GET  /api/auth/health      - Health check
```

---

## Client-Side Routes

```
/                  - Redirect to /employee
/login             - Admin login page
/admin             - Admin dashboard (protected)
/employee          - Employee dashboard (public)
*                  - Catch-all, redirect to /employee
```

---

## Technology Stack

### Backend
| Technology | Version | Purpose |
|-----------|---------|---------|
| Spring Boot | 3.1.5 | Web framework |
| Java | 17+ | Programming language |
| Maven | 3.8.1+ | Build tool |
| H2 | Latest | In-memory database |
| JPA/Hibernate | Latest | ORM |
| Lombok | Latest | Boilerplate reduction |

### Frontend
| Technology | Version | Purpose |
|-----------|---------|---------|
| React | 18.2 | UI library |
| React Router | 6.18 | Navigation |
| Axios | 1.6 | HTTP client |
| Chart.js | 4.4 | Charts library |
| React ChartJS2 | 5.2 | React wrapper |

---

## Feature Implementations

### Admin Dashboard Features
1. **Authentication**
   - Login with username/password
   - Session management
   - Logout functionality

2. **Employee Management**
   - View all employees
   - Add new employee
   - Delete employee
   - Search functionality

3. **Analytics**
   - Employee count
   - Performance metrics overview
   - Metrics by category

### Employee Dashboard Features
1. **Profile Management**
   - Search by Employee ID
   - View personal information
   - View department and position

2. **Performance Tracking**
   - View all personal metrics
   - See performance trends
   - Calculate averages
   - Visualize with charts

3. **Visualization**
   - Line chart for trends
   - Bar chart for comparison
   - Metric cards for summary

---

## Security Features

- CORS configuration for frontend
- Input validation on API endpoints
- Protected admin routes
- Session-based authentication
- Error handling and logging

---

## Performance Considerations

- In-memory H2 database (fast for development)
- Pagination-ready APIs
- Responsive UI design
- Efficient React component rendering
- Chart caching and optimization

---

## Future Enhancements

- Firebase integration
- JWT authentication
- User roles and permissions
- Email notifications
- Data export (PDF/CSV)
- Advanced filtering
- Real-time updates with WebSockets
- Mobile app version
- Performance dashboards
- Employee reviews

---

**Project Structure Overview Complete!** 🎉

For detailed instructions, see:
- [SETUP.md](./SETUP.md) - Installation guide
- [API.md](./API.md) - API documentation
- [SAMPLE_DATA.md](./SAMPLE_DATA.md) - Test data
