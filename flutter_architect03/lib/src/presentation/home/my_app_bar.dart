
import 'package:flutter/material.dart';
import 'package:flutter_architect03/src/presentation/cart/widgets/cart_counter_badge.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  
  MyAppBar() : preferredSize = Size.fromHeight(kToolbarHeight); 

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'assets/images/logo.png',
        width: 130.0,
      ),
      actions: [
        shoppingCartIcon(context)
      ],
    );
  }

  Widget shoppingCartIcon(BuildContext context) {
    // Using Stack to show Notification Badge
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),
        CartCounterBadge()
      ],
    );
  }
}