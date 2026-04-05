import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/auth_provider.dart';
import '../../services/firestore_service.dart';
import '../../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final ApiService _apiService = ApiService();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Monitor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().signOut();
            },
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          final userId = authProvider.user?.uid;
          
          if (userId == null) {
            return const Center(child: Text('Not authenticated'));
          }

          return _buildBody(userId);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Employees',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Add',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 2
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add-employee');
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildBody(String userId) {
    return IndexedStack(
      index: _selectedIndex,
      children: [
        _buildEmployeesTab(userId),
        _buildActivityTab(userId),
        _buildAddTab(userId),
      ],
    );
  }

  Widget _buildEmployeesTab(String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestoreService.getEmployees(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final employees = snapshot.data?.docs ?? [];

        if (employees.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_add,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No employees yet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Add your first employee to get started',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: employees.length,
          itemBuilder: (context, index) {
            final employee = employees[index];
            final data = employee.data() as Map<String, dynamic>;

            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    (data['name'] as String? ?? 'E')[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(data['name'] ?? 'Unknown'),
                subtitle: Text(data['position'] ?? 'No position'),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text('Edit'),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/edit-employee',
                          arguments: {
                            'userId': userId,
                            'employeeId': employee.id,
                            'data': data,
                          },
                        );
                      },
                    ),
                    PopupMenuItem(
                      child: const Text('Delete'),
                      onTap: () {
                        _showDeleteDialog(context, userId, employee.id);
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/employee-details',
                    arguments: {
                      'userId': userId,
                      'employeeId': employee.id,
                      'employeeData': data,
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildActivityTab(String userId) {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh logic
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timeline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Activity Timeline',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'View employee activity logs',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddTab(String userId) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/add-employee');
            },
            icon: const Icon(Icons.person_add),
            label: const Text('Add Employee'),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              _syncWithBackend(userId);
            },
            icon: const Icon(Icons.cloud_sync),
            label: const Text('Sync with Backend'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String userId, String employeeId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Employee'),
        content: const Text('Are you sure you want to delete this employee?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await _firestoreService.deleteEmployee(userId, employeeId);
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Employee deleted')),
                  );
                }
              } catch (e) {
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _syncWithBackend(String userId) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Syncing with backend...')),
      );
      
      final data = await _apiService.getEmployees();
      print('Backend data: $data');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sync completed successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sync error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
