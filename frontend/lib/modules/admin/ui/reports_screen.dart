import 'package:flutter/material.dart';
import '../../../shared/widgets/dashboard_sidebar.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedReport = 'attendance';
  DateTimeRange? _dateRange;

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
        title: const Text('Reports'),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      drawer: DashboardSidebar(
        currentRoute: '/reports_screen',
        items: sidebarItems,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Generate Reports',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Report type selection
              const Text(
                'Report Type',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: _selectedReport,
                  isExpanded: true,
                  underline: const SizedBox(),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  items: [
                    DropdownMenuItem(
                      value: 'attendance',
                      child: const Text('Attendance Report'),
                    ),
                    DropdownMenuItem(
                      value: 'performance',
                      child: const Text('Performance Report'),
                    ),
                    DropdownMenuItem(
                      value: 'dismissal',
                      child: const Text('Dismissal Report'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedReport = value ?? 'attendance');
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Date range selector
              const Text(
                'Date Range',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () async {
                  final range = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (range != null) {
                    setState(() => _dateRange = range);
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _dateRange == null
                      ? 'Select Date Range'
                      : '${_dateRange!.start.toLocal()}'.split(' ')[0] +
                          ' to ' +
                          '${_dateRange!.end.toLocal()}'.split(' ')[0],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _generateReport(),
                child: const Text('Generate Report'),
              ),
              const SizedBox(height: 30),
              // Sample report data
              if (_selectedReport == 'attendance')
                _buildAttendanceReport()
              else if (_selectedReport == 'performance')
                _buildPerformanceReport()
              else
                _buildDismissalReport(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceReport() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Class')),
            DataColumn(label: Text('Total Students')),
            DataColumn(label: Text('Present')),
            DataColumn(label: Text('Absent')),
            DataColumn(label: Text('Percentage')),
          ],
          rows: [
            DataRow(cells: [
              const DataCell(Text('10-A')),
              const DataCell(Text('35')),
              const DataCell(Text('33')),
              const DataCell(Text('2')),
              DataCell(Text('94.3%', style: TextStyle(color: Colors.green))),
            ]),
            DataRow(cells: [
              const DataCell(Text('10-B')),
              const DataCell(Text('32')),
              const DataCell(Text('30')),
              const DataCell(Text('2')),
              DataCell(Text('93.8%', style: TextStyle(color: Colors.green))),
            ]),
            DataRow(cells: [
              const DataCell(Text('9-A')),
              const DataCell(Text('38')),
              const DataCell(Text('35')),
              const DataCell(Text('3')),
              DataCell(Text('92.1%', style: TextStyle(color: Colors.orange))),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceReport() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Class')),
            DataColumn(label: Text('Average Score')),
            DataColumn(label: Text('Top Performer')),
            DataColumn(label: Text('Grade')),
          ],
          rows: [
            DataRow(cells: [
              const DataCell(Text('10-A')),
              const DataCell(Text('78.5')),
              const DataCell(Text('John Doe')),
              const DataCell(Text('A')),
            ]),
            DataRow(cells: [
              const DataCell(Text('10-B')),
              const DataCell(Text('75.2')),
              const DataCell(Text('Jane Smith')),
              const DataCell(Text('B+')),
            ]),
            DataRow(cells: [
              const DataCell(Text('9-A')),
              const DataCell(Text('72.8')),
              const DataCell(Text('Bob Johnson')),
              const DataCell(Text('B')),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildDismissalReport() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Student')),
            DataColumn(label: Text('Class')),
            DataColumn(label: Text('Dismissal Reason')),
            DataColumn(label: Text('Date')),
          ],
          rows: [
            DataRow(cells: [
              const DataCell(Text('Student 1')),
              const DataCell(Text('10-A')),
              const DataCell(Text('Low Attendance')),
              const DataCell(Text('2024-04-20')),
            ]),
            DataRow(cells: [
              const DataCell(Text('Student 2')),
              const DataCell(Text('10-B')),
              const DataCell(Text('Poor Performance')),
              const DataCell(Text('2024-04-19')),
            ]),
          ],
        ),
      ),
    );
  }

  void _generateReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Generating $_selectedReport report...'),
      ),
    );
  }
}