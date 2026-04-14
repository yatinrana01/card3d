import 'package:cart3d/app/components/appbar/customAppBar.dart';
import 'package:cart3d/app/components/common/glowing_loader.dart';
import 'package:cart3d/app/components/common/neon_glow_container.dart';
import 'package:cart3d/app/components/productCard/ProductCard.dart';
import 'package:cart3d/app/models/Productmodel.dart';
import 'package:cart3d/app/screens/home/controller/homecontroller.dart';
import 'package:cart3d/app/screens/product/view/productScreen.dart';
import 'package:cart3d/app/customTheme/app_colors.dart';
import 'package:cart3d/app/customTheme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescreen extends GetView<Homecontroller> {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: Customappbar(title: 'Homescreen'),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: NeonGlowContainer(
          gradient: AppColors.surfaceGradient,
          child: Padding(
            padding: AppStyles.pagePadding,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: GlowingLoader(size: 46));
                  }

                  if (controller.loadError.value.isNotEmpty) {
                    return Center(
                      child: Text(
                        controller.loadError.value,
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return _buildHomeTab(context, theme);
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeTab(BuildContext context, ThemeData theme) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildProductGrid(controller.displayedProducts.toList()),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(List<Productmodel> productList) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 240) {
          controller.loadMoreIfNeeded();
        }
        return false;
      },
      child: Obx(
        () => GridView.builder(
          itemCount:
              productList.length + (controller.hasMoreProducts.value ? 1 : 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
          ),
          itemBuilder: (context, index) {
            if (index >= productList.length) {
              return const Center(child: CircularProgressIndicator());
            }

            final product = productList[index];
            return Productcard(
              title: product.title,
              imgUrl: product.thumbnail,
              ontap: () => _showProductModal(context, product),
            );
          },
        ),
      ),
    );
  }

  void _showProductModal(BuildContext context, Productmodel product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Productscreen(product: product),
      ),
    );
  }
}
