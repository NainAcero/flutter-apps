import 'package:flutter/material.dart';
import 'package:flutter_delivery/domain/model/product.dart';
import 'package:flutter_delivery/data/in_memory_products.dart';
import 'package:flutter_delivery/domain/model/product_cart.dart';
import 'package:flutter_delivery/presentation/home/cart/cart_controller.dart';
import 'package:flutter_delivery/presentation/theme.dart.dart';
import 'package:flutter_delivery/presentation/widgets/delivery_button.dart';
import 'package:get/get.dart';

class CardScreen extends GetWidget<CartController> {

  final VoidCallback onShopping;

  CardScreen({Key? key, required this.onShopping}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
        ),
      ),
      body: Obx(
        () => controller.totalItems.value == 0 ?
          _EmptyCart(
            onShopping: onShopping,
          ) : _FullCarty()
      )
    );
  }
}

class _FullCarty extends GetWidget<CartController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Obx(
              () => ListView.builder(
                itemCount: controller.cartList.length,
                scrollDirection: Axis.horizontal,
                itemExtent: 250,
                itemBuilder: (context, index) {
                  final productCart = controller.cartList[index];
                  return _ShoppingCartProduct(
                    productCart: productCart,
                    onDelete: (){
                      controller.deleteProduct(productCart);
                    },
                    onIncrement: (){
                      controller.increment(productCart);
                    },
                    onDecrement: (){
                      controller.decrement(productCart);
                    }
                  );
                },
              ),
            ),
          )
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Theme.of(context).canvasColor,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sub Total', style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Theme.of(context).accentColor,
                              ),),
                              Text('0.00 USD', style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Theme.of(context).accentColor,
                              ),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery', style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Theme.of(context).accentColor,
                              ),),
                              Text('Free', style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Theme.of(context).accentColor,
                              ),),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total:', style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor,
                              ),),
                              Obx(
                                () {
                                  final total = controller.totalPrice.value.toStringAsFixed(2);
                                  return Text('\$$total', style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).accentColor,
                                  ),);
                                }
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    DeliveryButton(
                      text: 'Checkout',
                      onTap: (){},
                    )
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}

class _ShoppingCartProduct extends StatelessWidget {

  final ProductCart productCart;
  final VoidCallback onDelete;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _ShoppingCartProduct({Key? key, 
    required this.productCart,
    required this.onDelete,
    required this.onIncrement,
    required this.onDecrement
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = productCart.product;

    return Padding(
      padding: EdgeInsets.all(15.0),
        child: Stack(
          children: [
            Card(
              color: Theme.of(context).canvasColor,
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: ClipOval(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              product.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Text(
                            productCart.product.name, 
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            product.descripcion,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.overline!.copyWith(
                              color: DeliveryColors.lightGrey
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: onDecrement,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: DeliveryColors.white,
                                      borderRadius: BorderRadius.circular(4)
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      color: DeliveryColors.purple,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(productCart.quantity.toString(), style: TextStyle(
                                    color: Theme.of(context).accentColor
                                  ),),
                                ),
                                InkWell(
                                  onTap: onIncrement,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: DeliveryColors.purple,
                                      borderRadius: BorderRadius.circular(4)
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: DeliveryColors.white,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '\$${product.price} ',
                                  style: TextStyle(
                                    color: DeliveryColors.green,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: InkWell(
                onTap: onDelete,
                  child: CircleAvatar(
                  backgroundColor: DeliveryColors.pink,
                  child: Icon(Icons.delete_outline),
                ),
              )
            )
          ],
        )
    );
  }
}

class _EmptyCart extends StatelessWidget {
  final VoidCallback onShopping;

  const _EmptyCart({Key? key,required this.onShopping}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/sad.png',
          height: 90,
          color: DeliveryColors.green,
        ),
        const SizedBox(height: 20,),
        Text(
          'There are no products', 
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
        const SizedBox(height: 20,),
        Center(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: DeliveryColors.purple,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Go shopping',
                style: TextStyle(
                  color: DeliveryColors.white
                ),
              ),
            ),
            onPressed: onShopping, 
          ),
        )
      ],
    );
  }
}