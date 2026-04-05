package com.example.employeemonitoring.repository;

import com.example.employeemonitoring.model.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Repository for Employee entity - handles database operations
 */
@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Long> {

    /**
     * Find employee by employeeId
     */
    Optional<Employee> findByEmployeeId(String employeeId);

    /**
     * Find employee by name
     */
    Optional<Employee> findByName(String name);

    /**
     * Check if employee exists by employeeId
     */
    boolean existsByEmployeeId(String employeeId);
}
