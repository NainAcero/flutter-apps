
import 'package:flutter_delivery/data/in_memory_products.dart';
import 'package:flutter_delivery/domain/model/product.dart';
import 'package:flutter_delivery/domain/repository/api_repository.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  final ApiRepositoryInterface apiRepositoryInterface;

  ProductController({required this.apiRepositoryInterface});

  RxList<Product> productList = <Product>[].obs;

  @override
  void onInit() {
    this._loadProducts();
    super.onInit();
  }

  _loadProducts() async{
    final result = await apiRepositoryInterface.getProducts();
    productList.value = result;
  }
}