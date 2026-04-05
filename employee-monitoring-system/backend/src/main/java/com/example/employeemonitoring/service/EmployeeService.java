package com.example.employeemonitoring.service;

import com.example.employeemonitoring.model.Employee;
import com.example.employeemonitoring.repository.EmployeeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

/**
 * Service class for Employee operations
 * Handles business logic and database interactions
 */
@Service
@RequiredArgsConstructor
public class EmployeeService {

    private final EmployeeRepository employeeRepository;

    /**
     * Get all employees
     */
    public List<Employee> getAllEmployees() {
        return employeeRepository.findAll();
    }

    /**
     * Get employee by ID
     */
    public Optional<Employee> getEmployeeById(Long id) {
        return employeeRepository.findById(id);
    }

    /**
     * Get employee by employeeId (custom ID)
     */
    public Optional<Employee> getEmployeeByEmployeeId(String employeeId) {
        return employeeRepository.findByEmployeeId(employeeId);
    }

    /**
     * Create a new employee
     */
    public Employee createEmployee(Employee employee) {
        if (employee.getCreatedDate() == null) {
            employee.setCreatedDate(java.time.LocalDateTime.now().toString());
        }
        return employeeRepository.save(employee);
    }

    /**
     * Update an existing employee
     */
    public Employee updateEmployee(Long id, Employee employee) {
        return employeeRepository.findById(id)
                .map(existingEmployee -> {
                    if (employee.getName() != null) existingEmployee.setName(employee.getName());
                    if (employee.getDepartment() != null) existingEmployee.setDepartment(employee.getDepartment());
                    if (employee.getPosition() != null) existingEmployee.setPosition(employee.getPosition());
                    if (employee.getEmail() != null) existingEmployee.setEmail(employee.getEmail());
                    return employeeRepository.save(existingEmployee);
                })
                .orElseThrow(() -> new RuntimeException("Employee not found with id: " + id));
    }

    /**
     * Delete an employee
     */
    public void deleteEmployee(Long id) {
        if (!employeeRepository.existsById(id)) {
            throw new RuntimeException("Employee not found with id: " + id);
        }
        employeeRepository.deleteById(id);
    }

    /**
     * Check if employee exists
     */
    public boolean employeeExists(Long id) {
        return employeeRepository.existsById(id);
    }

    /**
     * Count total employees
     */
    public long getEmployeeCount() {
        return employeeRepository.count();
    }
}
