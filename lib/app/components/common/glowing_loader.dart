import 'package:cart3d/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GlowingLoader extends StatefulWidget {
  const GlowingLoader({super.key, this.size = 44});

  final double size;

  @override
  State<GlowingLoader> createState() => _GlowingLoaderState();
}

class _GlowingLoaderState extends State<GlowingLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final double pulse = 0.6 + (_controller.value * 0.4);
        return Container(
          height: widget.size,
          width: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.accent.withValues(alpha: pulse),
                blurRadius: 24,
                spreadRadius: -2,
              ),
            ],
          ),
          child: CircularProgressIndicator(
            strokeWidth: 3.2,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.accent.withValues(alpha: pulse),
            ),
          ),
        );
      },
    );
  }
}
