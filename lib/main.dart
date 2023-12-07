import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskati/core/app_colors.dart';
import 'package:taskati/core/styles.dart';
import 'package:taskati/splash_view.dart';

void main() {
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
