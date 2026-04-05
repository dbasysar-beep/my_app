/**
 * Main App Component
 * Handles routing and authentication
 */

import React, { useState, useEffect } from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import Login from './pages/Login';
import AdminDashboard from './pages/AdminDashboard';
import EmployeeDashboard from './pages/EmployeeDashboard';
import './styles/index.css';

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [admin, setAdmin] = useState(null);

  // Check if admin is already logged in
  useEffect(() => {
    const storedAuth = localStorage.getItem('isAuthenticated');
    const storedAdmin = localStorage.getItem('admin');

    if (storedAuth === 'true' && storedAdmin) {
      setIsAuthenticated(true);
      setAdmin(JSON.parse(storedAdmin));
    }
  }, []);

  const handleLoginSuccess = (adminData) => {
    setAdmin(adminData);
    setIsAuthenticated(true);
  };

  const handleLogout = () => {
    setAdmin(null);
    setIsAuthenticated(false);
    localStorage.removeItem('admin');
    localStorage.removeItem('isAuthenticated');
  };

  return (
    <BrowserRouter>
      <Routes>
        {/* Login Route */}
        <Route
          path="/login"
          element={!isAuthenticated ? <Login onLoginSuccess={handleLoginSuccess} /> : <Navigate to="/admin" />}
        />

        {/* Admin Dashboard Route */}
        <Route
          path="/admin"
          element={isAuthenticated ? <AdminDashboard admin={admin} onLogout={handleLogout} /> : <Navigate to="/login" />}
        />

        {/* Employee Dashboard Route */}
        <Route
          path="/employee"
          element={<EmployeeDashboard />}
        />

        {/* Home Route */}
        <Route
          path="/"
          element={<Navigate to="/employee" />}
        />

        {/* Catch all */}
        <Route path="*" element={<Navigate to="/employee" />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
