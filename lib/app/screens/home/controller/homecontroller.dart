import 'dart:convert';
import 'package:cart3d/app/models/Productmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController {
  final RxList<Productmodel> products = <Productmodel>[].obs;
  final RxInt selectedTab = 0.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    get3DData();
  }

  void setTab(int index) {
    selectedTab.value = index;
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<Productmodel> get filteredProducts {
    final query = searchQuery.value.trim().toLowerCase();
    var list = products.toList();

    if (query.isNotEmpty) {
      list = list.where((product) {
        final title = product.title.toLowerCase();
        final description = product.description.toLowerCase();
        final category = product.category.toLowerCase();
        return title.contains(query) || description.contains(query) || category.contains(query);
      }).toList();
    }

    switch (selectedTab.value) {
      case 1:
        return list.where((item) => item.isfeatured).toList();
      case 2:
        return list.where((item) => item.price <= 400).toList();
      case 3:
        return list.where((item) => item.rating >= 4.5).toList();
      default:
        return list;
    }
  }

  String get selectedTabLabel {
    switch (selectedTab.value) {
      case 1:
        return 'Featured';
      case 2:
        return 'Budget';
      case 3:
        return 'Top rated';
      default:
        return 'All products';
    }
  }

  Future<void> get3DData() async {
    try {
      final rawDetails = await rootBundle.loadString('data/data.json');
      final data = jsonDecode(rawDetails);
      final List list = data['products'];

      final productList = list.map((e) => Productmodel.fromJson(e)).toList();
      products.assignAll(productList);
    } catch (e) {
      debugPrint('Failed to load 3D data: $e');
    }
  }
}
