import 'package:cart3d/app/models/Productmodel.dart';

abstract class ProductRepository {
  Future<List<Productmodel>> getProducts();
}
