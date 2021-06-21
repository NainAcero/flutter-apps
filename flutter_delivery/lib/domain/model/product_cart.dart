
import 'package:flutter_delivery/domain/model/product.dart';

class ProductCart {
  ProductCart({required this.product, this.quantity = 1});
  final Product product;
  int quantity;
}