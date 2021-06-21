
import 'package:flutter/material.dart';
import 'package:flutter_delivery/presentation/home/cart/cart_controller.dart';
import 'package:flutter_delivery/presentation/home/cart/cart_screen.dart';
import 'package:flutter_delivery/presentation/home/home_controller.dart';
import 'package:flutter_delivery/presentation/home/products/products_screen.dart';
import 'package:flutter_delivery/presentation/home/profile/profile_screen.dart';
import 'package:flutter_delivery/presentation/theme.dart.dart';
import 'package:get/get.dart';

class HomeScreen extends GetWidget<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.indexSelected.value,
                children: [
                  ProductsScreen(),
                  SizedBox(),
                  CardScreen(
                    onShopping: () {
                      controller.updateIndexSelected(0);
                    },
                  ),
                  SizedBox(),
                  ProfileScreen(),
                ],
              ),
            ),
          ),
          Obx(
            () => _DeliveryNavigationBar(
                index: controller.indexSelected.value,
                onIndexSelected: (index) {
                  controller.updateIndexSelected(index);
                }
            ),
          ),
        ],
      ),
    );
  }
}

class _DeliveryNavigationBar extends StatelessWidget {

  final int? index;
  final ValueChanged<int> onIndexSelected;
  final controller = Get.find<HomeController>();
  final cartController = Get.find<CartController>();
  
  _DeliveryNavigationBar({Key? key, this.index, required this.onIndexSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Theme.of(context).bottomAppBarColor,
            width: 2
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Material(
                  child: IconButton(
                    onPressed: () => onIndexSelected(0), 
                    icon: Icon(
                      Icons.home, 
                      color: index == 0 ? DeliveryColors.green : DeliveryColors.lightGrey,
                    )
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  child: IconButton(
                    onPressed: () => onIndexSelected(1), 
                    icon: Icon(
                      Icons.store, 
                      color: index == 1 ? DeliveryColors.green : DeliveryColors.lightGrey,
                    )
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  child: Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: DeliveryColors.purple,
                          radius: 23,
                          child: IconButton(
                          onPressed: () => onIndexSelected(2), 
                            icon: Icon(
                              Icons.shopping_basket, 
                              color: index == 2 ? DeliveryColors.green : DeliveryColors.white,
                            )
                          ),
                        ),

                        Positioned(
                          right: 0,
                          child: Obx(
                            () => cartController.totalItems.value == 0
                            ? const SizedBox.shrink()
                            : CircleAvatar(
                              radius: 11,
                              backgroundColor: Colors.pinkAccent,
                              child: Text(cartController.totalItems.value.toString()),
                            ),
                          )
                        )
                      ],
                    ),
                  )
                ),
              ),
              Expanded(
                child: Material(
                  child: IconButton(
                    onPressed: () => onIndexSelected(3), 
                    icon: Icon(
                      Icons.favorite_border, 
                      color: index == 3 ? DeliveryColors.green : DeliveryColors.lightGrey,
                    )
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => onIndexSelected(4), 
                  child: Obx(
                    () {
                      final user = controller.user.value;
                      return user.image == null 
                        ? const SizedBox.shrink()
                        : Center(
                          child: CircleAvatar(
                              radius: 15,
                              backgroundImage: AssetImage(
                                user.image!
                              ),
                            ),
                        );
                    }
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}