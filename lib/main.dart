import 'package:flutter/material.dart';
import 'package:taskati/core/styles.dart';
import 'package:taskati/splash_view.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskati/core/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskati/core/model/task_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  await Hive.openBox<Task>('task');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              titleTextStyle: getHeadLineStyle(),
              iconTheme: IconThemeData(color: AppColors.primaryColor),
              backgroundColor: Colors.transparent,
              elevation: 0.0),
          fontFamily: GoogleFonts.poppins().fontFamily),
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
