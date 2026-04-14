import 'package:cart3d/app/models/Productmodel.dart';
import 'package:get/get.dart';

class Productcontroller extends GetxController {
  Rx<Productmodel?> selectedProduct = Rx<Productmodel?>(null);
  late final Rx<String> activeModelSrc;

  static const String fallbackModelUrl = 'assets/3d_models/NikeHoodie.glb';

  @override
  void onInit() {
    super.onInit();
    activeModelSrc = Rx<String>(fallbackModelUrl);
    // Get product from navigation arguments
    if (Get.arguments != null && Get.arguments is Productmodel) {
      selectedProduct.value = Get.arguments as Productmodel;
    }
  }

  void setProduct(Productmodel product) {
    selectedProduct.value = product;
    activeModelSrc.value = product.model3d.isNotEmpty ? product.model3d : fallbackModelUrl;
  }
}