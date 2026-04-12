import 'package:cart3d/app/auth/controller/authController.dart';
import 'package:get/get.dart';

class Signupbinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<Authcontroller>()) {
      Get.lazyPut(() => Authcontroller());
    } else {
      Get.find<Authcontroller>();
    }
  }
}
