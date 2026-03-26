import 'package:flutter/material.dart';
import 'package:flutter_course/app_colors.dart';
import 'package:flutter_course/task_details.dart';

class TasksScreen extends StatefulWidget {
  TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  // bool isChecked = false;
  String dropdownValue = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.fl,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {},
      ),
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        // obscureText: isChecked,
                        decoration: InputDecoration(
                          labelText: 'Search',
                          labelStyle: TextStyle(
                            color: AppColors.font.withOpacity(0.5),
                          ),
                          hintStyle: TextStyle(
                            color: AppColors.font.withOpacity(0.5),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.font.withOpacity(0.5),
                          ),
                          // suffixIcon: IconButton(
                          //   onPressed: () {
                          //     setState(() {
                          //       isChecked = !isChecked;
                          //     });
                          //   },
                          //   icon: Icon(
                          //     isChecked
                          //         ? Icons.visibility_outlined
                          //         : Icons.visibility_off_outlined,
                          //   ),
                          // ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField(
                        borderRadius: BorderRadius.circular(8),
                        style: TextStyle(color: AppColors.font),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        isExpanded: true,
                        value: dropdownValue,
                        items: [
                          DropdownMenuItem(value: 'All', child: Text('All')),
                          DropdownMenuItem(
                            value: 'Today',
                            child: Text('Today'),
                          ),
                          DropdownMenuItem(
                            value: 'Tomorrow',
                            child: Text('Tomorrow'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value!; // Update the selected value
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 46),
                Text(
                  'Tasks List',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.font,
                  ),
                ),
                SizedBox(height: 19),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: taskUi(),
                      );
                    },
                    itemCount: 5,
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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskDetails()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Client meeting'), Text('Tomorrow | 10:30pm')],
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
