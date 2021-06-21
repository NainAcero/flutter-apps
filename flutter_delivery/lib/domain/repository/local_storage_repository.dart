
import 'package:flutter_delivery/domain/model/user.dart';

abstract class LocalRepositoryInterface {
  Future<String?> getToken();
  Future<void> clearAllData();
  Future<User> saveUser(User user);
  Future<String?> saveToken(String token);
  Future<User> getUser();
  Future<void> saveDarkModel(bool darkModel);
  Future<bool?> isDarkModel();
}