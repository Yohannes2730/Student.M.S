import 'package:flutter/material.dart';

class AssignStudentScreen extends StatelessWidget {
  const AssignStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assign Student')),
      body: const Center(
        child: Text('Assign student to class here'),
      ),
    );
  }
}