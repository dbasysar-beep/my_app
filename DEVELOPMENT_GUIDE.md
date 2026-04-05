# Employee Monitoring Flutter App

A comprehensive Flutter application for employee monitoring and management with Firebase backend integration.

## Features Implemented

### 1. **Firebase Authentication**
   - User registration with email and password
   - Secure login functionality
   - Password reset capability
   - Session management with Firebase Auth

### 2. **Authentication Screens**
   - **Login Screen**: Email and password validation
   - **Signup Screen**: Registration with password confirmation
   - Auto-redirect based on authentication status

### 3. **Firestore Database Operations**
   - **Create**: Add new employees with details (name, email, phone, position, department)
   - **Read**: Stream real-time employee data
   - **Update**: Edit employee information
   - **Delete**: Remove employees from the system
   - **Activity Tracking**: Record and view employee activities

### 4. **App Screens**

   #### Dashboard/Home Screen
   - Bottom navigation with 3 tabs: Employees, Activity, Add
   - View all employees in a list
   - Quick actions (edit, delete) for each employee
   - Sync with backend API
   - Logout functionality

   #### Employee Management Screens
   - **Add Employee**: Form to create new employees
   - **Edit Employee**: Update employee details
   - **Employee Details**: View complete employee info and activity history
   - Real-time data binding with Firestore

   #### Authentication Screens
   - Fully styled login and signup screens
   - Error handling and validation
   - Loading states during requests

### 5. **Modern UI/Theme**
   - Professional color scheme (Indigo primary, Purple secondary)
   - Consistent styling across all screens
   - Material Design 3 compliant
   - Custom button and input field styles
   - Responsive layout for different screen sizes

### 6. **State Management**
   - Provider pattern for authentication state
   - Reactive UI updates
   - Stream-based Firestore integration

### 7. **Backend Integration**
   - HTTP client for REST API calls
   - Endpoints for employee management
   - Attendance tracking
   - Report generation
   - Configurable API base URL (currently localhost:8080)

## Project Structure

```
lib/
├── main.dart                    # App entry point and routing
├── firebase_options.dart        # Firebase config (auto-generated)
├── theme/
│   └── app_theme.dart          # Global theme and colors
├── services/
│   ├── auth_service.dart       # Firebase authentication logic
│   ├── firestore_service.dart  # Firestore database operations
│   └── api_service.dart        # Backend API integration
├── providers/
│   └── auth_provider.dart      # Auth state management with Provider
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   └── employees/
│       ├── add_employee_screen.dart
│       ├── edit_employee_screen.dart
│       └── employee_details_screen.dart
└── pubspec.yaml               # Dependencies
```

## Dependencies

- **firebase_core** (3.15.0): Firebase initialization
- **firebase_auth** (5.1.0): User authentication
- **cloud_firestore** (5.6.12): Database operations
- **provider** (6.0.0): State management
- **http** (1.1.0): API client
- **shared_preferences** (2.2.0): Local storage
- **cupertino_icons** (1.0.8): iOS icons

## Getting Started

### Prerequisites
- Flutter >= 3.10.8
- Firebase project setup
- Android/iOS development environments (optional)

### Installation

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Configure Firebase**:
   - Ensure `lib/firebase_options.dart` is properly generated
   - Replace with your Firebase config if needed

3. **Run the app**:
   ```bash
   flutter run
   ```

   Or on a specific device:
   ```bash
   flutter run -d <device-id>
   ```

## Usage

### Authentication Flow
1. Launch app → redirects to Login/Signup
2. Sign up with email and password
3. After successful signup, automatically logged in
4. Dashboard shows all employees

### Employee Management
1. **Add Employee**: Click add button, fill employee details
2. **View Details**: Tap on an employee card
3. **Edit Employee**: Click edit icon in employee details
4. **Delete Employee**: Long press or use menu option

### Syncing with Backend
- Click "Sync with Backend" in the Add tab
- App fetches data from configured API endpoint
- Shows success/error notifications

## API Configuration

To use the backend integration, update the base URL in [services/api_service.dart](services/api_service.dart):

```dart
static const String baseUrl = 'http://localhost:8080/api';
// Change to your production URL
```

### Available API Endpoints
- `GET /employees` - Get all employees
- `GET /employees/:id` - Get specific employee
- `POST /employees` - Create employee
- `PUT /employees/:id` - Update employee
- `DELETE /employees/:id` - Delete employee
- `GET /attendance` - Get attendance logs
- `POST /attendance` - Record attendance
- `GET /reports` - Get reports

## Available Routes

- `/login` - Login screen
- `/signup` - Signup screen
- `/home` - Home/Dashboard screen
- `/add-employee` - Add new employee
- `/edit-employee` - Edit existing employee
- `/employee-details` - View employee details

## Firestore Structure

```
users/
├── {userId}/
│   ├── employees/
│   │   ├── {employeeId}/
│   │   │   ├── name: string
│   │   │   ├── email: string
│   │   │   ├── phone: string
│   │   │   ├── position: string
│   │   │   ├── department: string
│   │   │   ├── status: string (active/inactive)
│   │   │   ├── createdAt: timestamp
│   │   │   └── updatedAt: timestamp
│   │   │   └── activities/
│   │   │       ├── {activityId}/
│   │   │       │   ├── type: string
│   │   │       │   ├── description: string
│   │   │       │   └── timestamp: timestamp
```

## Error Handling

- **Auth Errors**: User-friendly error messages for login/signup failures
- **Network Errors**: Timeout handling for API calls (10 seconds)
- **Database Errors**: Try-catch blocks for Firestore operations
- **Form Validation**: Email format, password strength, required fields

## Future Enhancements

- [ ] Photo/Avatar upload for employees
- [ ] Advanced filtering and search
- [ ] Export reports to PDF
- [ ] Push notifications for events
- [ ] Offline data sync
- [ ] Two-factor authentication
- [ ] Admin and user roles
- [ ] Dark mode support
- [ ] Multi-language support
- [ ] Analytics and dashboards

## Security Notes

- Firestore security rules should be configured
- API endpoints should use HTTPS in production
- Sensitive data should be encrypted
- User input is validated on client side
- Server-side validation required for production

## Troubleshooting

### Firebase Initialization Error
- Verify Firebase config in `firebase_options.dart`
- Check internet connection
- Ensure Firebase project is active

### Dependency Resolution Failed
```bash
flutter pub get
flutter pub upgrade
```

### App Not Starting
```bash
flutter clean
flutter pub get
flutter run -v
```

## Contributing

1. Create feature branches
2. Follow Flutter/Dart conventions
3. Test on multiple devices
4. Document changes

## License

This project is open source and available under MIT license.

## Support

For issues and questions, please contact the development team or create an issue in the project repository.
