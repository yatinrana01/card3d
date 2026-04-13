import 'package:cart3d/app/theme/app_colors.dart';
import 'package:cart3d/app/theme/app_styles.dart';
import 'package:flutter/material.dart';

class GlowingButton extends StatefulWidget {
  const GlowingButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool expand;

  @override
  State<GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat(reverse: true);

  late final Animation<double> _glow = Tween<double>(
    begin: 0.45,
    end: 1,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget button = ElevatedButton.icon(
      onPressed: widget.onPressed,
      icon: widget.icon == null ? const SizedBox.shrink() : Icon(widget.icon),
      label: Text(widget.label),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: AppStyles.borderRadiusSm),
      ),
    );

    return AnimatedBuilder(
      animation: _glow,
      builder: (_, __) {
        return Container(
          width: widget.expand ? double.infinity : null,
          decoration: BoxDecoration(
            borderRadius: AppStyles.borderRadiusSm,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.neonGlow.withValues(alpha: _glow.value),
                blurRadius: 24,
                spreadRadius: -2,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: button,
        );
      },
    );
  }
}
