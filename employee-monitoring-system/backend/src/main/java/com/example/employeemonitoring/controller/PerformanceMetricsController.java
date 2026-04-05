package com.example.employeemonitoring.controller;

import com.example.employeemonitoring.model.PerformanceMetrics;
import com.example.employeemonitoring.service.PerformanceMetricsService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * REST Controller for Performance Metrics endpoints
 * Handles HTTP requests related to performance monitoring
 */
@RestController
@RequestMapping("/api/metrics")
@RequiredArgsConstructor
@CrossOrigin(origins = {"http://localhost:3000", "http://localhost:3001"})
public class PerformanceMetricsController {

    private final PerformanceMetricsService performanceMetricsService;

    /**
     * GET /api/metrics - Get all metrics
     */
    @GetMapping
    public ResponseEntity<?> getAllMetrics() {
        try {
            List<PerformanceMetrics> metrics = performanceMetricsService.getAllMetrics();
            return ResponseEntity.ok(metrics);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error fetching metrics: " + e.getMessage());
        }
    }

    /**
     * GET /api/metrics/{id} - Get metrics by ID
     */
    @GetMapping("/{id}")
    public ResponseEntity<?> getMetricsById(@PathVariable Long id) {
        try {
            return performanceMetricsService.getMetricsById(id)
                    .map(ResponseEntity::ok)
                    .orElseGet(() -> ResponseEntity.notFound().build());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error fetching metrics: " + e.getMessage());
        }
    }

    /**
     * GET /api/metrics/employee/{employeeId} - Get all metrics for an employee
     */
    @GetMapping("/employee/{employeeId}")
    public ResponseEntity<?> getMetricsByEmployeeId(@PathVariable Long employeeId) {
        try {
            List<PerformanceMetrics> metrics = performanceMetricsService.getMetricsByEmployeeId(employeeId);
            return ResponseEntity.ok(metrics);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error fetching metrics: " + e.getMessage());
        }
    }

    /**
     * GET /api/metrics/employee/{employeeId}/latest - Get latest metrics for an employee
     */
    @GetMapping("/employee/{employeeId}/latest")
    public ResponseEntity<?> getLatestMetricsByEmployeeId(@PathVariable Long employeeId) {
        try {
            return performanceMetricsService.getLatestMetricsByEmployeeId(employeeId)
                    .map(ResponseEntity::ok)
                    .orElseGet(() -> ResponseEntity.notFound().build());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error fetching latest metrics: " + e.getMessage());
        }
    }

    /**
     * GET /api/metrics/employee/{employeeId}/average - Get average metrics for an employee
     */
    @GetMapping("/employee/{employeeId}/average")
    public ResponseEntity<?> getAverageMetrics(@PathVariable Long employeeId) {
        try {
            Map<String, Double> averages = performanceMetricsService.getAverageMetrics(employeeId);
            return ResponseEntity.ok(averages);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error calculating average metrics: " + e.getMessage());
        }
    }

    /**
     * POST /api/metrics - Create new performance metrics
     */
    @PostMapping
    public ResponseEntity<?> createMetrics(@RequestBody PerformanceMetrics metrics) {
        try {
            if (metrics.getEmployeeId() == null) {
                return ResponseEntity.badRequest().body("Employee ID is required");
            }

            PerformanceMetrics createdMetrics = performanceMetricsService.createMetrics(metrics);
            return ResponseEntity.status(HttpStatus.CREATED).body(createdMetrics);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error creating metrics: " + e.getMessage());
        }
    }

    /**
     * PUT /api/metrics/{id} - Update performance metrics
     */
    @PutMapping("/{id}")
    public ResponseEntity<?> updateMetrics(@PathVariable Long id, @RequestBody PerformanceMetrics metrics) {
        try {
            PerformanceMetrics updatedMetrics = performanceMetricsService.updateMetrics(id, metrics);
            return ResponseEntity.ok(updatedMetrics);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error updating metrics: " + e.getMessage());
        }
    }

    /**
     * DELETE /api/metrics/{id} - Delete performance metrics
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteMetrics(@PathVariable Long id) {
        try {
            performanceMetricsService.deleteMetrics(id);
            return ResponseEntity.ok().body("Metrics deleted successfully");
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error deleting metrics: " + e.getMessage());
        }
    }

    /**
     * GET /api/metrics/category/{category} - Get metrics by category
     */
    @GetMapping("/category/{category}")
    public ResponseEntity<?> getMetricsByCategory(@PathVariable String category) {
        try {
            List<PerformanceMetrics> metrics = performanceMetricsService.getMetricsByCategory(category);
            return ResponseEntity.ok(metrics);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error fetching metrics: " + e.getMessage());
        }
    }
}
