import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF4C1F7A);
  static const Color accentColor  = Color(0xFF4C1F7A);
  static const Color buttonColor  = Color(0xFF0F0F0F);
  static const Color anotherColor  = Color(0xFF5CB338);

}

class TextStye {
   static TextStyle title = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
    color: AppColors.buttonColor,
  );
  static TextStyle text = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    color: AppColors.buttonColor,
  );
  static TextStyle text1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15.0,
    color: AppColors.buttonColor,
  );
}

final Map<String, IconData> categoryIcons = {
  'ELEKTRONIK': FontAwesomeIcons.houseLaptop,
  'ALAT TULIS': FontAwesomeIcons.pen,
  'ALAR OLAHRAGA': FontAwesomeIcons.volleyball,
};
