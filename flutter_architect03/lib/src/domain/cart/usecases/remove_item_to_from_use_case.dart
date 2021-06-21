
import 'package:flutter_architect03/src/domain/cart/cart.dart';
import 'package:flutter_architect03/src/domain/cart/cartItem.dart';
import 'package:flutter_architect03/src/domain/cart/cart_repository.dart';

class RemoveItemFromCartUseCase {
  final CartRepository _cartRepository;

  RemoveItemFromCartUseCase(this._cartRepository);

  Future<Cart> execute(CartItem cartItem) async {
    final cart = await _cartRepository.get();

    final editCart = cart.removeItem(cartItem);
    await _cartRepository.save(editCart);

    return editCart;
  }

}