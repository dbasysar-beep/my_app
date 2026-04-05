package com.example.employeemonitoring.repository;

import com.example.employeemonitoring.model.PerformanceMetrics;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repository for PerformanceMetrics entity
 */
@Repository
public interface PerformanceMetricsRepository extends JpaRepository<PerformanceMetrics, Long> {

    /**
     * Find all metrics for a specific employee
     */
    List<PerformanceMetrics> findByEmployeeId(Long employeeId);

    /**
     * Find metrics by employee ID and period
     */
    Optional<PerformanceMetrics> findByEmployeeIdAndPeriod(Long employeeId, String period);

    /**
     * Get latest metrics for an employee
     */
    @Query(value = "SELECT * FROM performance_metrics WHERE employee_id = :employeeId ORDER BY evaluation_date DESC LIMIT 1", nativeQuery = true)
    Optional<PerformanceMetrics> findLatestByEmployeeId(@Param("employeeId") Long employeeId);

    /**
     * Find all metrics for a specific category
     */
    List<PerformanceMetrics> findByCategory(String category);
}
