import 'package:cart3d/app/splashScreen/controller/splashcontroller.dart';
import 'package:get/get.dart';

class Splashbinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<Splashcontroller>()) {
      Get.lazyPut(() => Splashcontroller());
    } else {
      Get.find<Splashcontroller>();
    }
  }
}
