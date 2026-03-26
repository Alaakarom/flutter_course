import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Details')),
      body: InkWell(
        onTap: () {
          setShared();
        },
        child: Column(children: []),
      ),
    );
  }

  void setShared() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString('name', 'loqman');
  }
}
