import 'package:cart3d/app/components/common/app_network_image.dart';
import 'package:cart3d/app/customTheme/app_colors.dart';
import 'package:cart3d/app/customTheme/app_styles.dart';
import 'package:flutter/material.dart';

class Productcard extends StatelessWidget {
  final String? imgUrl;
  final String title;
  // final String description;
  final VoidCallback? ontap;
  const Productcard({
    super.key,
    required this.title,
    // required this.description,
    this.imgUrl,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      tween: Tween<double>(begin: 1, end: 1),
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: InkWell(
        borderRadius: AppStyles.borderRadiusMd,
        onTap: ontap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: AppStyles.borderRadiusMd,
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.85),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 9,
                child: ClipRRect(
                  borderRadius: AppStyles.borderRadiusSm,
                  child: AppNetworkImage(
                    imageUrl: imgUrl ?? AppNetworkImage.fallbackPublicPngUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
