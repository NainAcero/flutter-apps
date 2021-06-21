import 'package:flutter/widgets.dart';


abstract class CartState {
  CartState();

  factory CartState.loading() =>LoadingCartState();

  factory CartState.loaded(  String totalPrice, int totalItems,
      List<CartItemState> items) =>
      LoadedCartState(totalPrice: totalPrice, totalItems:totalItems, items: items);

  factory CartState.error(String message) => ErrorCartState(message: message);
}

class LoadingCartState extends CartState {
  LoadingCartState();
}

class LoadedCartState extends CartState {
  final String totalPrice;
  final int totalItems;
  final List<CartItemState> items;

  LoadedCartState({required this.totalPrice,required this.totalItems,  required this.items});
}

class ErrorCartState extends CartState {
  final String message;

  ErrorCartState({required this.message});
}

class CartItemState {
  final String id;
  final String image;
  final String title;
  final String price;
  final int quantity;

  CartItemState(this.id, this.image, this.title, this.price, this.quantity);
}
