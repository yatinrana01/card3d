import 'dart:convert';
import 'package:cart3d/app/models/Productmodel.dart';
import 'package:cart3d/app/models/postmodel.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Homecontroller extends GetxController {
  RxList posts = [].obs;
  RxList products = [].obs;

  @override
  void onInit() {
    super.onInit();
    // getData();
    get3DData();
  }

  Future<dynamic> getData() async {
    const String URL = 'https://jsonplaceholder.typicode.com/posts';

    final response = await http.get(Uri.parse(URL));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print('data fetched successfully');

      // print(data);

      List<PostModel> RawList = (data as List)
          .map((e) => PostModel.fromJson(e))
          .toList();

      posts.assignAll(RawList);

      return data;
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> get3DData() async {
    try {
      final RawDetails = await rootBundle.loadString('data/data.json');
      final data = jsonDecode(RawDetails);
      final List list = data['products'];

      final Rawlist = list.map((e) => Productmodel.fromJson(e)).toList();

      products.assignAll(Rawlist);
      // print(data);
      return data;
    } catch (e) {
      print(e);
    }
  }
}
