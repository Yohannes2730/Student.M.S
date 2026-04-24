import 'package:flutter/material.dart';
import '../../../shared/widgets/dashboard_sidebar.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  _AlertsScreenState createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  String _filterBy = 'all';

  @override
  Widget build(BuildContext context) {
    final sidebarItems = [
      SidebarItem(label: 'Dashboard', icon: Icons.dashboard, route: '/parent_dashboard'),
      SidebarItem(label: 'Child Attendance', icon: Icons.check_circle, route: '/child_attendance'),
      SidebarItem(label: 'Alerts', icon: Icons.notifications, route: '/alerts_screen'),
    ];

    final allAlerts = [
      {
        'id': '1',
        'type': 'attendance',
        'child': 'John Doe',
        'title': 'Low Attendance Alert',
        'message': 'John\'s attendance is 85% - below the target of 90%',
        'date': 'April 20, 2024',
        'icon': Icons.warning,
        'color': Colors.orange,
      },
      {
        'id': '2',
        'type': 'performance',
        'child': 'John Doe',
        'title': 'Performance Update',
        'message': 'John\'s average score has improved to 78% in Mathematics',
        'date': 'April 19, 2024',
        'icon': Icons.trending_up,
        'color': Colors.green,
      },
      {
        'id': '3',
        'type': 'assignment',
        'child': 'John Doe',
        'title': 'Assignment Submission Reminder',
        'message': 'Science project assignment due tomorrow',
        'date': 'April 18, 2024',
        'icon': Icons.assignment,
        'color': Colors.blue,
      },
      {
        'id': '4',
        'type': 'attendance',
        'child': 'Jane Doe',
        'title': 'Absence Notification',
        'message': 'Jane was absent on April 17, 2024',
        'date': 'April 17, 2024',
        'icon': Icons.close,
        'color': Colors.red,
      },
      {
        'id': '5',
        'type': 'event',
        'child': 'John Doe',
        'title': 'School Event',
        'message': 'Annual Sports Day on April 25, 2024. Participation required',
        'date': 'April 16, 2024',
        'icon': Icons.event,
        'color': Colors.purple,
      },
    ];

    final filteredAlerts = _filterBy == 'all'
        ? allAlerts
        : allAlerts.where((alert) => alert['type'] == _filterBy).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts & Notifications'),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      drawer: DashboardSidebar(
        currentRoute: '/alerts_screen',
        items: sidebarItems,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter options
              const Text(
                'Filter Alerts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All', 'all'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Attendance', 'attendance'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Performance', 'performance'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Assignments', 'assignment'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Events', 'event'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Alerts list
              if (filteredAlerts.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: [
                        Icon(
                          Icons.notifications_off,
                          size: 64,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No alerts found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ...List.generate(
                filteredAlerts.length,
                (index) {
                  final alert = filteredAlerts[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: (alert['color'] as Color).withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: (alert['color'] as Color).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  alert['icon'] as IconData,
                                  color: alert['color'] as Color,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      alert['title'] as String,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      alert['child'] as String,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            alert['message'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                alert['date'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                              TextButton(
                                onPressed: () => _dismissAlert(alert['id'] as String),
                                child: const Text('Dismiss'),
                              ),
                            ],
                          ),
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

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _filterBy == value;
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
      onSelected: (selected) {
        setState(() => _filterBy = selected ? value : 'all');
      },
    );
  }

  void _dismissAlert(String alertId) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alert dismissed')),
    );
  }
}