import 'package:flutter/material.dart';
import 'package:flutter_architect03/src/presentation/cart/widgets/cart_drawer.dart';
import 'package:flutter_architect03/src/presentation/home/my_app_bar.dart';
import 'package:flutter_architect03/src/presentation/products/widgets/product_list.dart';

class HomePage extends StatelessWidget {

  final String searchTerm = 'Elements';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'Results for',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    searchTerm,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Theme.of(context).primaryColor
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ProductList()
            )
          ],
        ),
      ),
      endDrawer: CartDrawer()
    );
  }
}