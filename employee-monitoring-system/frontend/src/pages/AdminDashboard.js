/**
 * Admin Dashboard Component
 * Displays employee management interface for admins
 */

import React, { useEffect, useState } from 'react';
import { employeeAPI, metricsAPI } from '../services/api';

const AdminDashboard = ({ admin, onLogout }) => {
  const [employees, setEmployees] = useState([]);
  const [metrics, setMetrics] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [successMessage, setSuccessMessage] = useState('');
  const [formData, setFormData] = useState({ employeeId: '', name: '', department: '', position: '', email: '' });
  const [showForm, setShowForm] = useState(false);

  // Fetch employees and metrics on component mount
  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    setLoading(true);
    try {
      const [empRes, metricsRes] = await Promise.all([
        employeeAPI.getAllEmployees(),
        metricsAPI.getAllMetrics()
      ]);
      setEmployees(empRes.data);
      setMetrics(metricsRes.data);
      setError('');
    } catch (err) {
      console.error('Error fetching data:', err);

      // Provide more specific error messages
      if (err.code === 'ECONNREFUSED') {
        setError('Cannot connect to backend server. Make sure the backend is running.');
      } else if (err.response?.status === 404) {
        setError('API endpoint not found. Check backend routes.');
      } else if (err.response?.headers?.['content-type']?.includes('text/html')) {
        setError('Backend returned HTML instead of JSON. Backend server may not be running.');
      } else {
        setError(`Failed to load data: ${err.message || 'Unknown error'}`);
      }
    } finally {
      setLoading(false);
    }
  };

  const handleAddEmployee = async (e) => {
    e.preventDefault();

    if (!formData.employeeId || !formData.name) {
      setError('Employee ID and Name are required');
      return;
    }

    try {
      await employeeAPI.createEmployee(formData);
      setSuccessMessage('Employee added successfully');
      setFormData({ employeeId: '', name: '', department: '', position: '', email: '' });
      setShowForm(false);
      setTimeout(() => setSuccessMessage(''), 3000);
      fetchData();
    } catch (err) {
      console.error('Error adding employee:', err);
      setError('Failed to add employee');
    }
  };

  const handleDeleteEmployee = async (id) => {
    if (window.confirm('Are you sure you want to delete this employee?')) {
      try {
        await employeeAPI.deleteEmployee(id);
        setSuccessMessage('Employee deleted successfully');
        setTimeout(() => setSuccessMessage(''), 3000);
        fetchData();
      } catch (err) {
        console.error('Error deleting employee:', err);
        setError('Failed to delete employee');
      }
    }
  };

  return (
    <div>
      <nav>
        <h1>
          <span>Admin Dashboard - Employee Performance Monitoring</span>
          <button onClick={onLogout} className="btn-secondary">Logout</button>
        </h1>
      </nav>

      <div className="container">
        {/* Welcome Section */}
        <div className="card">
          <h2>Welcome, {admin.username}!</h2>
          <p>Manage employees and view their performance metrics.</p>
        </div>

        {/* Statistics */}
        <div className="grid">
          <div className="metric-card">
            <div className="label">Total Employees</div>
            <div className="value">{employees.length}</div>
          </div>
          <div className="metric-card">
            <div className="label">Performance Records</div>
            <div className="value">{metrics.length}</div>
          </div>
          <div className="metric-card">
            <div className="label">Admin Role</div>
            <div className="value">{admin.role}</div>
          </div>
        </div>

        {/* Messages */}
        {successMessage && <div className="alert alert-success">{successMessage}</div>}
        {error && <div className="alert alert-danger">{error}</div>}

        {/* Add Employee Form */}
        <div className="card">
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <h2 style={{ margin: 0 }}>Add New Employee</h2>
            <button 
              onClick={() => setShowForm(!showForm)} 
              className="btn-primary"
            >
              {showForm ? 'Hide Form' : 'Show Form'}
            </button>
          </div>

          {showForm && (
            <form onSubmit={handleAddEmployee} style={{ marginTop: '1rem' }}>
              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem' }}>
                <div className="form-group">
                  <label htmlFor="employeeId">Employee ID</label>
                  <input
                    type="text"
                    id="employeeId"
                    value={formData.employeeId}
                    onChange={(e) => setFormData({ ...formData, employeeId: e.target.value })}
                    required
                    placeholder="e.g., EMP001"
                  />
                </div>
                <div className="form-group">
                  <label htmlFor="name">Name</label>
                  <input
                    type="text"
                    id="name"
                    value={formData.name}
                    onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                    required
                    placeholder="Full name"
                  />
                </div>
                <div className="form-group">
                  <label htmlFor="department">Department</label>
                  <input
                    type="text"
                    id="department"
                    value={formData.department}
                    onChange={(e) => setFormData({ ...formData, department: e.target.value })}
                    placeholder="e.g., Engineering"
                  />
                </div>
                <div className="form-group">
                  <label htmlFor="position">Position</label>
                  <input
                    type="text"
                    id="position"
                    value={formData.position}
                    onChange={(e) => setFormData({ ...formData, position: e.target.value })}
                    placeholder="e.g., Senior Developer"
                  />
                </div>
                <div className="form-group">
                  <label htmlFor="email">Email</label>
                  <input
                    type="email"
                    id="email"
                    value={formData.email}
                    onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                    placeholder="email@example.com"
                  />
                </div>
              </div>
              <button type="submit" className="btn-success">Add Employee</button>
            </form>
          )}
        </div>

        {/* Employees Table */}
        <div className="card">
          <h2>Employees List</h2>
          {loading ? (
            <div className="spinner"></div>
          ) : employees.length === 0 ? (
            <p>No employees found</p>
          ) : (
            <table>
              <thead>
                <tr>
                  <th>Employee ID</th>
                  <th>Name</th>
                  <th>Department</th>
                  <th>Position</th>
                  <th>Email</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                {employees.map((emp) => (
                  <tr key={emp.id}>
                    <td>{emp.employeeId}</td>
                    <td>{emp.name}</td>
                    <td>{emp.department || '-'}</td>
                    <td>{emp.position || '-'}</td>
                    <td>{emp.email || '-'}</td>
                    <td>
                      <button 
                        onClick={() => handleDeleteEmployee(emp.id)} 
                        className="btn-danger"
                        style={{ padding: '0.5rem 1rem', fontSize: '0.9rem' }}
                      >
                        Delete
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>

        {/* Performance Metrics Summary */}
        <div className="card">
          <h2>Performance Metrics Summary</h2>
          {metrics.length === 0 ? (
            <p>No performance metrics available</p>
          ) : (
            <table>
              <thead>
                <tr>
                  <th>Employee ID</th>
                  <th>Precision</th>
                  <th>Recall</th>
                  <th>F1 Score</th>
                  <th>Category</th>
                  <th>Period</th>
                </tr>
              </thead>
              <tbody>
                {metrics.slice(0, 10).map((metric) => (
                  <tr key={metric.id}>
                    <td>{metric.employeeId}</td>
                    <td>{(metric.precision || 0).toFixed(3)}</td>
                    <td>{(metric.recall || 0).toFixed(3)}</td>
                    <td><strong>{(metric.f1Score || 0).toFixed(3)}</strong></td>
                    <td>{metric.category || '-'}</td>
                    <td>{metric.period || '-'}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>
      </div>
    </div>
  );
};

export default AdminDashboard;
