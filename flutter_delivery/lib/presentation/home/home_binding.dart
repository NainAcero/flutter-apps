
import 'package:flutter_delivery/presentation/home/cart/cart_controller.dart';
import 'package:flutter_delivery/presentation/home/home_controller.dart';
import 'package:flutter_delivery/presentation/home/products/products_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
      localRepositoryInterface: Get.find(),
      apiRepositoryInterface: Get.find()
    ));

    Get.lazyPut(
      () => CartController(),
    );

    Get.lazyPut(
      () => ProductController(
        apiRepositoryInterface: Get.find()
      ),
    );
  }

}