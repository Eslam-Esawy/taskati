import 'package:flutter/material.dart';
import 'package:taskati/core/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getTitleStyle({Color color = Colors.black}) {
  return TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold);
}

TextStyle getSubTitleStyle(
    {Color color = const Color.fromARGB(255, 125, 117, 117)}) {
  return TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold);
}

TextStyle getHeadLineStyle() {
  return TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 18,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold);
}
