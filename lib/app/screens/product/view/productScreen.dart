import 'package:cart3d/app/components/appbar/customAppBar.dart';
import 'package:cart3d/app/screens/product/controller/productController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Productscreen extends GetView<Productcontroller> {

  @override
  Widget build(BuildContext context) {
    final product = controller.selectedProduct.value!;
    return Scaffold(
      appBar: Customappbar(title: product.title),
      body: Obx(() {
        if (controller.selectedProduct.value == null) {
          return Center(
            child: Text('No product selected'),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 3D Model Viewer
              Container(
                height: 400,
                width: double.infinity,
                color: Colors.grey[300],
                child: ModelViewer(
                  src: product.model3d,
                  alt: product.title,
                  ar: false,
                  autoRotate: true,
                  cameraControls: true,
                  backgroundColor: Color(0xffffffff),
                ),
              ),
              
              // Product Details
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '${product.currency} ${product.price}',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.green),
                        ),
                        SizedBox(width: 16),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 18),
                            SizedBox(width: 4),
                            Text('${product.rating}'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 8),
                    Text(product.description),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Category'),
                            Text(product.category),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Stock'),
                            Text('${product.stock} items'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add to cart logic here
                          Get.snackbar('Success', 'Added to cart');
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text('Add to Cart'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
