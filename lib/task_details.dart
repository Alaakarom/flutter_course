import 'package:flutter/material.dart';
import 'package:flutter_course/tasks_screen.dart';

class TaskDetails extends StatelessWidget {
  Task task;
  TaskDetails({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(title: Text(task.title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(task.title),
            SizedBox(height: 20),
            Text(task.description),
          ],
        ),
      ),
    );
  }
}
