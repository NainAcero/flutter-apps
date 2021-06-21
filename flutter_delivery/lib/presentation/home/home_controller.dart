import 'package:flutter_delivery/domain/model/user.dart';
import 'package:flutter_delivery/domain/repository/api_repository.dart';
import 'package:flutter_delivery/domain/repository/local_storage_repository.dart';
import 'package:flutter_delivery/presentation/theme.dart.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  HomeController({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  Rx<User> user = User.empty().obs;
  RxInt indexSelected = 0.obs;
  RxBool darkTheme = false.obs;

  @override
  void onReady() {
    this._loadCurrentTheme();
    this._loadUser();
    super.onReady();
  }

  void _loadCurrentTheme() {
    localRepositoryInterface.isDarkModel().then((value) {
      darkTheme(value);
    });
  }

  void _loadUser() {
    localRepositoryInterface.getUser().then((value) {
      user(value);
    });
  }

  bool updateTheme(bool isDark){
    localRepositoryInterface.saveDarkModel(isDark);
    darkTheme(isDark);
    return isDark;
  }

  void updateIndexSelected(int index) {
    indexSelected(index);
  }

  Future<void> logOut() async{
    final token = await localRepositoryInterface.getToken();
    await apiRepositoryInterface.logout(token?? '');
    await localRepositoryInterface.clearAllData();
  }
}