import 'package:cart3d/app/auth/login/binding/loginBinding.dart';
import 'package:cart3d/app/auth/login/view/login.dart';
import 'package:cart3d/app/auth/signup/binding/signupBinding.dart';
import 'package:cart3d/app/auth/signup/view/signup.dart';
import 'package:cart3d/app/home/binding/homebinding.dart';
import 'package:cart3d/app/home/view/homeScreen.dart';
import 'package:cart3d/app/product/binding/productBinding.dart';
import 'package:cart3d/app/product/view/productScreen.dart';
import 'package:cart3d/app/routes/AppRoutes.dart';
import 'package:cart3d/app/splashScreen/binding/splashbinding.dart';
import 'package:cart3d/app/splashScreen/view/splashScreen.dart';
import 'package:get/get.dart';

class Pages {
  Pages._();

  static const INITIAL = AppRoutes.SPLASH;

  static final routes = [
    
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => Splashscreen(),
      binding: Splashbinding(),
    ),

    GetPage(
      name: AppRoutes.SIGNUP,
      page: () => Signup(),
      binding: Signupbinding(),
    ),

    GetPage(
      name: AppRoutes.LOGIN,
      page: () => Login(),
      binding: Loginbinding(),
    ),
    
    GetPage(
      name: AppRoutes.HOME,
      page: () => Homescreen(),
      binding: Homebinding(),
    ),

    GetPage(
      name: AppRoutes.PRODUCT,
      page: () => Productscreen(),
      binding: Productbinding(),
    ),
  ];
}
