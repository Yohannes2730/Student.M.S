import 'package:flutter/material.dart';
import '../../../shared/widgets/dashboard_sidebar.dart';

class ManageStudents extends StatefulWidget {
  const ManageStudents({super.key});

  @override
  _ManageStudentsState createState() => _ManageStudentsState();
}

class _ManageStudentsState extends State<ManageStudents> {
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
        title: const Text('Manage Students'),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      drawer: DashboardSidebar(
        currentRoute: '/manage_students',
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
                    'Students List',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _showAddStudentDialog(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Student'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search students...',
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
              // Students list table
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Student ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Class')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: _buildStudentRows(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DataRow> _buildStudentRows() {
    // Placeholder data - replace with actual data from API
    final students = [
      {'id': 'STU001', 'name': 'John Doe', 'email': 'john@example.com', 'class': '10-A'},
      {'id': 'STU002', 'name': 'Jane Smith', 'email': 'jane@example.com', 'class': '10-B'},
      {'id': 'STU003', 'name': 'Bob Johnson', 'email': 'bob@example.com', 'class': '10-A'},
    ];

    return students.map((student) {
      return DataRow(
        cells: [
          DataCell(Text(student['id']!)),
          DataCell(Text(student['name']!)),
          DataCell(Text(student['email']!)),
          DataCell(Text(student['class']!)),
          DataCell(Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit student')),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Delete student')),
                ),
              ),
            ],
          )),
        ],
      );
    }).toList();
  }

  void _showAddStudentDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final studentIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Student'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: studentIdController,
                decoration: const InputDecoration(labelText: 'Student ID'),
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
                const SnackBar(content: Text('Student added successfully')),
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