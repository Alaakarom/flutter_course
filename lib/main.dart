import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    print('welcome');
    return MaterialApp(
      home: Scaffold(
        backgroundColor: isDark? Colors.blue :  Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Image.network(
                  'https://img.freepik.com/free-photo/lavender-field-sunset-near-valensole_268835-3910.jpg?semt=ais_hybrid&w=740&q=80'
                ),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'الطلاب'
                  ),
                  SizedBox(width: 15,),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        isDark = !isDark;
                      });
                      print(isDark);
                    },
                    child: Text('add student'))
                ],
              ),
              
            ],
          ),
        )
      ),
    );
    
  }
}