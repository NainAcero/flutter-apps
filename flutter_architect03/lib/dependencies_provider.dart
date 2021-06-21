
import 'package:flutter_architect03/src/data/cart/cart_in_memory_repository.dart';
import 'package:flutter_architect03/src/data/products/product_in_memory_repository.dart';
import 'package:flutter_architect03/src/domain/cart/cart_repository.dart';
import 'package:flutter_architect03/src/domain/cart/usecases/add_product_to_cart_use_case.dart';
import 'package:flutter_architect03/src/domain/cart/usecases/edit_quantity_of_cart_item_use_case.dart';
import 'package:flutter_architect03/src/domain/cart/usecases/get_cart_use_case.dart';
import 'package:flutter_architect03/src/domain/cart/usecases/remove_item_to_from_use_case.dart';
import 'package:flutter_architect03/src/domain/products/get_products_use_case.dart';
import 'package:flutter_architect03/src/domain/products/product_repository.dart';
import 'package:flutter_architect03/src/presentation/cart/cart_bloc.dart';
import 'package:flutter_architect03/src/presentation/products/products_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void init() {
  registerProductDependencies();
  registerCartDependencies();
}

void registerProductDependencies() {
  getIt.registerFactory(() => ProductsBloc(getIt()));

  getIt.registerLazySingleton(() => GetProductsUseCase(getIt()));

  getIt.registerLazySingleton<ProductRepository>(() => ProductInMemoryRepository());
}

void registerCartDependencies() {
  getIt.registerFactory(() => CartBloc(getIt(),getIt(),getIt(),getIt(),getIt()));

  getIt.registerLazySingleton(() => GetCartUseCase(getIt()));
  getIt.registerLazySingleton(() => AddProductToCartUseCase(getIt()));
  getIt.registerLazySingleton(() => RemoveItemFromCartUseCase(getIt()));
  getIt.registerLazySingleton(() => EditQuantityOfCartItemUseCase(getIt()));

  getIt.registerLazySingleton<CartRepository>(() => CartInMemoryRepository());
}
