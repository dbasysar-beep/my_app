/**
 * Employee Dashboard Component
 * Displays individual employee performance information
 */

import React, { useEffect, useState } from 'react';
import PerformanceChart from '../components/PerformanceChart';
import { employeeAPI, metricsAPI } from '../services/api';

const EmployeeDashboard = () => {
  const [employee, setEmployee] = useState(null);
  const [metrics, setMetrics] = useState([]);
  const [averageMetrics, setAverageMetrics] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [selectedEmployeeId, setSelectedEmployeeId] = useState('');

  // Fetch employee data
  const fetchEmployeeData = async (employeeId) => {
    if (!employeeId) {
      setError('Please enter an Employee ID');
      return;
    }

    setLoading(true);
    setError('');

    try {
      const empRes = await employeeAPI.getEmployeeByEmployeeId(employeeId);
      setEmployee(empRes.data);

      // Fetch metrics for this employee
      if (empRes.data.id) {
        const metricsRes = await metricsAPI.getMetricsByEmployeeId(empRes.data.id);
        setMetrics(metricsRes.data);

        // Fetch average metrics
        try {
          const avgRes = await metricsAPI.getAverageMetrics(empRes.data.id);
          setAverageMetrics(avgRes.data);
        } catch (err) {
          console.log('No average metrics available');
        }
      }
    } catch (err) {
      console.error('Error fetching employee data:', err);
      setError('Employee not found. Please check the Employee ID.');
      setEmployee(null);
      setMetrics([]);
      setAverageMetrics(null);
    } finally {
      setLoading(false);
    }
  };

  const handleSearch = (e) => {
    e.preventDefault();
    fetchEmployeeData(selectedEmployeeId);
  };

  return (
    <div>
      <nav>
        <h1 style={{ borderBottom: 'none', margin: 0 }}>
          Employee Performance Dashboard
        </h1>
      </nav>

      <div className="container">
        {/* Search Section */}
        <div className="card">
          <h2>Find Your Profile</h2>
          <form onSubmit={handleSearch}>
            <div style={{ display: 'flex', gap: '1rem' }}>
              <input
                type="text"
                value={selectedEmployeeId}
                onChange={(e) => setSelectedEmployeeId(e.target.value)}
                placeholder="Enter your Employee ID (e.g., EMP001)"
                style={{ flex: 1 }}
              />
              <button type="submit" className="btn-primary">Search</button>
            </div>
          </form>
        </div>

        {/* Error Message */}
        {error && <div className="alert alert-danger">{error}</div>}

        {/* Loading */}
        {loading && <div className="spinner"></div>}

        {/* Employee Info */}
        {employee && (
          <div className="card">
            <h2>Employee Information</h2>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1.5rem' }}>
              <div>
                <label>Employee ID</label>
                <p style={{ fontSize: '1.1rem', fontWeight: 'bold' }}>{employee.employeeId}</p>
              </div>
              <div>
                <label>Name</label>
                <p style={{ fontSize: '1.1rem', fontWeight: 'bold' }}>{employee.name}</p>
              </div>
              <div>
                <label>Department</label>
                <p style={{ fontSize: '1.1rem', fontWeight: 'bold' }}>{employee.department || '-'}</p>
              </div>
              <div>
                <label>Position</label>
                <p style={{ fontSize: '1.1rem', fontWeight: 'bold' }}>{employee.position || '-'}</p>
              </div>
              <div>
                <label>Email</label>
                <p style={{ fontSize: '1.1rem', fontWeight: 'bold' }}>{employee.email || '-'}</p>
              </div>
            </div>
          </div>
        )}

        {/* Performance Metrics */}
        {employee && (
          <div className="card">
            <h2>Performance Metrics</h2>

            {/* Average Metrics */}
            {averageMetrics && (
              <div style={{ marginBottom: '2rem' }}>
                <h3 style={{ color: '#667eea', marginBottom: '1rem' }}>Average Performance</h3>
                <div className="grid">
                  <div className="metric-card">
                    <div className="label">Avg Precision</div>
                    <div className="value">{(averageMetrics.avgPrecision || 0).toFixed(3)}</div>
                  </div>
                  <div className="metric-card">
                    <div className="label">Avg Recall</div>
                    <div className="value">{(averageMetrics.avgRecall || 0).toFixed(3)}</div>
                  </div>
                  <div className="metric-card">
                    <div className="label">Avg F1 Score</div>
                    <div className="value">{(averageMetrics.avgF1Score || 0).toFixed(3)}</div>
                  </div>
                </div>
              </div>
            )}

            {/* Performance Chart */}
            {metrics.length > 0 && (
              <div style={{ marginBottom: '2rem', marginTop: '2rem' }}>
                <h3 style={{ color: '#667eea', marginBottom: '1rem' }}>Performance Trend</h3>
                <PerformanceChart metrics={metrics} />
              </div>
            )}

            {/* Detailed Metrics Table */}
            {metrics.length > 0 ? (
              <div>
                <h3 style={{ color: '#667eea', marginBottom: '1rem' }}>Detailed Records</h3>
                <table>
                  <thead>
                    <tr>
                      <th>Precision</th>
                      <th>Recall</th>
                      <th>F1 Score</th>
                      <th>Accuracy</th>
                      <th>Category</th>
                      <th>Period</th>
                      <th>Evaluation Date</th>
                    </tr>
                  </thead>
                  <tbody>
                    {metrics.map((metric) => (
                      <tr key={metric.id}>
                        <td>{(metric.precision || 0).toFixed(3)}</td>
                        <td>{(metric.recall || 0).toFixed(3)}</td>
                        <td><strong>{(metric.f1Score || 0).toFixed(3)}</strong></td>
                        <td>{(metric.accuracy || 0).toFixed(3)}</td>
                        <td>{metric.category || '-'}</td>
                        <td>{metric.period || '-'}</td>
                        <td>{metric.evaluationDate || '-'}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            ) : (
              employee && <p>No performance metrics available for this employee.</p>
            )}
          </div>
        )}

        {/* Initial State */}
        {!employee && !error && (
          <div className="card" style={{ textAlign: 'center', background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)', color: 'white' }}>
            <p style={{ fontSize: '1.1rem' }}>Enter your Employee ID to view your performance dashboard</p>
          </div>
        )}
      </div>
    </div>
  );
};

export default EmployeeDashboard;
