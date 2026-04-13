import 'package:flutter/material.dart';

class CustomAppTheme {
  CustomAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.deepPurple,
    useMaterial3: true,
    scaffoldBackgroundColor: Color(0xffffffff),
  
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
  );

}
