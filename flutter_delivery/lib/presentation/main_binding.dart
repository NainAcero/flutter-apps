
import 'package:flutter_delivery/data/datasource/api_repository_impl.dart';
import 'package:flutter_delivery/data/datasource/local_storage_impl.dart';
import 'package:flutter_delivery/domain/repository/api_repository.dart';
import 'package:flutter_delivery/domain/repository/local_storage_repository.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalRepositoryInterface>(() => LocalRepositoryImpl());
    Get.lazyPut<ApiRepositoryInterface>(() => ApiRepositoryImpl());
  }

}