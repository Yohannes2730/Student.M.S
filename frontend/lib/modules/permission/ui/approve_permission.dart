import 'package:flutter/material.dart';
import '../../../shared/widgets/dashboard_sidebar.dart';

class ApprovePermission extends StatefulWidget {
  const ApprovePermission({super.key});

  @override
  _ApprovePermissionState createState() => _ApprovePermissionState();
}

class _ApprovePermissionState extends State<ApprovePermission> {
  @override
  Widget build(BuildContext context) {
    final sidebarItems = [
      SidebarItem(label: 'Dashboard', icon: Icons.dashboard, route: '/admin_dashboard'),
      SidebarItem(label: 'Manage Students', icon: Icons.people, route: '/manage_students'),
      SidebarItem(label: 'Manage Classes', icon: Icons.class_, route: '/manage_classes'),
      SidebarItem(label: 'Reports', icon: Icons.assessment, route: '/reports_screen'),
      SidebarItem(label: 'Approve Permissions', icon: Icons.approval, route: '/approve_permission'),
    ];

    final permissions = [
      {
        'id': 'PERM001',
        'student': 'John Doe',
        'class': '10-A',
        'reason': 'Medical leave',
        'from': '2024-04-20',
        'to': '2024-04-22',
        'status': 'Pending',
      },
      {
        'id': 'PERM002',
        'student': 'Jane Smith',
        'class': '10-B',
        'reason': 'Family emergency',
        'from': '2024-04-21',
        'to': '2024-04-21',
        'status': 'Pending',
      },
      {
        'id': 'PERM003',
        'student': 'Bob Johnson',
        'class': '9-A',
        'reason': 'Sports event',
        'from': '2024-04-23',
        'to': '2024-04-23',
        'status': 'Approved',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Approve Permissions'),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      drawer: DashboardSidebar(
        currentRoute: '/approve_permission',
        items: sidebarItems,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Permission Requests',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: permissions.length,
                itemBuilder: (context, index) {
                  final perm = permissions[index];
                  final isPending = perm['status'] == 'Pending';
                  final isApproved = perm['status'] == 'Approved';

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isApproved ? Colors.green : Colors.orange,
                        width: 2,
                      ),
                    ),
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
                                    perm['student'] as String,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Class: ${perm['class']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: isApproved
                                      ? Colors.green.shade100
                                      : Colors.orange.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  perm['status'] as String,
                                  style: TextStyle(
                                    color: isApproved ? Colors.green : Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(Icons.note, size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(perm['reason'] as String),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.date_range, size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 8),
                              Text('${perm['from']} to ${perm['to']}'),
                            ],
                          ),
                          if (isPending) ...[
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    onPressed: () => _approvePermission(perm['id']),
                                    child: const Text('Approve'),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () => _rejectPermission(perm['id']),
                                    child: const Text('Reject'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _approvePermission(dynamic permId) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Permission approved successfully')),
    );
  }

  void _rejectPermission(dynamic permId) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Permission rejected')),
    );
  }
}