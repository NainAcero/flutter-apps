
import 'package:flutter_architect03/src/common/bloc/bloc.dart';
import 'package:flutter_architect03/src/domain/cart/cart.dart';
import 'package:flutter_architect03/src/domain/cart/cartItem.dart';
import 'package:flutter_architect03/src/domain/cart/usecases/add_product_to_cart_use_case.dart';
import 'package:flutter_architect03/src/domain/cart/usecases/edit_quantity_of_cart_item_use_case.dart';
import 'package:flutter_architect03/src/domain/cart/usecases/get_cart_use_case.dart';
import 'package:flutter_architect03/src/domain/cart/usecases/remove_item_to_from_use_case.dart';
import 'package:flutter_architect03/src/domain/products/get_products_use_case.dart';
import 'package:flutter_architect03/src/domain/products/product.dart';
import 'package:flutter_architect03/src/presentation/cart/cart_state.dart';
import 'package:flutter_architect03/src/presentation/products/products_state.dart';
import 'package:intl/intl.dart';

class CartBloc extends Bloc<CartState> {
  final GetProductsUseCase _getProductsUseCase;
  final GetCartUseCase _getCartUseCase;
  final AddProductToCartUseCase _addProductToCartUseCase;
  final RemoveItemFromCartUseCase _removeItemFromCartUseCase;
  final EditQuantityOfCartItemUseCase _editQuantityOfCartItemUseCase;

  Cart? _cart;
  List<Product>? _products;

  CartBloc(
      this._getProductsUseCase,
      this._getCartUseCase,
      this._addProductToCartUseCase,
      this._removeItemFromCartUseCase,
      this._editQuantityOfCartItemUseCase) {
    _init();
    changeState(CartState.loading());
  }

  Future<void> _init() async {
    _products = await _getProductsUseCase.execute();
    _loadCart();
  }

  void addProductToCartCart(ProductItemState productItemState) {
    final Product product =
        _products!.firstWhere((product) => product.id == productItemState.id);

    _addProductToCartUseCase.execute(product).then((cart) {
      _cart = cart;
      changeState(_mapToState(cart));
    });
  }

  void removeCartItemOfCart(CartItemState cartItemState) {
    final CartItem? cartItem =
        _cart!.items.firstWhere((cartItem) => cartItem!.id == cartItemState.id);

    _removeItemFromCartUseCase.execute(cartItem!).then((cart) {
      _cart = cart;
      changeState(_mapToState(cart));
    });
  }

  void editQuantityOfCartItem(CartItemState cartItemState, int quantity) {
    final CartItem? cartItem =
        _cart!.items.firstWhere((cartItem) => cartItem!.id == cartItemState.id);

    _editQuantityOfCartItemUseCase.execute(cartItem!, quantity).then((cart) {
      _cart = cart;
      changeState(_mapToState(cart));
    });
  }

  void _loadCart() {
    _getCartUseCase.execute().then((cart) {
      _cart = cart;
      changeState(_mapToState(cart));
    }).catchError((error) {
      changeState(CartState.error('A network error has ocurrd'));
    });
  }

  CartState _mapToState(Cart cart) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'es-ES');

    return CartState.loaded(
        formatCurrency.format(cart.totalPrice),
        cart.totalItems,
        cart.items
            .map((cartItem) => CartItemState(
                cartItem!.id,
                cartItem.image,
                cartItem.title,
                formatCurrency.format(cartItem.price),
                cartItem.quantity))
            .toList());
  }
}
