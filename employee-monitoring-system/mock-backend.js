const express = require('express');
const cors = require('cors');
const app = express();
const PORT = 8080;

// Middleware
app.use(cors({
  origin: ['http://localhost:3000', 'http://localhost:3001', 'http://172.20.10.3:3000'],
  credentials: true
}));
app.use(express.json());

// Mock data
let employees = [
  { id: 1, employeeId: 'EMP001', name: 'John Doe', department: 'Engineering', position: 'Senior Developer', email: 'john@example.com' },
  { id: 2, employeeId: 'EMP002', name: 'Jane Smith', department: 'Marketing', position: 'Marketing Manager', email: 'jane@example.com' },
  { id: 3, employeeId: 'EMP003', name: 'Bob Johnson', department: 'Sales', position: 'Sales Representative', email: 'bob@example.com' }
];

let metrics = [
  { id: 1, employeeId: 'EMP001', precision: 0.95, recall: 0.92, f1Score: 0.935, accuracy: 0.94, category: 'Classification', dateRecorded: '2024-01-15' },
  { id: 2, employeeId: 'EMP002', precision: 0.88, recall: 0.90, f1Score: 0.89, accuracy: 0.87, category: 'Analysis', dateRecorded: '2024-01-15' },
  { id: 3, employeeId: 'EMP003', precision: 0.92, recall: 0.89, f1Score: 0.905, accuracy: 0.91, category: 'Reporting', dateRecorded: '2024-01-15' }
];

// Routes
app.get('/api/employees', (req, res) => {
  res.json(employees);
});

app.get('/api/employees/:id', (req, res) => {
  const employee = employees.find(e => e.id === parseInt(req.params.id));
  if (employee) {
    res.json(employee);
  } else {
    res.status(404).json({ error: 'Employee not found' });
  }
});

app.post('/api/employees', (req, res) => {
  const newEmployee = {
    id: employees.length + 1,
    ...req.body
  };
  employees.push(newEmployee);
  res.status(201).json(newEmployee);
});

app.put('/api/employees/:id', (req, res) => {
  const index = employees.findIndex(e => e.id === parseInt(req.params.id));
  if (index !== -1) {
    employees[index] = { ...employees[index], ...req.body };
    res.json(employees[index]);
  } else {
    res.status(404).json({ error: 'Employee not found' });
  }
});

app.delete('/api/employees/:id', (req, res) => {
  const index = employees.findIndex(e => e.id === parseInt(req.params.id));
  if (index !== -1) {
    employees.splice(index, 1);
    res.status(204).send();
  } else {
    res.status(404).json({ error: 'Employee not found' });
  }
});

app.get('/api/metrics', (req, res) => {
  res.json(metrics);
});

app.get('/api/metrics/employee/:employeeId', (req, res) => {
  const employeeMetrics = metrics.filter(m => m.employeeId === req.params.employeeId);
  res.json(employeeMetrics);
});

// Admin auth (mock)
app.post('/api/auth/login', (req, res) => {
  const { username, password } = req.body;
  if (username === 'admin' && password === 'admin123') {
    res.json({ success: true, admin: { id: 1, username: 'admin', role: 'ADMIN' } });
  } else {
    res.status(401).json({ error: 'Invalid credentials' });
  }
});

app.listen(PORT, () => {
  console.log(`🚀 Mock backend server running on http://localhost:${PORT}`);
  console.log(`📱 Mobile access: http://172.20.10.3:${PORT}`);
  console.log(`🔗 API endpoints available at /api/*`);
});