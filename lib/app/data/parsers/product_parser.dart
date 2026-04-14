import 'dart:convert';
import 'package:cart3d/app/models/Productmodel.dart';

List<Productmodel> parseProducts(String rawJson) {
  final dynamic decoded = jsonDecode(rawJson);
  if (decoded is! Map<String, dynamic>) {
    return <Productmodel>[];
  }

  final dynamic productsData = decoded['products'];
  if (productsData is! List) {
    return <Productmodel>[];
  }

  return productsData
      .whereType<Map<String, dynamic>>()
      .map(Productmodel.fromJson)
      .toList(growable: false);
}
