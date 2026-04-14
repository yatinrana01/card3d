import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart3d/app/theme/app_colors.dart';
import 'package:cart3d/app/theme/app_styles.dart';
import 'package:flutter/material.dart';

class Productcard extends StatelessWidget {
  final String imgUrl;
  final String title;
  // final String description;
  final VoidCallback? ontap;
  const Productcard({
    super.key,
    required this.title,
    // required this.description,
    required this.imgUrl,
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
          padding: AppStyles.cardPadding,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: AppStyles.borderRadiusMd,
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: AppStyles.borderRadiusSm,
                  child: CachedNetworkImage(
                    imageUrl: imgUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    filterQuality: FilterQuality.high,
                    progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(
                        Icons.broken_image_rounded,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    imageBuilder: (context, imageProvider) => Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              // Text(
              //   description,
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              //   style: theme.textTheme.bodySmall,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
