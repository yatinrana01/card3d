import 'dart:io';

import 'package:cart3d/app/models/Productmodel.dart';
import 'package:get/get.dart';

class Productcontroller extends GetxController {
  final Rx<Productmodel?> selectedProduct = Rx<Productmodel?>(null);
  final RxString activeModelSrc = ''.obs;
  final RxBool useFallbackModel = false.obs;
  int _requestToken = 0;

  static const String fallbackModelUrl =
      'https://modelviewer.dev/shared-assets/models/Astronaut.glb';

  @override
  void onInit() {
    super.onInit();

    // Initialize with fallback
    activeModelSrc.value = fallbackModelUrl;

    // Handle navigation arguments
    if (Get.arguments != null && Get.arguments is Productmodel) {
      setProduct(Get.arguments as Productmodel);
    }
  }

  Future<void> setProduct(Productmodel product) async {
    selectedProduct.value = product;
    useFallbackModel.value = false;
    final int token = ++_requestToken;

    final modelUrl = product.model3d;

    if (modelUrl.isEmpty || !modelUrl.startsWith('http')) {
      switchToFallbackModel();
      return;
    }

    activeModelSrc.value = modelUrl;
    final bool isReachable = await _isModelReachable(modelUrl);
    if (token != _requestToken) {
      return;
    }

    if (!isReachable) {
      switchToFallbackModel();
    }
  }

  void switchToFallbackModel() {
    useFallbackModel.value = true;
    activeModelSrc.value = fallbackModelUrl;
  }

  Future<bool> _isModelReachable(String modelUrl) async {
    try {
      final Uri? uri = Uri.tryParse(modelUrl);
      if (uri == null) {
        return false;
      }

      final HttpClient client = HttpClient()
        ..connectionTimeout = const Duration(seconds: 4);
      try {
        final HttpClientRequest request = await client.getUrl(uri);
        request.followRedirects = true;
        final HttpClientResponse response = await request.close().timeout(
          const Duration(seconds: 5),
        );
        return response.statusCode >= 200 && response.statusCode < 400;
      } finally {
        client.close(force: true);
      }
    } catch (_) {
      return false;
    }
  }
}
