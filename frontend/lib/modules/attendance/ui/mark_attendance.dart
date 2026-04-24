import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_button.dart';
import '../data/attendance_repository.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  _MarkAttendanceScreenState createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  final AttendanceRepository _repository = AttendanceRepository();
  final _studentIdController = TextEditingController();
  bool _present = true;

  Future<void> _markAttendance() async {
    await _repository.markAttendance(_studentIdController.text, _present);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Attendance marked')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mark Attendance')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _studentIdController,
              decoration: const InputDecoration(labelText: 'Student ID'),
            ),
            Row(
              children: [
                const Text('Present'),
                Switch(
                  value: _present,
                  onChanged: (value) => setState(() => _present = value),
                ),
              ],
            ),
            CustomButton(
              text: 'Mark',
              onPressed: _markAttendance,
            ),
          ],
        ),
      ),
    );
  }
}