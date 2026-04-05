package com.example.employeemonitoring.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Admin entity for authentication and authorization
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Admin {

    private String adminId;
    private String username;
    private String password;
    private String email;
    private String role;

    /**
     * Validate admin credentials
     */
    public boolean validateCredentials(String username, String password) {
        return this.username.equals(username) && this.password.equals(password);
    }
}
