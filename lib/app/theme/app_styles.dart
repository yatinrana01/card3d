import 'dart:ui';

import 'package:cart3d/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  AppStyles._();

  static const double radiusSm = 14;
  static const double radiusMd = 20;
  static const double radiusLg = 28;

  static const EdgeInsets pagePadding = EdgeInsets.all(20);
  static const EdgeInsets cardPadding = EdgeInsets.all(14);
  static const EdgeInsets contentSpacing = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 16,
  );

  static BorderRadius get borderRadiusSm => BorderRadius.circular(radiusSm);
  static BorderRadius get borderRadiusMd => BorderRadius.circular(radiusMd);
  static BorderRadius get borderRadiusLg => BorderRadius.circular(radiusLg);

  static List<BoxShadow> get neonShadow => <BoxShadow>[
    const BoxShadow(
      color: AppColors.neonGlow,
      blurRadius: 20,
      spreadRadius: -2,
      offset: Offset(0, 8),
    ),
    const BoxShadow(
      color: AppColors.neonGlowSoft,
      blurRadius: 30,
      spreadRadius: 0,
      offset: Offset(0, 0),
    ),
  ];

  static List<BoxShadow> get subtleShadow => <BoxShadow>[
    const BoxShadow(
      color: Color(0x66000000),
      blurRadius: 24,
      offset: Offset(0, 12),
    ),
  ];

  static Widget glass({
    required Widget child,
    EdgeInsetsGeometry? padding,
    BorderRadius? radius,
  }) {
    return ClipRRect(
      borderRadius: radius ?? borderRadiusMd,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding ?? cardPadding,
          decoration: BoxDecoration(
            color: AppColors.glass,
            borderRadius: radius ?? borderRadiusMd,
            border: Border.all(color: AppColors.glassBorder),
            boxShadow: subtleShadow,
          ),
          child: child,
        ),
      ),
    );
  }
}
