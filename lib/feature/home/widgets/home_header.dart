import 'dart:io';
import 'package:flutter/material.dart';
import 'package:taskati/core/styles.dart';
import 'package:taskati/core/app_colors.dart';
import 'package:taskati/core/app_local_storage.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FutureBuilder(
          future: AppLocal.getCached(AppLocal.nameKey),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${snapshot.data!.split(' ').first}',
                    style: getHeadLineStyle(),
                  ),
                  Text(
                    'Have a productive day!',
                    style: getSubTitleStyle(),
                  ),
                ],
              );
            } else {
              return const Text('Hello User');
            }
          },
        ),
        const Spacer(),
        FutureBuilder(
          future: AppLocal.getCached(AppLocal.imageKey),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.primaryColor,
                backgroundImage: FileImage(File(snapshot.data.toString())),
              );
            } else {
              return Image.asset('assets/user.png');
            }
          },
        )
      ],
    );
  }
}
