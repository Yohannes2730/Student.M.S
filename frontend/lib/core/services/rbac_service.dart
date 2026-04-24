import '../../modules/auth/model/user_model.dart';

class RbacService {
  static const String adminRole = 'admin';
  static const String studentRole = 'student';
  static const String parentRole = 'parent';

  static const List<String> validRoles = [adminRole, studentRole, parentRole];

  // Permission checking methods
  static bool hasPermission(User user, String permission) {
    switch (user.role) {
      case adminRole:
        return _adminPermissions().contains(permission);
      case studentRole:
        return _studentPermissions().contains(permission);
      case parentRole:
        return _parentPermissions().contains(permission);
      default:
        return false;
    }
  }

  static bool canAccessRoute(User user, String route) {
    switch (user.role) {
      case adminRole:
        return _adminRoutes().contains(route);
      case studentRole:
        return _studentRoutes().contains(route);
      case parentRole:
        return _parentRoutes().contains(route);
      default:
        return false;
    }
  }

  // Admin permissions
  static List<String> _adminPermissions() => [
    'view_admin_dashboard',
    'manage_students',
    'manage_classes',
    'view_attendance_reports',
    'generate_reports',
    'manage_permissions',
    'view_all_data',
  ];

  // Student permissions
  static List<String> _studentPermissions() => [
    'view_student_dashboard',
    'view_personal_attendance',
    'request_permission',
    'view_academic_progress',
  ];

  // Parent permissions
  static List<String> _parentPermissions() => [
    'view_parent_dashboard',
    'view_child_attendance',
    'receive_alerts',
  ];

  // Admin routes
  static List<String> _adminRoutes() => [
    '/admin_dashboard',
    '/manage_students',
    '/manage_classes',
    '/reports_screen',
    '/approve_permission',
  ];

  // Student routes
  static List<String> _studentRoutes() => [
    '/student_dashboard',
    '/attendance_view',
    '/progress_view',
    '/request_permission',
    '/mark_attendance',
  ];

  // Parent routes
  static List<String> _parentRoutes() => [
    '/parent_dashboard',
    '/child_attendance',
    '/alerts_screen',
  ];

  // Get dashboard route for user role
  static String getDashboardRoute(User user) {
    switch (user.role) {
      case adminRole:
        return '/admin_dashboard';
      case studentRole:
        return '/student_dashboard';
      case parentRole:
        return '/parent_dashboard';
      default:
        return '/login';
    }
  }

  // Check if user can perform an action
  static bool canPerformAction(User user, String action) {
    return hasPermission(user, action);
  }

  // Validate role
  static bool isValidRole(String role) {
    return validRoles.contains(role);
  }
}
