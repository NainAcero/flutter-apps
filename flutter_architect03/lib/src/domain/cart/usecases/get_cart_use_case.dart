
import 'package:flutter_architect03/src/domain/cart/cart.dart';
import 'package:flutter_architect03/src/domain/cart/cart_repository.dart';

class GetCartUseCase {
  final CartRepository _cartRepository;

  GetCartUseCase(this._cartRepository);

  Future<Cart> execute() async {
    return _cartRepository.get();
  }
}