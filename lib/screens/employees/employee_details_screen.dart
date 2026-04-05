import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firestore_service.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final String userId;
  final String employeeId;
  final Map<String, dynamic> employeeData;

  const EmployeeDetailsScreen({
    super.key,
    required this.userId,
    required this.employeeId,
    required this.employeeData,
  });

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/edit-employee',
                arguments: {
                  'userId': widget.userId,
                  'employeeId': widget.employeeId,
                  'data': widget.employeeData,
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with employee info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Text(
                      (widget.employeeData['name'] as String? ?? 'E')[0]
                          .toUpperCase(),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.employeeData['name'] ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.employeeData['position'] ?? 'No position',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Employee information
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Information',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    icon: Icons.email,
                    label: 'Email',
                    value: widget.employeeData['email'] ?? 'Not provided',
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    icon: Icons.phone,
                    label: 'Phone',
                    value: widget.employeeData['phone'] ?? 'Not provided',
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    icon: Icons.domain,
                    label: 'Department',
                    value: widget.employeeData['department'] ?? 'Not provided',
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    icon: Icons.work,
                    label: 'Status',
                    value: widget.employeeData['status'] ?? 'active',
                  ),
                  const SizedBox(height: 32),

                  // Activity Section
                  Text(
                    'Recent Activity',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildActivitySection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivitySection() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestoreService.getActivities(widget.userId, widget.employeeId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final activities = snapshot.data?.docs ?? [];

        if (activities.isEmpty) {
          return Text(
            'No activities recorded yet',
            style: TextStyle(color: Colors.grey[600]),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];
            final data = activity.data() as Map<String, dynamic>;

            return ListTile(
              leading: Icon(Icons.info, color: Colors.blue[600]),
              title: Text(data['type'] ?? 'Activity'),
              subtitle: Text(data['description'] ?? 'No description'),
              trailing: Text(
                _formatTime(data['timestamp']),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          },
        );
      },
    );
  }

  String _formatTime(dynamic timestamp) {
    if (timestamp == null) return 'Unknown';
    if (timestamp is Timestamp) {
      return timestamp.toDate().toString().split('.')[0];
    }
    return 'Unknown';
  }
}
