
import 'package:flutter_architect03/src/domain/cart/cart.dart';
import 'package:flutter_architect03/src/domain/cart/cartItem.dart';
import 'package:flutter_architect03/src/domain/cart/cart_repository.dart';
import 'package:flutter_architect03/src/domain/products/product.dart';

class AddProductToCartUseCase {

  final CartRepository _cartRepository;

  AddProductToCartUseCase(this._cartRepository);

  Future<Cart> execute(Product product) async {

    final cart = await _cartRepository.get();
    final cartItem = CartItem(
      product.id, product.image, product.title, 
      product.price, 1);
    
    final editCart = cart.addItem(cartItem);
    await _cartRepository.save(editCart);

    return editCart;
  }
}