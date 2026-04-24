import 'package:flutter/material.dart';
import '../../../shared/widgets/dashboard_sidebar.dart';

class ManageClasses extends StatefulWidget {
  const ManageClasses({super.key});

  @override
  _ManageClassesState createState() => _ManageClassesState();
}

class _ManageClassesState extends State<ManageClasses> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sidebarItems = [
      SidebarItem(label: 'Dashboard', icon: Icons.dashboard, route: '/admin_dashboard'),
      SidebarItem(label: 'Manage Students', icon: Icons.people, route: '/manage_students'),
      SidebarItem(label: 'Manage Classes', icon: Icons.class_, route: '/manage_classes'),
      SidebarItem(label: 'Reports', icon: Icons.assessment, route: '/reports_screen'),
      SidebarItem(label: 'Approve Permissions', icon: Icons.approval, route: '/approve_permission'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Classes'),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      drawer: DashboardSidebar(
        currentRoute: '/manage_classes',
        items: sidebarItems,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Classes Management',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _showAddClassDialog(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Class'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search classes...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              // Classes grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: _buildClassCards(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildClassCards() {
    // Placeholder data
    final classes = [
      {'id': 'CLASS001', 'name': 'Class 10-A', 'students': 35, 'teacher': 'Mr. Smith'},
      {'id': 'CLASS002', 'name': 'Class 10-B', 'students': 32, 'teacher': 'Mrs. Johnson'},
      {'id': 'CLASS003', 'name': 'Class 9-A', 'students': 38, 'teacher': 'Mr. Brown'},
      {'id': 'CLASS004', 'name': 'Class 9-B', 'students': 36, 'teacher': 'Ms. Davis'},
    ];

    return classes.map((cls) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cls['name'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: ${cls['id']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.people, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text('${cls['students']} students'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.person, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(cls['teacher'] as String),
                ],
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  void _showAddClassDialog(BuildContext context) {
    final nameController = TextEditingController();
    final teacherController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Class'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Class Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: teacherController,
                decoration: const InputDecoration(labelText: 'Teacher Name'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Class added successfully')),
              );
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}