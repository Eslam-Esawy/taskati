import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/app_colors.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/styles.dart';
import 'package:taskati/feature/add_task/add_task_view.dart';
import 'package:taskati/feature/home/widgets/home_header.dart';
import 'package:taskati/feature/home/widgets/task_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

DateTime _selectedValue = DateTime.now();

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Greeting and profile picture
              const HomeHeader(),
              const SizedBox(height: 15),

              // Date & Time and Add Task button
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.MMMMEEEEd().format(DateTime.now()),
                        style: getTitleStyle(),
                      ),
                      Text(
                        'Today',
                        style: getTitleStyle(),
                      ),
                    ],
                  ),
                  const Spacer(),

                  //Container b2a
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AddTaskView()));
                    },
                    child: Container(
                      height: 45,
                      width: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.primaryColor),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          Text(
                            'Add Task',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),

              //Calender
              DatePicker(
                height: 100,
                width: 70,
                DateTime.now(),
                initialSelectedDate: _selectedValue,
                selectionColor: AppColors.primaryColor,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    _selectedValue = date;
                  });
                },
              ),

              const SizedBox(height: 20),

              //Tasks boxes
              ValueListenableBuilder(
                valueListenable: Hive.box<Task>('task').listenable(),
                builder: (BuildContext context, value, Widget? child) {
                  List<int> indexs = [];
                  int index = 0;
                  List<Task> tasks = value.values.where((element) {
                    index++;
                    if (element.date.split('T').first ==
                        _selectedValue.toIso8601String().split('T').first) {
                      indexs.add(index);
                      return true;
                    } else {
                      return false;
                    }
                  }).toList();
                  if (value.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/empty.png'),
                          const SizedBox(height: 20),
                          const Text('No tasks to do')
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          Task item = tasks[index];
                          return Dismissible(
                              key: UniqueKey(),
                              secondaryBackground: Container(
                                color: Colors.red,
                                child: const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.delete_forever_rounded,
                                          color: Colors.white),
                                      Text('Delete Task',
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ),
                              ),
                              background: Container(
                                color: Colors.green,
                                child: const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    children: [
                                      Icon(Icons.check, color: Colors.white),
                                      Text('Task Completed',
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ),
                              ),
                              onDismissed: (direction) {
                                if (direction == DismissDirection.startToEnd) {
                                  setState(() {
                                    value.putAt(
                                        indexs[index],
                                        Task(
                                            title: item.title,
                                            note: item.note,
                                            date: item.date,
                                            startTime: item.startTime,
                                            endTime: item.endTime,
                                            color: 3,
                                            isComplete: true));
                                  });
                                } else {
                                  setState(() {
                                    value.deleteAt(index);
                                  });
                                }
                              },
                              child: TaskItem(task: item));
                        },
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
