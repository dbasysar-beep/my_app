package com.example.employeemonitoring.controller;

import com.example.employeemonitoring.model.Admin;
import com.example.employeemonitoring.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * REST Controller for Admin authentication endpoints
 * Handles admin login and authentication
 */
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@CrossOrigin(origins = {"http://localhost:3000", "http://localhost:3001"})
public class AdminAuthController {

    private final AdminService adminService;

    /**
     * POST /api/auth/login - Admin login endpoint
     * Request body: {"username": "...", "password": "..."}
     */
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> credentials) {
        try {
            String username = credentials.get("username");
            String password = credentials.get("password");

            if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
                return ResponseEntity.badRequest()
                        .body("Username and password are required");
            }

            Admin admin = adminService.authenticate(username, password);

            // Return success response with admin info (excluding password)
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("adminId", admin.getAdminId());
            response.put("username", admin.getUsername());
            response.put("email", admin.getEmail());
            response.put("role", admin.getRole());
            response.put("message", "Login successful");

            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "Invalid username or password");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResponse);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error during login: " + e.getMessage());
        }
    }

    /**
     * POST /api/auth/verify - Verify if user is admin
     * Request body: {"username": "..."}
     */
    @PostMapping("/verify")
    public ResponseEntity<?> verifyAdmin(@RequestBody Map<String, String> request) {
        try {
            String username = request.get("username");
            if (username == null || username.isEmpty()) {
                return ResponseEntity.badRequest().body("Username is required");
            }

            boolean isAdmin = adminService.isAdmin(username);
            Map<String, Object> response = new HashMap<>();
            response.put("isAdmin", isAdmin);
            response.put("username", username);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error verifying admin: " + e.getMessage());
        }
    }

    /**
     * GET /api/auth/health - Health check endpoint
     */
    @GetMapping("/health")
    public ResponseEntity<?> health() {
        Map<String, String> response = new HashMap<>();
        response.put("status", "OK");
        response.put("message", "Authentication service is running");
        return ResponseEntity.ok(response);
    }
}
