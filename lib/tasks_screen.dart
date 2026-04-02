import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_course/app_colors.dart';
import 'package:flutter_course/task_details.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksScreen extends StatefulWidget {
  TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  // bool isChecked = false;
  String dropdownValue = 'All';
  List<Task> tasks = [];

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff63D9F3),
        onPressed: () {
          final TextEditingController titleController = TextEditingController();
          final TextEditingController descController = TextEditingController();
          DateTime? selectedDate;
          TimeOfDay? selectedTime;

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setModalState) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Create New Task',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: titleController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Color(0xff05243E),
                              filled: true,
                              labelText: 'Task Title',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: descController,

                            maxLines: 4,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Color(0xff05243E),
                              filled: true,
                              labelText: 'Description',
                              labelStyle: TextStyle(color: Colors.white),
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          selectedDate ?? DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now().add(
                                        Duration(days: 365),
                                      ),
                                    );
                                    if (picked != null) {
                                      setModalState(() {
                                        selectedDate = picked;
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.calendar_today),
                                  label: Text(
                                    selectedDate == null
                                        ? 'Pick Date'
                                        : DateFormat(
                                            'yyyy / MM / dd',
                                          ).format(selectedDate!),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff1253AA),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    final pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime:
                                          selectedTime ?? TimeOfDay.now(),
                                    );
                                    if (pickedTime != null) {
                                      setModalState(() {
                                        selectedTime = pickedTime;
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.access_time),
                                  label: Text(
                                    selectedTime == null
                                        ? 'Pick Time'
                                        : selectedTime!.format(context),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff1253AA),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.grey),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Cancel'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (titleController.text.isNotEmpty &&
                                        descController.text.isNotEmpty &&
                                        selectedDate != null &&
                                        selectedTime != null) {
                                      setState(() {
                                        tasks.add(
                                          Task(
                                            title: titleController.text,
                                            description: descController.text,
                                            date: selectedDate!,
                                            time: selectedTime!,
                                          ),
                                        );
                                      });
                                      saveTasks(tasks);
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Please fill all fields!',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff63D9F3),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Create'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
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
                tasks.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: taskUi(tasks[index]),
                            );
                          },
                          itemCount: tasks.length,
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: Text(
                            'No tasks added yet!',
                            style: TextStyle(
                              color: AppColors.font.withOpacity(0.5),
                              fontSize: 16,
                            ),
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

  Widget taskUi(Task task) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskDetails(task: task)),
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
                children: [
                  Text(task.title),
                  Row(
                    children: [
                      Text(DateFormat('yyyy / MM / dd').format(task.date)),
                      SizedBox(width: 10),
                      Text(task.time.format(context)),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios_rounded),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    log("List<Task> is: ");
    log(tasks.toString());
    final taskList = tasks
        .map(
          (task) => {
            'title': task.title,
            'description': task.description,
            'date': task.date.toIso8601String(),
            'time': '${task.time.hour}:${task.time.minute}', // 7:30
          },
        )
        .toList();

    log("List<Map> is");
    log(taskList.toString());

    await prefs.setString('tasks', jsonEncode(taskList));
  }

  Future<void> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    log("String is : $tasksString");
    if (tasksString != null) {
      final List<dynamic> taskList = jsonDecode(tasksString);
      log("List<Map> is : $taskList");
      setState(() {
        tasks = taskList
            .map(
              (task) => Task(
                title: task['title'],
                description: task['description'],
                date: DateTime.parse(task['date']),
                time: TimeOfDay(
                  hour: int.parse(task['time'].split(':')[0]),
                  minute: int.parse(task['time'].split(':')[1]),
                ),
              ),
            )
            .toList();
      });
    }
  }
}

class Task {
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;

  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
  });
}
