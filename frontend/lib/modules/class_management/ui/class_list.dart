import 'package:flutter/material.dart';

class ClassListScreen extends StatelessWidget {
  const ClassListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Class List')),
      body: const Center(
        child: Text('List of classes here'),
      ),
    );
  }
}