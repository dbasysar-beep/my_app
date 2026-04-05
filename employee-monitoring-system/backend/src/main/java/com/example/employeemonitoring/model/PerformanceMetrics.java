package com.example.employeemonitoring.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * PerformanceMetrics entity storing performance metrics for employees
 */
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "performance_metrics")
public class PerformanceMetrics {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long employeeId;

    @Column
    private Double precision;

    @Column
    private Double recall;

    @Column
    private Double f1Score;

    @Column
    private Double accuracy;

    @Column
    private String evaluationDate;

    @Column
    private String period; // e.g., "Q1 2024", "January 2024"

    @Column
    private String category; // e.g., "Productivity", "Quality", "Collaboration"

    /**
     * Calculate F1 Score from precision and recall
     */
    public void calculateF1Score() {
        if (this.precision != null && this.recall != null && this.precision > 0 && this.recall > 0) {
            this.f1Score = 2 * (this.precision * this.recall) / (this.precision + this.recall);
        }
    }

    /**
     * Constructor with basic fields
     */
    public PerformanceMetrics(Long employeeId, Double precision, Double recall) {
        this.employeeId = employeeId;
        this.precision = precision;
        this.recall = recall;
        this.evaluationDate = java.time.LocalDate.now().toString();
        calculateF1Score();
    }
}
