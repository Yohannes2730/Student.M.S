import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/services/rbac_service.dart';

class RoleBasedWidget extends StatelessWidget {
  final String requiredRole;
  final Widget child;
  final Widget? fallback;

  const RoleBasedWidget({
    Key? key,
    required this.requiredRole,
    required this.child,
    this.fallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        if (authProvider.user == null) {
          return fallback ?? const Scaffold(
            body: Center(
              child: Text('Please log in first'),
            ),
          );
        }

        if (authProvider.user!.role != requiredRole) {
          return fallback ?? Scaffold(
            body: Center(
              child: Text(
                'You do not have access to this resource.\nYour role: ${authProvider.user!.role}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return child;
      },
    );
  }
}

class RoleBasedAction extends StatelessWidget {
  final String requiredRole;
  final VoidCallback? onPressed;
  final Widget child;
  final bool show;

  const RoleBasedAction({
    Key? key,
    required this.requiredRole,
    this.onPressed,
    required this.child,
    this.show = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final hasPermission = authProvider.user != null && 
            authProvider.user!.role == requiredRole;

        if (!show || !hasPermission) {
          return const SizedBox.shrink();
        }

        return GestureDetector(
          onTap: hasPermission ? onPressed : null,
          child: Opacity(
            opacity: hasPermission ? 1.0 : 0.5,
            child: child,
          ),
        );
      },
    );
  }
}

class PermissionBasedWidget extends StatelessWidget {
  final String permission;
  final Widget child;
  final Widget? fallback;

  const PermissionBasedWidget({
    Key? key,
    required this.permission,
    required this.child,
    this.fallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        if (authProvider.user == null) {
          return fallback ?? const SizedBox.shrink();
        }

        if (!RbacService.hasPermission(authProvider.user!, permission)) {
          return fallback ?? const SizedBox.shrink();
        }

        return child;
      },
    );
  }
}
