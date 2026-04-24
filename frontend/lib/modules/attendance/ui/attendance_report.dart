import 'package:flutter/material.dart';
import '../data/attendance_repository.dart';
import '../model/attendance_model.dart';

class AttendanceReportScreen extends StatefulWidget {
  const AttendanceReportScreen({super.key});

  @override
  _AttendanceReportScreenState createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  final AttendanceRepository _repository = AttendanceRepository();
  List<Attendance> _attendance = [];
  final _studentIdController = TextEditingController();

  Future<void> _loadAttendance() async {
    final attendance = await _repository.getAttendance(_studentIdController.text);
    setState(() => _attendance = attendance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Report')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _studentIdController,
              decoration: const InputDecoration(labelText: 'Student ID'),
            ),
            ElevatedButton(
              onPressed: _loadAttendance,
              child: const Text('Load Report'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _attendance.length,
                itemBuilder: (context, index) {
                  final att = _attendance[index];
                  return ListTile(
                    title: Text('Date: ${att.date}'),
                    subtitle: Text('Present: ${att.present}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}