
import 'package:flutter_architect03/src/domain/cart/cart.dart';

abstract class CartRepository {

  Future<Cart> get();

  Future<bool> save(Cart cart);

}