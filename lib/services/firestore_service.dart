import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // User operations
  Future<DocumentSnapshot?> getUserData(String userId) async {
    try {
      return await _db.collection('users').doc(userId).get();
    } catch (e) {
      throw 'Error getting user data: $e';
    }
  }

  // Employee operations
  Future<void> addEmployee(String userId, Map<String, dynamic> employeeData) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('employees')
          .add({
        ...employeeData,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'Error adding employee: $e';
    }
  }

  Future<void> updateEmployee(
      String userId, String employeeId, Map<String, dynamic> data) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('employees')
          .doc(employeeId)
          .update({...data, 'updatedAt': FieldValue.serverTimestamp()});
    } catch (e) {
      throw 'Error updating employee: $e';
    }
  }

  Stream<QuerySnapshot> getEmployees(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('employees')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> deleteEmployee(String userId, String employeeId) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('employees')
          .doc(employeeId)
          .delete();
    } catch (e) {
      throw 'Error deleting employee: $e';
    }
  }

  // Activity/Attendance operations
  Future<void> recordActivity(
      String userId, String employeeId, Map<String, dynamic> activityData) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('employees')
          .doc(employeeId)
          .collection('activities')
          .add({
        ...activityData,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'Error recording activity: $e';
    }
  }

  Stream<QuerySnapshot> getActivities(String userId, String employeeId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('employees')
        .doc(employeeId)
        .collection('activities')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Counter operations
  Future<void> addCounter(Map<String, dynamic> counterData) async {
    try {
      await _db.collection('counter').add({
        ...counterData,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'Error adding counter: $e';
    }
  }

  Stream<QuerySnapshot> getCounters() {
    return _db
        .collection('counter')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Generic operations
  Future<void> addData(String collection, Map<String, dynamic> data) async {
    try {
      await _db.collection(collection).add({
        ...data,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'Error adding data: $e';
    }
  }

  Stream<QuerySnapshot> getData(String collection) {
    return _db.collection(collection).orderBy('timestamp', descending: true).snapshots();
  }
}
