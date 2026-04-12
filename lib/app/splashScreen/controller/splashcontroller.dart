import 'package:cart3d/app/routes/AppRoutes.dart';
import 'package:get/get.dart';

class Splashcontroller extends GetxController {


  @override
  void onInit() {
    super.onInit();
    NavigateToApp();
  }

  Future<void> NavigateToApp() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
