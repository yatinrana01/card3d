import 'package:flutter/services.dart';

class ProductLocalDataSource {
  static const String _dataPath = 'data/data.json';

  Future<String> loadRawJson() async {
    return rootBundle.loadString(_dataPath);
  }
}
