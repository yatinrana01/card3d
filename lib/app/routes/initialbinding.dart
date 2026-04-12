import 'package:cart3d/app/auth/controller/authController.dart';
import 'package:cart3d/app/splashScreen/controller/splashcontroller.dart';
import 'package:get/get.dart';

class Initialbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>Splashcontroller());
    Get.lazyPut(()=>Authcontroller());
  }
  
}