import 'package:cart3d/app/components/appbar/customAppBar.dart';
import 'package:cart3d/app/components/productCard/ProductCard.dart';
import 'package:cart3d/app/screens/home/controller/homecontroller.dart';
import 'package:cart3d/app/routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescreen extends GetView<Homecontroller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(title: 'HomeScreen'),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.products.isEmpty) {
                  return const Center(child: Text('NO DATA'));
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return Productcard(
                      title: product.title,
                      description: product.description,
                      imgUrl: product.thumbnail,
                      ontap: () =>
                          Get.toNamed(AppRoutes.PRODUCT, arguments: product),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
