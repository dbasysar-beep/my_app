/**
 * API Service - Handles all HTTP requests to the backend
 */

import axios from 'axios';

const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:8080/api';

const apiClient = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
  timeout: 10000, // 10 second timeout
});

// Add response interceptor for better error handling
apiClient.interceptors.response.use(
  (response) => {
    return response;
  },
  (error) => {
    console.error('API Error:', error);

    // Check if response is HTML instead of JSON
    if (error.response) {
      const contentType = error.response.headers['content-type'];
      if (contentType && contentType.includes('text/html')) {
        console.error('❌ API returned HTML instead of JSON!');
        console.error('Response data starts with:', error.response.data.substring(0, 200));
        console.error('This usually means:');
        console.error('1. Backend server is not running');
        console.error('2. Wrong API URL:', API_BASE_URL);
        console.error('3. CORS issues');
        console.error('4. Backend routes not configured correctly');
      }
    } else if (error.code === 'ECONNREFUSED') {
      console.error('❌ Cannot connect to backend server!');
      console.error('Make sure the backend is running on:', API_BASE_URL);
    }

    return Promise.reject(error);
  }
);

// Employee APIs
export const employeeAPI = {
  // Get all employees
  getAllEmployees: () => apiClient.get('/employees'),

  // Get employee by ID
  getEmployeeById: (id) => apiClient.get(`/employees/${id}`),

  // Get employee by custom employee ID
  getEmployeeByEmployeeId: (employeeId) => apiClient.get(`/employees/by-employee-id/${employeeId}`),

  // Create new employee
  createEmployee: (employeeData) => apiClient.post('/employees', employeeData),

  // Update employee
  updateEmployee: (id, employeeData) => apiClient.put(`/employees/${id}`, employeeData),

  // Delete employee
  deleteEmployee: (id) => apiClient.delete(`/employees/${id}`),

  // Get employee count
  getEmployeeCount: () => apiClient.get('/employees/count/total'),
};

// Performance Metrics APIs
export const metricsAPI = {
  // Get all metrics
  getAllMetrics: () => apiClient.get('/metrics'),

  // Get metrics by ID
  getMetricsById: (id) => apiClient.get(`/metrics/${id}`),

  // Get metrics for specific employee
  getMetricsByEmployeeId: (employeeId) => apiClient.get(`/metrics/employee/${employeeId}`),

  // Get latest metrics for employee
  getLatestMetricsByEmployeeId: (employeeId) => apiClient.get(`/metrics/employee/${employeeId}/latest`),

  // Get average metrics for employee
  getAverageMetrics: (employeeId) => apiClient.get(`/metrics/employee/${employeeId}/average`),

  // Create new metrics
  createMetrics: (metricsData) => apiClient.post('/metrics', metricsData),

  // Update metrics
  updateMetrics: (id, metricsData) => apiClient.put(`/metrics/${id}`, metricsData),

  // Delete metrics
  deleteMetrics: (id) => apiClient.delete(`/metrics/${id}`),

  // Get metrics by category
  getMetricsByCategory: (category) => apiClient.get(`/metrics/category/${category}`),
};

// Admin Authentication APIs
export const authAPI = {
  // Admin login
  login: (credentials) => apiClient.post('/auth/login', credentials),

  // Verify admin
  verifyAdmin: (username) => apiClient.post('/auth/verify', { username }),

  // Health check
  health: () => apiClient.get('/auth/health'),
};

export default apiClient;
