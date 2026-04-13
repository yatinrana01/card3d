import 'dart:ui';

import 'package:cart3d/app/theme/app_colors.dart';
import 'package:cart3d/app/theme/app_styles.dart';
import 'package:flutter/material.dart';

class NeonGlowContainer extends StatelessWidget {
  const NeonGlowContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.gradient,
    this.showGlow = true,
    this.blur = 10,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Gradient? gradient;
  final bool showGlow;
  final double blur;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = borderRadius ?? AppStyles.borderRadiusMd;
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: showGlow ? AppStyles.neonShadow : AppStyles.subtleShadow,
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? AppStyles.cardPadding,
            decoration: BoxDecoration(
              gradient: gradient,
              color: gradient == null ? AppColors.glass : null,
              borderRadius: radius,
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
