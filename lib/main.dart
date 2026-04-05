import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/dashboards/admin_dashboard.dart';
import 'screens/dashboards/employee_dashboard.dart';
import 'screens/employees/add_employee_screen.dart';
import 'screens/employees/edit_employee_screen.dart';
import 'screens/employees/employee_details_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

Future<FirebaseApp> _initializeFirebase() async {
  final isNativeMobile = !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  if (isNativeMobile) {
    final app = await Firebase.initializeApp();
    print('Firebase native app initialized: ${app.options.projectId} / ${app.options.appId}');
    return app;
  }

  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Firebase options app initialized: ${app.options.projectId} / ${app.options.appId}');
  return app;
}

class FirebaseInitScreen extends StatefulWidget {
  const FirebaseInitScreen({super.key});

  @override
  State<FirebaseInitScreen> createState() => _FirebaseInitScreenState();
}

class _FirebaseInitScreenState extends State<FirebaseInitScreen> {
  late Future<FirebaseApp> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = _initializeFirebase();
  }

  void _retryInitialization() {
    setState(() {
      _initialization = _initializeFirebase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Firebase Setup Error')),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 80,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Unable to initialize Firebase.',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Please check your Firebase project configuration and make sure the correct Android/iOS settings are installed.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    snapshot.error.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _retryInitialization,
                    child: const Text('Retry Initialization'),
                  ),
                ],
              ),
            ),
          );
        }

        return const AuthWrapper();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Employee Monitoring System',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const FirebaseInitScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => const HomeScreen(),
          '/admin-dashboard': (context) => AdminDashboard(),
          '/employee-dashboard': (context) => EmployeeDashboard(),
          '/add-employee': (context) => AddEmployeeScreen(),
          '/edit-employee': (context) {
            final args = ModalRoute.of(context)?.settings.arguments as Map?;
            final authProvider = Provider.of<AuthProvider>(context, listen: false);
            return EditEmployeeScreen(
              userId: authProvider.user?.uid ?? '',
              employeeId: args?['employeeId'] ?? '',
              employeeData: args?['employeeData'] ?? {},
            );
          },
          '/employee-details': (context) {
            final args = ModalRoute.of(context)?.settings.arguments as Map?;
            final authProvider = Provider.of<AuthProvider>(context, listen: false);
            return EmployeeDetailsScreen(
              userId: authProvider.user?.uid ?? '',
              employeeId: args?['employeeId'] ?? '',
              employeeData: args?['employeeData'] ?? {},
            );
          },
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        if (authProvider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (!authProvider.isAuthenticated) {
          return const LoginScreen();
        }

        // Redirect based on user role
        final role = authProvider.userRole;
        if (role == 'admin') {
          return AdminDashboard();
        } else if (role == 'employee') {
          return EmployeeDashboard();
        } else {
          // Default to employee dashboard if role is not set
          return EmployeeDashboard();
        }
      },
    );
  }
}

