import 'package:cart3d/app/data/datasources/product_local_data_source.dart';
import 'package:cart3d/app/data/repositories/product_repository_impl.dart';
import 'package:cart3d/app/domain/repositories/product_repository.dart';
import 'package:cart3d/app/screens/home/controller/homecontroller.dart';
import 'package:get/get.dart';

class Homebinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ProductLocalDataSource>()) {
      Get.lazyPut<ProductLocalDataSource>(ProductLocalDataSource.new);
    }

    if (!Get.isRegistered<ProductRepository>()) {
      Get.lazyPut<ProductRepository>(
        () => ProductRepositoryImpl(Get.find<ProductLocalDataSource>()),
      );
    }

    Get.put<Homecontroller>(Homecontroller(Get.find<ProductRepository>()));
  }
}
