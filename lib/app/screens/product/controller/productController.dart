import 'package:cart3d/app/models/Productmodel.dart';
import 'package:get/get.dart';

class Productcontroller extends GetxController {
  Rx<Productmodel?> selectedProduct = Rx<Productmodel?>(null);

  @override
  void onInit() {
    super.onInit();
    // Get product from navigation arguments
    if (Get.arguments != null && Get.arguments is Productmodel) {
      selectedProduct.value = Get.arguments as Productmodel;
    }
  }

  void setProduct(Productmodel product) {
    selectedProduct.value = product;
  }
}