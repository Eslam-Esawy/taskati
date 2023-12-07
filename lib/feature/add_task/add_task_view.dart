import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/app_colors.dart';
import 'package:taskati/core/styles.dart';
import 'package:taskati/feature/home/home_view.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  var titleCon = TextEditingController();
  var noteCon = TextEditingController();
  late DateTime _date;
  String? _startTime;
  String? _endTime;

  @override
  void initState() {
    super.initState();
    _date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: const Text('Add Task'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title', style: getTitleStyle()),
              TextFormField(
                controller: titleCon,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Title must not be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Text('Note', style: getTitleStyle()),
              TextFormField(
                controller: noteCon,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Note must not be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Text('Date', style: getTitleStyle()),
              TextFormField(
                controller:
                    TextEditingController(text: DateFormat.yMd().format(_date)),
                style: getHeadLineStyle(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Date must not be empty';
                  }
                  return null;
                },
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () async {
                      final datePicked = await showDatePicker(
                        currentDate: DateTime.now(),
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2050),
                      );
                      if (datePicked != null) {
                        setState(() {
                          _date = datePicked;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.calendar_month,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  hintText: DateFormat.yMd().format(_date),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Text('Start Time', style: getTitleStyle())),
                  Expanded(child: Text('End Time', style: getTitleStyle())),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(text: _startTime),
                      style: getHeadLineStyle(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Start time must not be empty';
                        }
                        return null;
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            final timePicked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (timePicked != null) {
                              setState(() {
                                _startTime = timePicked.format(context);
                              });
                            }
                          },
                          icon: Icon(
                            Icons.watch_later_outlined,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        hintText: _startTime,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(text: _endTime),
                      style: getHeadLineStyle(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'End time must not be empty';
                        }
                        return null;
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            final timePicked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (timePicked != null) {
                              setState(() {
                                _endTime = timePicked.format(context);
                              });
                            }
                          },
                          icon: Icon(
                            Icons.watch_later_outlined,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        hintText: _endTime,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              //Choosing the color
              Text(
                'Color',
                style: getTitleStyle(),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.redColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.orangeColor,
                    ),
                  ),
                  const Spacer(),

                  //Create Task button
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeView()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: 110,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Text('Create Task',
                          style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
