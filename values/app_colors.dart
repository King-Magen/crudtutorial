import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color primaryColor = Color.fromARGB(255, 246, 66, 72);
  static const Color secondaryColor = Color.fromRGBO(237, 28, 36, 1);
  static const Color successResponse = Color.fromARGB(195, 0, 233, 12);
  static const Color errorResponse = Color.fromARGB(223, 255, 0, 0);

  static const Color darkBlue = Color(0xff1E2E3D);
  static const Color darkerBlue = Color(0xff152534);
  static const Color darkestBlue = Color.fromARGB(255, 229, 14, 147);

  static const List<Color> defaultGradient = [
    Color.fromARGB(255, 165, 0, 0),
    Color.fromARGB(255, 226, 74, 63),
    Color.fromARGB(255, 255, 0, 0),
  ];
}