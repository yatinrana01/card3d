import 'dart:convert';
import 'package:cart3d/app/models/Productmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class _DataFetchParams {
  final String jsonData;
  _DataFetchParams(this.jsonData);
}

List<Productmodel> _fetchAndParseInIsolate(_DataFetchParams params) {
  try {
    final data = jsonDecode(params.jsonData);
    final products = data['products'] as List<dynamic>;
    return products
        .map((item) => Productmodel.fromJson(item as Map<String, dynamic>))
        .toList();
  } catch (e) {
    rethrow;
  }
}

class Homecontroller extends GetxController {
  final RxList<Productmodel> allProducts = <Productmodel>[].obs;
  final RxList<Productmodel> displayedProducts = <Productmodel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString loadError = ''.obs;
  
  static const int pageSize = 6;
  int _currentPage = 0;

  @override
  void onInit() {
    super.onInit();
    get3DData();
  }

  Future<void> get3DData() async {
    isLoading.value = true;
    loadError.value = '';

    try {
      final rawDetails = await rootBundle.loadString('data/data.json');
      final params = _DataFetchParams(rawDetails);
      final productList = await compute(_fetchAndParseInIsolate, params);
      allProducts.assignAll(productList);
      _loadNextPage();
    } catch (e) {
      loadError.value = 'Failed to load products.';
      debugPrint('Failed to load 3D data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _loadNextPage() {
    if (_currentPage * pageSize >= allProducts.length) return;
    
    final start = _currentPage * pageSize;
    final end = (start + pageSize).clamp(0, allProducts.length);
    
    if (start < allProducts.length) {
      displayedProducts.addAll(allProducts.sublist(start, end));
      _currentPage++;
    }
  }

  void loadMore() {
    if (isLoadingMore.value || _currentPage * pageSize >= allProducts.length) return;
    isLoadingMore.value = true;
    Future.delayed(const Duration(milliseconds: 300), () {
      _loadNextPage();
      isLoadingMore.value = false;
    });
  }

  bool hasMoreProducts() {
    return _currentPage * pageSize < allProducts.length;
  }
}
