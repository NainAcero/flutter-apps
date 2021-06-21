
import 'package:flutter/material.dart';
import 'package:flutter_delivery/domain/model/product.dart';
import 'package:flutter_delivery/data/in_memory_products.dart';
import 'package:flutter_delivery/presentation/home/cart/cart_controller.dart';
import 'package:flutter_delivery/presentation/home/products/products_controller.dart';
import 'package:flutter_delivery/presentation/theme.dart.dart';
import 'package:flutter_delivery/presentation/widgets/delivery_button.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {

  // Para paginas dentro de otras
  final controller = Get.find<ProductController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products'
        ),
      ),
      body: Obx(
        () => controller.productList.isNotEmpty ? GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: controller.productList.length,
          itemBuilder: (context, index) {
            final product = controller.productList[index];
            return _ItemProduct(
              product: product,
              onTap: (){
                cartController.add(product);
              },
            );
          }
        ) : const Center(child: CircularProgressIndicator(),)
      ),
    );
  }
}

class _ItemProduct extends StatelessWidget {

  final Product product;
  final VoidCallback onTap;

  const _ItemProduct({Key? key, required this.product, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).canvasColor,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
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
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 5,),
                  Text(
                    product.name, 
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
                  Text(
                    '\$${product.price} USD ',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            DeliveryButton(
              padding: EdgeInsets.symmetric(vertical: 4),
              text: 'Agregar',
              onTap: onTap,
            )
          ],
        ),
      ),
    );
  }
}