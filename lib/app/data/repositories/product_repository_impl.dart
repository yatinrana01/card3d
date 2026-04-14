import 'package:cart3d/app/data/datasources/product_local_data_source.dart';
import 'package:cart3d/app/data/parsers/product_parser.dart';
import 'package:cart3d/app/domain/repositories/product_repository.dart';
import 'package:cart3d/app/models/Productmodel.dart';
import 'package:flutter/foundation.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._localDataSource);

  final ProductLocalDataSource _localDataSource;

  @override
  Future<List<Productmodel>> getProducts() async {
    final String rawJson = await _localDataSource.loadRawJson();
    return compute(parseProducts, rawJson);
  }
}
