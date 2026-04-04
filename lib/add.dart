import 'package:flutter/material.dart';
import 'package:flutter_course/constants.dart';
import 'package:flutter_course/on_boarding.dart';
import 'package:flutter_course/tasks_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_course/app_colors.dart';

class Add extends StatelessWidget {
  const Add({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topEnd,
              end: AlignmentDirectional.bottomStart,
              colors: [AppColors.primary, AppColors.secondary],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xffffffff),
                      ),
                      child: Icon(Icons.arrow_back, color: Color(0xff63D9F3)),
                    ),
                    SizedBox(width: 100),
                    Text(
                      'Settings',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 100),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: taskUi(),
                      );
                    },
                    itemCount: 4,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 220),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout_rounded,
                                color: Color(0xffDC4343),
                              ),
                              Text(
                                "Logout",
                                style: TextStyle(
                                  color: Color(0xffDC4343),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget taskUi() {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.access_time_outlined, color: Colors.white),
            SizedBox(width: 10),
            Text('Profile', style: TextStyle(color: Colors.white)),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: Color(0xff86DAED)),
          ],
        ),
        SizedBox(height: 10),
        Container(color: Color(0xffD9D9D9), height: 0.3),
      ],
    );
  }
}
