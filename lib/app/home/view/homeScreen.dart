import 'package:cart3d/app/home/controller/homecontroller.dart';
import 'package:cart3d/app/routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescreen extends GetView<Homecontroller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('HomeScreen'),

            Expanded(
              child: Obx(() {
                if (controller.products.isEmpty) {
                  return Center(
                    child: TextButton(
                      onPressed: () {
                        controller.get3DData();
                      },
                      child: const Text('get Data'),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return ListTile(
                      leading: Text(product.id),
                      title: Text(product.title),
                      subtitle: Text(product.description),
                      onTap: () => Get.toNamed(AppRoutes.PRODUCT),
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
