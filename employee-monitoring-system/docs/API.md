# API Documentation

Complete API documentation for the Employee Performance Monitoring System.

## Base URL
```
http://localhost:8080/api
```

## Authentication
Admin login required for accessing admin endpoints. Use the `/auth/login` endpoint to authenticate.

---

## Employee Management APIs

### 1. Get All Employees
**Endpoint:** `GET /employees`

**Description:** Retrieve a list of all employees

**Response:**
```json
[
  {
    "id": 1,
    "employeeId": "EMP001",
    "name": "John Doe",
    "department": "Engineering",
    "position": "Senior Developer",
    "email": "john.doe@example.com",
    "createdDate": "2024-01-10T10:30:00"
  }
]
```

**Status Code:** 200 OK

---

### 2. Get Employee by ID
**Endpoint:** `GET /employees/{id}`

**Parameters:**
- `id` (path parameter): Employee database ID

**Response:**
```json
{
  "id": 1,
  "employeeId": "EMP001",
  "name": "John Doe",
  "department": "Engineering",
  "position": "Senior Developer",
  "email": "john.doe@example.com",
  "createdDate": "2024-01-10T10:30:00"
}
```

**Status Code:** 200 OK / 404 Not Found

---

### 3. Get Employee by Employee ID
**Endpoint:** `GET /employees/by-employee-id/{employeeId}`

**Parameters:**
- `employeeId` (path parameter): Custom employee ID (e.g., EMP001)

**Response:**
```json
{
  "id": 1,
  "employeeId": "EMP001",
  "name": "John Doe",
  "department": "Engineering",
  "position": "Senior Developer",
  "email": "john.doe@example.com",
  "createdDate": "2024-01-10T10:30:00"
}
```

**Status Code:** 200 OK / 404 Not Found

---

### 4. Create Employee
**Endpoint:** `POST /employees`

**Request Body:**
```json
{
  "employeeId": "EMP004",
  "name": "Sarah Williams",
  "department": "Sales",
  "position": "Sales Manager",
  "email": "sarah.williams@example.com"
}
```

**Response:**
```json
{
  "id": 4,
  "employeeId": "EMP004",
  "name": "Sarah Williams",
  "department": "Sales",
  "position": "Sales Manager",
  "email": "sarah.williams@example.com",
  "createdDate": "2024-04-05T15:45:00"
}
```

**Status Code:** 201 Created

---

### 5. Update Employee
**Endpoint:** `PUT /employees/{id}`

**Parameters:**
- `id` (path parameter): Employee database ID

**Request Body:**
```json
{
  "department": "Marketing",
  "position": "Marketing Lead",
  "email": "sarah.new@example.com"
}
```

**Response:**
```json
{
  "id": 4,
  "employeeId": "EMP004",
  "name": "Sarah Williams",
  "department": "Marketing",
  "position": "Marketing Lead",
  "email": "sarah.new@example.com",
  "createdDate": "2024-04-05T15:45:00"
}
```

**Status Code:** 200 OK

---

### 6. Delete Employee
**Endpoint:** `DELETE /employees/{id}`

**Parameters:**
- `id` (path parameter): Employee database ID

**Response:**
```json
{
  "message": "Employee deleted successfully"
}
```

**Status Code:** 200 OK / 404 Not Found

---

### 7. Get Employee Count
**Endpoint:** `GET /employees/count/total`

**Response:**
```json
{
  "count": 3
}
```

**Status Code:** 200 OK

---

## Performance Metrics APIs

### 1. Get All Metrics
**Endpoint:** `GET /metrics`

**Description:** Retrieve all performance metrics

**Response:**
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
  }
]
```

**Status Code:** 200 OK

---

### 2. Get Metrics by ID
**Endpoint:** `GET /metrics/{id}`

**Parameters:**
- `id` (path parameter): Metrics database ID

**Response:**
```json
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
}
```

**Status Code:** 200 OK / 404 Not Found

---

### 3. Get Metrics by Employee ID
**Endpoint:** `GET /metrics/employee/{employeeId}`

**Parameters:**
- `employeeId` (path parameter): Employee database ID

**Response:**
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

**Status Code:** 200 OK

---

### 4. Get Latest Metrics for Employee
**Endpoint:** `GET /metrics/employee/{employeeId}/latest`

**Parameters:**
- `employeeId` (path parameter): Employee database ID

**Response:**
```json
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
```

**Status Code:** 200 OK / 404 Not Found

---

### 5. Get Average Metrics for Employee
**Endpoint:** `GET /metrics/employee/{employeeId}/average`

**Parameters:**
- `employeeId` (path parameter): Employee database ID

**Response:**
```json
{
  "avgPrecision": 0.94,
  "avgRecall": 0.935,
  "avgF1Score": 0.9375
}
```

**Status Code:** 200 OK

---

### 6. Create Performance Metrics
**Endpoint:** `POST /metrics`

**Request Body:**
```json
{
  "employeeId": 1,
  "precision": 0.96,
  "recall": 0.94,
  "accuracy": 0.95,
  "category": "Development",
  "period": "Q3 2024"
}
```

**Response:**
```json
{
  "id": 3,
  "employeeId": 1,
  "precision": 0.96,
  "recall": 0.94,
  "f1Score": 0.95,
  "accuracy": 0.95,
  "category": "Development",
  "period": "Q3 2024",
  "evaluationDate": "2024-04-05"
}
```

**Status Code:** 201 Created

---

### 7. Update Performance Metrics
**Endpoint:** `PUT /metrics/{id}`

**Parameters:**
- `id` (path parameter): Metrics database ID

**Request Body:**
```json
{
  "precision": 0.97,
  "recall": 0.95,
  "accuracy": 0.96,
  "category": "Testing"
}
```

**Response:**
```json
{
  "id": 3,
  "employeeId": 1,
  "precision": 0.97,
  "recall": 0.95,
  "f1Score": 0.96,
  "accuracy": 0.96,
  "category": "Testing",
  "period": "Q3 2024",
  "evaluationDate": "2024-04-05"
}
```

**Status Code:** 200 OK

---

### 8. Delete Performance Metrics
**Endpoint:** `DELETE /metrics/{id}`

**Parameters:**
- `id` (path parameter): Metrics database ID

**Response:**
```json
{
  "message": "Metrics deleted successfully"
}
```

**Status Code:** 200 OK / 404 Not Found

---

### 9. Get Metrics by Category
**Endpoint:** `GET /metrics/category/{category}`

**Parameters:**
- `category` (path parameter): Performance category (e.g., "Code Quality", "Productivity")

**Response:**
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
  }
]
```

**Status Code:** 200 OK

---

## Authentication APIs

### 1. Admin Login
**Endpoint:** `POST /auth/login`

**Request Body:**
```json
{
  "username": "admin",
  "password": "admin123"
}
```

**Response (Success):**
```json
{
  "success": true,
  "adminId": "ADMIN001",
  "username": "admin",
  "email": "admin@example.com",
  "role": "ADMIN",
  "message": "Login successful"
}
```

**Response (Failure):**
```json
{
  "success": false,
  "message": "Invalid username or password"
}
```

**Status Code:** 200 OK / 401 Unauthorized

---

### 2. Verify Admin
**Endpoint:** `POST /auth/verify`

**Request Body:**
```json
{
  "username": "admin"
}
```

**Response:**
```json
{
  "isAdmin": true,
  "username": "admin"
}
```

**Status Code:** 200 OK

---

### 3. Health Check
**Endpoint:** `GET /auth/health`

**Response:**
```json
{
  "status": "OK",
  "message": "Authentication service is running"
}
```

**Status Code:** 200 OK

---

## Error Handling

### Common Error Responses

**400 Bad Request:**
```json
{
  "error": "Employee name is required"
}
```

**404 Not Found:**
```json
{
  "error": "Employee not found with id: 999"
}
```

**500 Internal Server Error:**
```json
{
  "error": "Error fetching employees: [error details]"
}
```

---

## Error Codes

| Code | Meaning |
|------|---------|
| 200 | OK |
| 201 | Created |
| 400 | Bad Request |
| 401 | Unauthorized |
| 404 | Not Found |
| 500 | Internal Server Error |

---

## Rate Limiting

No rate limiting is currently implemented. For production use, consider adding rate limiting.

---

## CORS

CORS is enabled for:
- `http://localhost:3000`
- `http://localhost:3001`

To add more origins, update the `corsConfigurer()` method in `EmployeeMonitoringSystemApplication.java`.

---

## Examples Using cURL

### Get all employees
```bash
curl -X GET http://localhost:8080/api/employees
```

### Create new employee
```bash
curl -X POST http://localhost:8080/api/employees \
  -H "Content-Type: application/json" \
  -d '{
    "employeeId": "EMP004",
    "name": "Sarah Williams",
    "department": "Sales",
    "position": "Sales Manager",
    "email": "sarah.williams@example.com"
  }'
```

### Login as admin
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin",
    "password": "admin123"
  }'
```

### Get metrics for employee
```bash
curl -X GET http://localhost:8080/api/metrics/employee/1
```

---

**Last Updated:** 2024-04-05
