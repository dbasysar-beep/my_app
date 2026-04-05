package com.example.employeemonitoring.service;

import com.example.employeemonitoring.model.Admin;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.Map;

/**
 * Service class for Admin authentication
 * Handles admin login and verification
 */
@Service
public class AdminService {

    // In-memory storage for demo purposes
    // In production, this should be persisted in a database
    private static final Map<String, Admin> admins = new HashMap<>();

    static {
        // Initialize with default admin credentials
        Admin defaultAdmin = new Admin("ADMIN001", "admin", "admin123", "admin@example.com", "ADMIN");
        admins.put("admin", defaultAdmin);
    }

    /**
     * Authenticate admin with username and password
     */
    public Admin authenticate(String username, String password) {
        Admin admin = admins.get(username);
        
        if (admin != null && admin.validateCredentials(username, password)) {
            return admin;
        }
        
        throw new RuntimeException("Invalid username or password");
    }

    /**
     * Get admin by username
     */
    public Admin getAdminByUsername(String username) {
        return admins.getOrDefault(username, null);
    }

    /**
     * Add new admin (only for other admins)
     */
    public Admin createAdmin(Admin admin) {
        if (admins.containsKey(admin.getUsername())) {
            throw new RuntimeException("Admin with this username already exists");
        }
        admins.put(admin.getUsername(), admin);
        return admin;
    }

    /**
     * Verify if user is admin
     */
    public boolean isAdmin(String username) {
        return admins.containsKey(username);
    }
}
