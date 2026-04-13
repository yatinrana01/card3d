import 'package:flutter/material.dart';

class CustomCardTheme {
  CustomCardTheme._();

  static CardTheme cardThemeLight = CardTheme(
    color: Colors.purple[400],
    elevation: 4,
    shadowColor: Colors.purple[200],
    shape: Border.all(color: Color(0xffffffff), width: 1),
  );

  static CardTheme cardThemeDark = CardTheme(
    color: Colors.purple[400],
    elevation: 4,
    shadowColor: Colors.purple[200],
    shape: Border.all(color: Color(0xff000000), width: 1),
  );
}
