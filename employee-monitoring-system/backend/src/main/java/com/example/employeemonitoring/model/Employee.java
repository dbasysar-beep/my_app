package com.example.employeemonitoring.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Employee entity representing an employee in the system
 */
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "employees")
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String employeeId;

    @Column(nullable = false)
    private String name;

    @Column
    private String department;

    @Column
    private String position;

    @Column
    private String email;

    @Column(columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    private String createdDate;

    /**
     * Constructor with basic fields
     */
    public Employee(String employeeId, String name) {
        this.employeeId = employeeId;
        this.name = name;
        this.createdDate = java.time.LocalDateTime.now().toString();
    }
}
