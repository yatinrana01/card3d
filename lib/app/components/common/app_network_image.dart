import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;

  static const String fallbackAssetPath = 'assets/images/sneaker.png';
  static const String fallbackPublicPngUrl =
      'https://upload.wikimedia.org/wikipedia/commons/8/8f/Example_image.svg.png';

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      filterQuality: FilterQuality.high,
      progressIndicatorBuilder: (context, _, __) =>
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      errorWidget: (context, _, __) => CachedNetworkImage(
        imageUrl: fallbackPublicPngUrl,
        fit: fit,
        width: width,
        height: height,
        filterQuality: FilterQuality.high,
        errorWidget: (context, __, ___) => Image.asset(
          fallbackAssetPath,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (context, error, stackTrace) => const SizedBox.expand(),
        ),
      ),
      imageBuilder: (context, imageProvider) => Image(
        image: imageProvider,
        fit: fit,
        width: width,
        height: height,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
