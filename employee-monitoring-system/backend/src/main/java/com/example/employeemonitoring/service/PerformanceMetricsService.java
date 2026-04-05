package com.example.employeemonitoring.service;

import com.example.employeemonitoring.model.PerformanceMetrics;
import com.example.employeemonitoring.repository.PerformanceMetricsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * Service class for Performance Metrics operations
 * Handles business logic for performance management
 */
@Service
@RequiredArgsConstructor
public class PerformanceMetricsService {

    private final PerformanceMetricsRepository performanceMetricsRepository;

    /**
     * Get all performance metrics
     */
    public List<PerformanceMetrics> getAllMetrics() {
        return performanceMetricsRepository.findAll();
    }

    /**
     * Get metrics by metric ID
     */
    public Optional<PerformanceMetrics> getMetricsById(Long id) {
        return performanceMetricsRepository.findById(id);
    }

    /**
     * Get all metrics for a specific employee
     */
    public List<PerformanceMetrics> getMetricsByEmployeeId(Long employeeId) {
        return performanceMetricsRepository.findByEmployeeId(employeeId);
    }

    /**
     * Get latest metrics for an employee
     */
    public Optional<PerformanceMetrics> getLatestMetricsByEmployeeId(Long employeeId) {
        return performanceMetricsRepository.findLatestByEmployeeId(employeeId);
    }

    /**
     * Create new performance metrics
     */
    public PerformanceMetrics createMetrics(PerformanceMetrics metrics) {
        if (metrics.getEvaluationDate() == null) {
            metrics.setEvaluationDate(java.time.LocalDate.now().toString());
        }
        metrics.calculateF1Score();
        return performanceMetricsRepository.save(metrics);
    }

    /**
     * Update performance metrics
     */
    public PerformanceMetrics updateMetrics(Long id, PerformanceMetrics metrics) {
        return performanceMetricsRepository.findById(id)
                .map(existingMetrics -> {
                    if (metrics.getPrecision() != null) existingMetrics.setPrecision(metrics.getPrecision());
                    if (metrics.getRecall() != null) existingMetrics.setRecall(metrics.getRecall());
                    if (metrics.getAccuracy() != null) existingMetrics.setAccuracy(metrics.getAccuracy());
                    if (metrics.getPeriod() != null) existingMetrics.setPeriod(metrics.getPeriod());
                    if (metrics.getCategory() != null) existingMetrics.setCategory(metrics.getCategory());
                    
                    existingMetrics.calculateF1Score();
                    return performanceMetricsRepository.save(existingMetrics);
                })
                .orElseThrow(() -> new RuntimeException("Metrics not found with id: " + id));
    }

    /**
     * Delete performance metrics
     */
    public void deleteMetrics(Long id) {
        if (!performanceMetricsRepository.existsById(id)) {
            throw new RuntimeException("Metrics not found with id: " + id);
        }
        performanceMetricsRepository.deleteById(id);
    }

    /**
     * Get metrics by category
     */
    public List<PerformanceMetrics> getMetricsByCategory(String category) {
        return performanceMetricsRepository.findByCategory(category);
    }

    /**
     * Calculate average metrics for an employee
     */
    public java.util.Map<String, Double> getAverageMetrics(Long employeeId) {
        List<PerformanceMetrics> metrics = getMetricsByEmployeeId(employeeId);
        
        if (metrics.isEmpty()) {
            return new java.util.HashMap<>();
        }

        double avgPrecision = metrics.stream().mapToDouble(m -> m.getPrecision() != null ? m.getPrecision() : 0).average().orElse(0);
        double avgRecall = metrics.stream().mapToDouble(m -> m.getRecall() != null ? m.getRecall() : 0).average().orElse(0);
        double avgF1 = metrics.stream().mapToDouble(m -> m.getF1Score() != null ? m.getF1Score() : 0).average().orElse(0);

        java.util.Map<String, Double> averages = new java.util.HashMap<>();
        averages.put("avgPrecision", avgPrecision);
        averages.put("avgRecall", avgRecall);
        averages.put("avgF1Score", avgF1);

        return averages;
    }
}
