import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/app_colors.dart';
import 'package:taskati/core/model/task_model.dart';
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
  final _formKey = GlobalKey<FormState>();

  // initial date, start Time and End Time
  DateTime _date = DateTime.now();
  String? _startTime = DateFormat('hh:mm a').format(DateTime.now());
  String? _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int _selectedColor = 0;

  late Box<Task> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<Task>('task');
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
          child: Form(
            key: _formKey,
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
                    hintText: 'Enter a title here',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                Text('Note', style: getTitleStyle()),
                TextFormField(
                  controller: noteCon,
                  maxLines: 4,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Note must not be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter a note here',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                //Date
                Text('Date', style: getTitleStyle()),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: AppColors.primaryColor),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        final datePicked = await showDatePicker(
                          currentDate: DateTime.now(),
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2050),
                          builder: (context, child) {
                            return Theme(
                                data: ThemeData(
                                    colorScheme: ColorScheme.light(
                                      primary: AppColors.primaryColor,
                                      onPrimary: Colors.white,
                                      onSurface: AppColors.primaryColor,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                      foregroundColor: AppColors.primaryColor,
                                    ))),
                                child: child!);
                          },
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

                //-------Start & End Time------------------
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
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData(
                                        colorScheme: ColorScheme.light(
                                          primary: AppColors.primaryColor,
                                          onPrimary: Colors.black,
                                          onSurface: AppColors.primaryColor,
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                                foregroundColor:
                                                    AppColors.primaryColor))),
                                    child: child!,
                                  );
                                },
                              );
                              if (timePicked != null) {
                                //To be sure that the the end time will be after the start time
                                //we will set the end time automatically 15 mins. after the start date.
                                setState(() {
                                  _startTime = timePicked.format(context);
                                  int plus15Min = timePicked.minute + 15;
                                  _endTime = timePicked
                                      .replacing(minute: plus15Min)
                                      .format(context);
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

                //Choosing a color
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = 0;
                        });
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primaryColor,
                        child: (_selectedColor == 0)
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = 1;
                        });
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.orangeColor,
                        child: (_selectedColor == 1)
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = 2;
                        });
                      },
                      child: CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.redColor,
                          child: (_selectedColor == 2)
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                              : null),
                    ),
                    const Spacer(),

                    //------------Add Task button-------------------------
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await box.add(Task(
                              title: titleCon.text,
                              note: noteCon.text,
                              date: _date.toIso8601String(),
                              startTime: _startTime!,
                              endTime: _endTime!,
                              color: _selectedColor,
                              isComplete: false));
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const HomeView()));
                        }
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
      ),
    );
  }
}
