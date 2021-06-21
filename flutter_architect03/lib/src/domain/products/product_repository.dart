
import 'package:flutter_architect03/src/domain/products/product.dart';

abstract class ProductRepository {

  Future<List<Product>> get();

}