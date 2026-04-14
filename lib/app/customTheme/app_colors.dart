import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF121218);
  static const Color surfaceSoft = Color(0xFF191924);
  static const Color glass = Color(0x1AFFFFFF);
  static const Color glassBorder = Color(0x40FFFFFF);

  static const Color primary = Color(0xFF8A2BE2);
  static const Color secondary = Color(0xFFB14CFF);
  static const Color accent = Color(0xFFFF2ED1);
  static const Color electricViolet = Color(0xFF9D4DFF);

  static const Color neonGlow = Color(0x8C8A2BE2);
  static const Color neonGlowSoft = Color(0x4D8A2BE2);
  static const Color neonGlowMagenta = Color(0x66FF2ED1);

  static const Color textPrimary = Color(0xFFF5F5F7);
  static const Color textSecondary = Color(0xFFB8B8C7);
  static const Color divider = Color(0x33FFFFFF);
  static const Color success = Color(0xFF49E8A6);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[primary, electricViolet, accent],
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFF14141D), Color(0xFF0A0A0A)],
  );
}
