
import 'package:flutter/material.dart';
import 'package:flutter_architect03/src/presentation/cart/widgets/cart_content.dart';

class CartDrawer extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 110,
            child: DrawerHeader(
              padding: EdgeInsets.zero,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart),
                    SizedBox(width: 15,),
                    Text(
                      'Cart',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ],
                ),
                onTap: () {},
              )
            ),
          ),
          const Expanded(child: CartContent())
        ],
      ),
    );
  }
}