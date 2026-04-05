# Sample Data

SQL and API commands to populate the application with sample data.

## Option 1: Using H2 Database Console

Access at: `http://localhost:8080/h2-console`

### Create Sample Employees

```sql
-- Insert sample employees
INSERT INTO employees (employee_id, name, department, position, email, created_date) VALUES
  ('EMP001', 'John Doe', 'Engineering', 'Senior Developer', 'john.doe@example.com', '2024-01-10'),
  ('EMP002', 'Jane Smith', 'Product', 'Product Manager', 'jane.smith@example.com', '2024-01-15'),
  ('EMP003', 'Mike Johnson', 'Engineering', 'QA Engineer', 'mike.johnson@example.com', '2024-01-12'),
  ('EMP004', 'Sarah Williams', 'Marketing', 'Marketing Manager', 'sarah.williams@example.com', '2024-02-01'),
  ('EMP005', 'Robert Brown', 'Sales', 'Sales Executive', 'robert.brown@example.com', '2024-02-05'),
  ('EMP006', 'Emily Davis', 'Engineering', 'Junior Developer', 'emily.davis@example.com', '2024-02-10');
```

### Create Sample Performance Metrics

```sql
-- Insert performance metrics for employees
INSERT INTO performance_metrics (employee_id, precision, recall, f1_score, accuracy, category, period, evaluation_date) VALUES
  -- John Doe (EMP001) metrics
  (1, 0.95, 0.92, 0.935, 0.94, 'Code Quality', 'Q1 2024', '2024-01-15'),
  (1, 0.93, 0.95, 0.94, 0.93, 'Productivity', 'Q1 2024', '2024-01-20'),
  (1, 0.96, 0.94, 0.95, 0.95, 'Development', 'Q2 2024', '2024-04-15'),
  
  -- Jane Smith (EMP002) metrics
  (2, 0.92, 0.90, 0.91, 0.91, 'Planning', 'Q1 2024', '2024-01-25'),
  (2, 0.94, 0.93, 0.935, 0.94, 'Execution', 'Q2 2024', '2024-04-20'),
  
  -- Mike Johnson (EMP003) metrics
  (3, 0.97, 0.96, 0.965, 0.97, 'Testing', 'Q1 2024', '2024-01-18'),
  (3, 0.98, 0.97, 0.975, 0.98, 'Quality Assurance', 'Q2 2024', '2024-04-18'),
  
  -- Sarah Williams (EMP004) metrics
  (4, 0.89, 0.88, 0.885, 0.88, 'Marketing', 'Q1 2024', '2024-02-14'),
  (4, 0.91, 0.90, 0.905, 0.90, 'Campaign Planning', 'Q2 2024', '2024-04-25'),
  
  -- Robert Brown (EMP005) metrics
  (5, 0.85, 0.87, 0.86, 0.86, 'Sales', 'Q1 2024', '2024-02-20'),
  (5, 0.88, 0.89, 0.885, 0.88, 'Client Relations', 'Q2 2024', '2024-04-22'),
  
  -- Emily Davis (EMP006) metrics
  (6, 0.90, 0.89, 0.895, 0.89, 'Development', 'Q1 2024', '2024-02-25'),
  (6, 0.92, 0.91, 0.915, 0.91, 'Learning', 'Q2 2024', '2024-04-28');
```

### Verify Data

```sql
-- View all employees
SELECT * FROM employees;

-- View all performance metrics
SELECT * FROM performance_metrics;

-- View metrics for specific employee
SELECT * FROM performance_metrics WHERE employee_id = 1;

-- Count total records
SELECT COUNT(*) as total_employees FROM employees;
SELECT COUNT(*) as total_metrics FROM performance_metrics;
```

---

## Option 2: Using API Calls with cURL

### Add Employees via API

**Employee 1:**
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

**Employee 2:**
```bash
curl -X POST http://localhost:8080/api/employees \
  -H "Content-Type: application/json" \
  -d '{
    "employeeId": "EMP002",
    "name": "Jane Smith",
    "department": "Product",
    "position": "Product Manager",
    "email": "jane.smith@example.com"
  }'
```

**Employee 3:**
```bash
curl -X POST http://localhost:8080/api/employees \
  -H "Content-Type: application/json" \
  -d '{
    "employeeId": "EMP003",
    "name": "Mike Johnson",
    "department": "Engineering",
    "position": "QA Engineer",
    "email": "mike.johnson@example.com"
  }'
```

**Employee 4:**
```bash
curl -X POST http://localhost:8080/api/employees \
  -H "Content-Type: application/json" \
  -d '{
    "employeeId": "EMP004",
    "name": "Sarah Williams",
    "department": "Marketing",
    "position": "Marketing Manager",
    "email": "sarah.williams@example.com"
  }'
```

**Employee 5:**
```bash
curl -X POST http://localhost:8080/api/employees \
  -H "Content-Type: application/json" \
  -d '{
    "employeeId": "EMP005",
    "name": "Robert Brown",
    "department": "Sales",
    "position": "Sales Executive",
    "email": "robert.brown@example.com"
  }'
```

**Employee 6:**
```bash
curl -X POST http://localhost:8080/api/employees \
  -H "Content-Type: application/json" \
  -d '{
    "employeeId": "EMP006",
    "name": "Emily Davis",
    "department": "Engineering",
    "position": "Junior Developer",
    "email": "emily.davis@example.com"
  }'
```

### Add Performance Metrics via API

**Metrics for John Doe (Employee ID: 1):**
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

curl -X POST http://localhost:8080/api/metrics \
  -H "Content-Type: application/json" \
  -d '{
    "employeeId": 1,
    "precision": 0.93,
    "recall": 0.95,
    "accuracy": 0.93,
    "category": "Productivity",
    "period": "Q1 2024"
  }'

curl -X POST http://localhost:8080/api/metrics \
  -H "Content-Type: application/json" \
  -d '{
    "employeeId": 1,
    "precision": 0.96,
    "recall": 0.94,
    "accuracy": 0.95,
    "category": "Development",
    "period": "Q2 2024"
  }'
```

**Metrics for Jane Smith (Employee ID: 2):**
```bash
curl -X POST http://localhost:8080/api/metrics \
  -H "Content-Type: application/json" \
  -d '{
    "employeeId": 2,
    "precision": 0.92,
    "recall": 0.90,
    "accuracy": 0.91,
    "category": "Planning",
    "period": "Q1 2024"
  }'

curl -X POST http://localhost:8080/api/metrics \
  -H "Content-Type: application/json" \
  -d '{
    "employeeId": 2,
    "precision": 0.94,
    "recall": 0.93,
    "accuracy": 0.94,
    "category": "Execution",
    "period": "Q2 2024"
  }'
```

**Metrics for Mike Johnson (Employee ID: 3):**
```bash
curl -X POST http://localhost:8080/api/metrics \
  -H "Content-Type: application/json" \
  -d '{
    "employeeId": 3,
    "precision": 0.97,
    "recall": 0.96,
    "accuracy": 0.97,
    "category": "Testing",
    "period": "Q1 2024"
  }'

curl -X POST http://localhost:8080/api/metrics \
  -H "Content-Type: application/json" \
  -d '{
    "employeeId": 3,
    "precision": 0.98,
    "recall": 0.97,
    "accuracy": 0.98,
    "category": "Quality Assurance",
    "period": "Q2 2024"
  }'
```

---

## Option 3: Using Postman

### Import Collection

Create a new Postman collection with the following requests:

**Collection Name:** Employee Monitoring System

---

### Request 1: Add Employee
- **Method:** POST
- **URL:** http://localhost:8080/api/employees
- **Headers:** Content-Type: application/json
- **Body:**
```json
{
  "employeeId": "EMP001",
  "name": "John Doe",
  "department": "Engineering",
  "position": "Senior Developer",
  "email": "john.doe@example.com"
}
```

---

### Request 2: Add Performance Metrics
- **Method:** POST
- **URL:** http://localhost:8080/api/metrics
- **Headers:** Content-Type: application/json
- **Body:**
```json
{
  "employeeId": 1,
  "precision": 0.95,
  "recall": 0.92,
  "accuracy": 0.94,
  "category": "Code Quality",
  "period": "Q1 2024"
}
```

---

### Request 3: Get All Employees
- **Method:** GET
- **URL:** http://localhost:8080/api/employees

---

### Request 4: Get All Metrics
- **Method:** GET
- **URL:** http://localhost:8080/api/metrics

---

## Verification

After loading sample data, verify by:

1. **Via API:**
```bash
# Get all employees
curl http://localhost:8080/api/employees

# Get all metrics
curl http://localhost:8080/api/metrics
```

2. **Via Frontend:**
   - Admin Dashboard: Check employee list
   - Employee Dashboard: Search for EMP001, view metrics

3. **Via H2 Console:**
   - Run `SELECT COUNT(*) FROM employees;`
   - Run `SELECT COUNT(*) FROM performance_metrics;`

---

## Sample Data Summary

### Employees (6 total)
| ID | Employee ID | Name | Department | Position |
|----|------------|------|-----------|----------|
| 1 | EMP001 | John Doe | Engineering | Senior Developer |
| 2 | EMP002 | Jane Smith | Product | Product Manager |
| 3 | EMP003 | Mike Johnson | Engineering | QA Engineer |
| 4 | EMP004 | Sarah Williams | Marketing | Marketing Manager |
| 5 | EMP005 | Robert Brown | Sales | Sales Executive |
| 6 | EMP006 | Emily Davis | Engineering | Junior Developer |

### Performance Metrics (12+ total)
Each employee has 1-3 performance records with varying metrics for different categories and periods (Q1 2024, Q2 2024, etc.)

---

## Test Scenarios

### Test 1: View Employee Metrics
1. Login to Admin Dashboard (admin/admin123)
2. See all 6 employees in table
3. See performance metrics in metrics table

### Test 2: Search Employee
1. Go to Employee Dashboard
2. Enter "EMP001"
3. See John Doe's profile
4. See his performance charts

### Test 3: Add New Employee
1. Login to Admin Dashboard
2. Click "Show Form"
3. Add new employee
4. Verify in employees table

### Test 4: Delete Employee
1. Login to Admin Dashboard
2. Find employee in table
3. Click Delete button
4. Confirm deletion

---

**Sample data ready to use!** 🎉

---

**Last Updated:** 2024-04-05
