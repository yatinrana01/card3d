import 'package:cart3d/app/screens/home/binding/homebinding.dart';
import 'package:cart3d/app/screens/home/view/homeScreen.dart';
import 'package:cart3d/app/screens/product/binding/productBinding.dart';
import 'package:cart3d/app/screens/product/view/productScreen.dart';
import 'package:cart3d/app/routes/AppRoutes.dart';
import 'package:get/get.dart';

class Pages {
  Pages._();

  static const home = AppRoutes.home;

  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => Homescreen(),
      binding: Homebinding(),
    ),
    GetPage(
      name: AppRoutes.product,
      page: () => Productscreen(),
      binding: Productbinding(),
    ),
  ];
}
