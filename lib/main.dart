import 'package:flutter/material.dart';
import 'package:flutter_course/constants.dart';
import 'package:flutter_course/on_boarding.dart';
import 'package:flutter_course/tasks_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_course/test.dart';
import 'package:flutter_course/add.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getDataFromShared();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Add());
  }
}

Future<void> getDataFromShared() async {
  SharedPreferences sh = await SharedPreferences.getInstance();
  isOpen = sh.getBool('screen') ?? false;
}
//isOpen ? TasksScreen() : OnBoarding()