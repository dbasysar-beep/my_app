import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api';
  
  // Update this based on your backend URL
  // For production: 'https://your-api-domain.com/api'

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      throw 'Error fetching data: $e';
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl$endpoint'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      throw 'Error posting data: $e';
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http
          .put(
            Uri.parse('$baseUrl$endpoint'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      throw 'Error updating data: $e';
    }
  }

  Future<void> delete(String endpoint) async {
    try {
      final response = await http
          .delete(
            Uri.parse('$baseUrl$endpoint'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      throw 'Error deleting data: $e';
    }
  }

  // Employee endpoints
  Future<dynamic> getEmployees() => get('/employees');
  
  Future<dynamic> getEmployee(int id) => get('/employees/$id');
  
  Future<dynamic> createEmployee(Map<String, dynamic> data) => post('/employees', data);
  
  Future<dynamic> updateEmployee(int id, Map<String, dynamic> data) => put('/employees/$id', data);
  
  Future<void> deleteEmployee(int id) => delete('/employees/$id');

  // Attendance endpoints
  Future<dynamic> getAttendance() => get('/attendance');
  
  Future<dynamic> recordAttendance(Map<String, dynamic> data) => post('/attendance', data);

  // Reports endpoints
  Future<dynamic> getReports() => get('/reports');
  
  Future<dynamic> generateReport(Map<String, dynamic> filters) => post('/reports/generate', filters);
}
