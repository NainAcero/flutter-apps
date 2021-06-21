import 'package:flutter_delivery/domain/repository/api_repository.dart';
import 'package:flutter_delivery/domain/repository/local_storage_repository.dart';
import 'package:flutter_delivery/presentation/routes/delivery_navigation.dart';
import 'package:flutter_delivery/presentation/theme.dart.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  SplashController({
    required this.localRepositoryInterface, 
    required this.apiRepositoryInterface
  });

  @override
  void onInit() {
    _validateTheme();
    super.onInit();
  }

  @override
  void onReady() {
    this._validateSession();
    super.onReady();
  }

  void _validateTheme() async{
    final isDark = await localRepositoryInterface.isDarkModel();
    if(isDark != null){
      Get.changeTheme(isDark ? darkTheme : lighTheme);
    }else {
      Get.changeTheme(Get.isDarkMode ? darkTheme : lighTheme);
    }
  }

  void _validateSession() async{
    final token = await localRepositoryInterface.getToken();
    if(token != null) {
      final user = await apiRepositoryInterface.getUserFromToken(token);
      await localRepositoryInterface.saveUser(user);
      Get.offNamed(DeliveryRoutes.home);
    }else {
      Get.offNamed(DeliveryRoutes.login);
    }
  }


}