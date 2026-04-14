import 'package:cart3d/app/screens/home/controller/homecontroller.dart';
import 'package:get/get.dart';

class Homebinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Homecontroller>(Homecontroller());
  }
}
