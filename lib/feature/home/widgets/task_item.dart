import 'package:flutter/material.dart';
import 'package:taskati/core/app_colors.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.primaryColor),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Task - 1',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                  const Text(
                    '12:00 AM: 12:30',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Note',
                style: TextStyle(color: Color.fromARGB(255, 244, 225, 225)),
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
              'TODO',
              style: TextStyle(color: AppColors.lightBG),
            ),
          )
        ],
      ),
    );
  }
}
