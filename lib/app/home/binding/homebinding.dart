import 'package:cart3d/app/home/controller/homecontroller.dart';
import 'package:get/get.dart';

class Homebinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<Homecontroller>()) {
      Get.lazyPut(() => Homecontroller());
    } else {
      Get.find<Homecontroller>();
    }
  }
}
