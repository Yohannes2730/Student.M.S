import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/auth_provider.dart';

class DashboardSidebar extends StatelessWidget {
  final String currentRoute;
  final List<SidebarItem> items;

  const DashboardSidebar({
    Key? key,
    required this.currentRoute,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              return UserAccountsDrawerHeader(
                accountName: Text(authProvider.user?.name ?? 'User'),
                accountEmail: Text(authProvider.user?.email ?? ''),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    (authProvider.user?.name ?? 'U')[0].toUpperCase(),
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
              );
            },
          ),
          ...items.map((item) {
            final isSelected = currentRoute == item.route;
            return ListTile(
              leading: Icon(
                item.icon,
                color: isSelected ? Colors.blue : Colors.grey,
              ),
              title: Text(item.label),
              selected: isSelected,
              selectedTileColor: Colors.blue.shade50,
              onTap: () {
                Navigator.of(context).pop();
                if (item.route != currentRoute) {
                  Navigator.of(context).pushNamed(item.route);
                }
              },
            );
          }),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () async {
              Navigator.of(context).pop();
              final authProvider = context.read<AuthProvider>();
              await authProvider.logout();
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              }
            },
          ),
        ],
      ),
    );
  }
}

class SidebarItem {
  final String label;
  final IconData icon;
  final String route;

  SidebarItem({
    required this.label,
    required this.icon,
    required this.route,
  });
}
