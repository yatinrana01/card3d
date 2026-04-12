import 'package:cart3d/app/product/controller/productController.dart';
import 'package:get/get.dart';

class Productbinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<Productcontroller>()) {
      Get.lazyPut(() => Productcontroller());
    } else {
      Get.find<Productcontroller>();
    }
  }
}
