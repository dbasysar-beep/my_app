import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/employees/add_employee_screen.dart';
import 'screens/employees/edit_employee_screen.dart';
import 'screens/employees/employee_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully!');
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  runApp(const MyApp());
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
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => const HomeScreen(),
          '/add-employee': (context) => const AddEmployeeScreen(),
          '/edit-employee': (context) {
            final args = ModalRoute.of(context)?.settings.arguments as Map?;
            return EditEmployeeScreen(
              userId: args?['userId'] ?? '',
              employeeId: args?['employeeId'] ?? '',
              employeeData: args?['data'] ?? {},
            );
          },
          '/employee-details': (context) {
            final args = ModalRoute.of(context)?.settings.arguments as Map?;
            return EmployeeDetailsScreen(
              userId: args?['userId'] ?? '',
              employeeId: args?['employeeId'] ?? '',
              employeeData: args?['employeeData'] ?? {},
            );
          },
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        // Check if user is authenticated
        if (authProvider.isAuthenticated) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}