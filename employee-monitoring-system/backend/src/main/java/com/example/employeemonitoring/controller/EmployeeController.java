package com.example.employeemonitoring.controller;

import com.example.employeemonitoring.model.Employee;
import com.example.employeemonitoring.service.EmployeeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * REST Controller for Employee endpoints
 * Handles HTTP requests related to employee management
 */
@RestController
@RequestMapping("/api/employees")
@RequiredArgsConstructor
@CrossOrigin(origins = {"http://localhost:3000", "http://localhost:3001"})
public class EmployeeController {

    private final EmployeeService employeeService;

    /**
     * GET /api/employees - Get all employees
     */
    @GetMapping
    public ResponseEntity<?> getAllEmployees() {
        try {
            List<Employee> employees = employeeService.getAllEmployees();
            return ResponseEntity.ok(employees);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error fetching employees: " + e.getMessage());
        }
    }

    /**
     * GET /api/employees/{id} - Get employee by ID
     */
    @GetMapping("/{id}")
    public ResponseEntity<?> getEmployeeById(@PathVariable Long id) {
        try {
            return employeeService.getEmployeeById(id)
                    .map(ResponseEntity::ok)
                    .orElseGet(() -> ResponseEntity.notFound().build());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error fetching employee: " + e.getMessage());
        }
    }

    /**
     * GET /api/employees/by-employee-id/{employeeId} - Get employee by custom employee ID
     */
    @GetMapping("/by-employee-id/{employeeId}")
    public ResponseEntity<?> getEmployeeByEmployeeId(@PathVariable String employeeId) {
        try {
            return employeeService.getEmployeeByEmployeeId(employeeId)
                    .map(ResponseEntity::ok)
                    .orElseGet(() -> ResponseEntity.notFound().build());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error fetching employee: " + e.getMessage());
        }
    }

    /**
     * POST /api/employees - Create a new employee
     */
    @PostMapping
    public ResponseEntity<?> createEmployee(@RequestBody Employee employee) {
        try {
            if (employee.getName() == null || employee.getName().isEmpty()) {
                return ResponseEntity.badRequest().body("Employee name is required");
            }
            if (employee.getEmployeeId() == null || employee.getEmployeeId().isEmpty()) {
                return ResponseEntity.badRequest().body("Employee ID is required");
            }

            Employee createdEmployee = employeeService.createEmployee(employee);
            return ResponseEntity.status(HttpStatus.CREATED).body(createdEmployee);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error creating employee: " + e.getMessage());
        }
    }

    /**
     * PUT /api/employees/{id} - Update an employee
     */
    @PutMapping("/{id}")
    public ResponseEntity<?> updateEmployee(@PathVariable Long id, @RequestBody Employee employee) {
        try {
            Employee updatedEmployee = employeeService.updateEmployee(id, employee);
            return ResponseEntity.ok(updatedEmployee);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error updating employee: " + e.getMessage());
        }
    }

    /**
     * DELETE /api/employees/{id} - Delete an employee
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteEmployee(@PathVariable Long id) {
        try {
            employeeService.deleteEmployee(id);
            return ResponseEntity.ok().body("Employee deleted successfully");
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error deleting employee: " + e.getMessage());
        }
    }

    /**
     * GET /api/employees/count - Get total number of employees
     */
    @GetMapping("/count/total")
    public ResponseEntity<?> getEmployeeCount() {
        try {
            long count = employeeService.getEmployeeCount();
            return ResponseEntity.ok().body("{\"count\": " + count + "}");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error fetching employee count: " + e.getMessage());
        }
    }
}
