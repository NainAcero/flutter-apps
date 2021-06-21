
import 'package:flutter_architect03/src/domain/cart/cart.dart';
import 'package:flutter_architect03/src/domain/cart/cartItem.dart';
import 'package:flutter_architect03/src/domain/cart/cart_repository.dart';

class EditQuantityOfCartItemUseCase {
  final CartRepository _cartRepository;

  EditQuantityOfCartItemUseCase(this._cartRepository);

  Future<Cart> execute(CartItem cartItem, int quantity) async {
    final cart = await _cartRepository.get();

    final editCart = cart.editItem(cartItem, quantity);
    await _cartRepository.save(editCart);

    return editCart;
  }
}