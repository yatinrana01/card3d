import 'package:flutter/material.dart';

class CustomTextTheme {
  CustomTextTheme._();

  static TextTheme textThemeLight = TextTheme(
    titleLarge: const TextStyle().copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      letterSpacing: 4,
      color: Color(0xff000000),
    ),
  );

  static TextTheme textThemeDark = TextTheme(
    titleLarge: const TextStyle().copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      letterSpacing: 4,
      color: Color(0xffffffff),
    ),
  );
}
