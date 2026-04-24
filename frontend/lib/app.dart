import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/providers/auth_provider.dart';
import 'shared/theme/app_theme.dart';
import 'modules/auth/ui/splash_screen.dart';
import 'modules/auth/ui/login_screen.dart';
import 'modules/auth/ui/register_screen.dart';
import 'modules/admin/ui/admin_dashboard.dart';
import 'modules/admin/ui/manage_students.dart';
import 'modules/admin/ui/manage_classes.dart';
import 'modules/admin/ui/reports_screen.dart';
import 'modules/student/ui/student_dashboard.dart';
import 'modules/student/ui/attendance_view.dart';
import 'modules/student/ui/progress_view.dart';
import 'modules/parent/ui/parent_dashboard.dart';
import 'modules/parent/ui/child_attendance.dart';
import 'modules/parent/ui/alerts_screen.dart';
import 'modules/permission/ui/request_permission.dart';
import 'modules/permission/ui/approve_permission.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Student Management System',
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          // Admin routes
          '/admin_dashboard': (context) => const AdminDashboard(),
          '/manage_students': (context) => const ManageStudents(),
          '/manage_classes': (context) => const ManageClasses(),
          '/reports_screen': (context) => const ReportsScreen(),
          // Student routes
          '/student_dashboard': (context) => const StudentDashboard(),
          '/attendance_view': (context) => const AttendanceView(),
          '/progress_view': (context) => const ProgressView(),
          '/request_permission': (context) => const RequestPermission(),
          // Parent routes
          '/parent_dashboard': (context) => const ParentDashboard(),
          '/child_attendance': (context) => const ChildAttendance(),
          '/alerts_screen': (context) => const AlertsScreen(),
          // Permission routes
          '/approve_permission': (context) => const ApprovePermission(),
        },
      ),
    );
  }
}