import 'package:cart3d/app/models/Productmodel.dart';
import 'package:get/get.dart';

class Productcontroller extends GetxController {
  Rx<Productmodel?> selectedProduct = Rx<Productmodel?>(null);

  static const String fallbackModelUrl =
      'https://modelviewer.dev/shared-assets/models/Astronaut.glb';

  @override
  void onInit() {
    super.onInit();
    // Get product from navigation arguments
    if (Get.arguments != null && Get.arguments is Productmodel) {
      selectedProduct.value = Get.arguments as Productmodel;
    }
  }

  String get activeModelSrc {
    final product = selectedProduct.value;
    if (product == null) {
      return fallbackModelUrl;
    }
    return product.model3d.isNotEmpty ? product.model3d : fallbackModelUrl;
  }

  void setProduct(Productmodel product) {
    selectedProduct.value = product;
  }
}