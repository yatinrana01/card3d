import 'package:cart3d/app/components/appbar/customAppBar.dart';
import 'package:cart3d/app/models/Productmodel.dart';
import 'package:cart3d/app/screens/product/controller/productController.dart';
import 'package:cart3d/app/customTheme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Productscreen extends StatefulWidget {
  final Productmodel? product;

  const Productscreen({super.key, this.product});

  @override
  State<Productscreen> createState() => _ProductscreenState();
}

class _ProductscreenState extends State<Productscreen> {
  late final Productcontroller controller;

  @override
  void initState() {
    super.initState();
    // Get or create controller
    if (Get.isRegistered<Productcontroller>()) {
      controller = Get.find<Productcontroller>();
    } else {
      controller = Get.put<Productcontroller>(Productcontroller());
    }
    // Set product if passed via parameter
    if (widget.product != null) {
      controller.setProduct(widget.product!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(
        title: controller.selectedProduct.value?.title ?? '3D Viewer',
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Obx(() {
          final product = controller.selectedProduct.value;
          if (product == null) {
            return Center(
              child: Text(
                'No model selected',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: AppStyles.pagePadding,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: AppStyles.borderRadiusLg,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: SizedBox(
                      width: double.infinity,
                      height: 420,
                      child: Obx(() {
                        final String modelSrc = controller.activeModelSrc.value;
                        if (modelSrc.isEmpty) {
                          return const _ModelPlaceholder();
                        }

                        return ModelViewer(
                          src: modelSrc,
                          alt: product.title,
                          autoRotate: true,
                          cameraControls: true,
                          ar: false,
                          shadowIntensity: 0.9,
                          interactionPrompt: InteractionPrompt.auto,
                        );
                      }),
                    ),
                  ),
                ),
                Padding(
                  padding: AppStyles.pagePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 18),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: <Widget>[
                          _InfoChip(label: 'Rating ${product.rating}'),
                          _InfoChip(label: product.category),
                          _InfoChip(label: '${product.stock} variations'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Model preview',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rotate the model with one finger, pinch to zoom, and inspect the details in real time.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _ModelPlaceholder extends StatelessWidget {
  const _ModelPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.view_in_ar_rounded, size: 42),
            const SizedBox(height: 12),
            Text(
              '3D model unavailable',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'The model source is invalid. Load the fallback model.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: AppStyles.borderRadiusSm,
        color: Theme.of(context).colorScheme.primary.withAlpha(18),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
