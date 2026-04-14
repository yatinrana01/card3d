import 'dart:async';

import 'package:cart3d/app/domain/repositories/product_repository.dart';
import 'package:cart3d/app/models/Productmodel.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController {
  Homecontroller(this._productRepository);

  final ProductRepository _productRepository;

  final RxList<Productmodel> allProducts = <Productmodel>[].obs;
  final RxList<Productmodel> displayedProducts = <Productmodel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString loadError = ''.obs;
  final RxBool hasMoreProducts = true.obs;

  static const int pageSize = 8;
  int _currentPage = 0;
  Timer? _loadMoreDebounce;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  @override
  void onClose() {
    _loadMoreDebounce?.cancel();
    super.onClose();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    loadError.value = '';

    try {
      final List<Productmodel> productList = await _productRepository
          .getProducts();
      allProducts.assignAll(productList);
      _currentPage = 0;
      displayedProducts.clear();
      hasMoreProducts.value = true;
      _loadNextPage();
    } catch (e) {
      loadError.value = 'Failed to load products.';
    } finally {
      isLoading.value = false;
    }
  }

  void _loadNextPage() {
    if (_currentPage * pageSize >= allProducts.length) {
      hasMoreProducts.value = false;
      return;
    }

    final int start = _currentPage * pageSize;
    final int end = (start + pageSize).clamp(0, allProducts.length);

    if (start < allProducts.length) {
      displayedProducts.addAll(allProducts.sublist(start, end));
      _currentPage++;
    }
    hasMoreProducts.value = _currentPage * pageSize < allProducts.length;
  }

  void loadMoreIfNeeded() {
    if (isLoadingMore.value || !hasMoreProducts.value) {
      return;
    }

    _loadMoreDebounce?.cancel();
    _loadMoreDebounce = Timer(const Duration(milliseconds: 120), () {
      _loadMore();
    });
  }

  void _loadMore() {
    if (isLoadingMore.value || !hasMoreProducts.value) {
      return;
    }

    isLoadingMore.value = true;
    Future<void>.delayed(const Duration(milliseconds: 250), () {
      _loadNextPage();
      isLoadingMore.value = false;
    });
  }
}
