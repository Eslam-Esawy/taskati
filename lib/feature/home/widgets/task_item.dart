import 'package:flutter/material.dart';
import 'package:taskati/core/app_colors.dart';
import 'package:taskati/core/model/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
  });

  final Task task;

  Color getColor(int index) {
    switch (index) {
      case 0:
        return AppColors.primaryColor;

      case 1:
        return AppColors.orangeColor;

      case 2:
        return AppColors.redColor;

      case 3:
        return Colors.green;

      default:
        return AppColors.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: getColor(task.color)),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    size: 22,
                    color: AppColors.lightBG,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${task.startTime}: ${task.endTime}',
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                task.note,
                style:
                    const TextStyle(color: Color.fromARGB(255, 244, 225, 225)),
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 2,
            height: 80,
            color: Colors.white,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task.isComplete ? 'COMPLETED' : 'TO DO',
              style: TextStyle(color: AppColors.lightBG),
            ),
          )
        ],
      ),
    );
  }
}
