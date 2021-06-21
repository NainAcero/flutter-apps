
import 'package:flutter_delivery/domain/model/user.dart';
import 'package:flutter_delivery/domain/repository/local_storage_repository.dart';

class LocalRepositoryMock extends LocalRepositoryInterface{
  @override
  Future<void> clearAllData() {
    // TODO: implement clearAllData
    throw UnimplementedError();
  }

  @override
  Future<String?> getToken() {
    // TODO: implement getToken
    throw UnimplementedError();
  }

  @override
  Future<User> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<bool?> isDarkModel() => Future.value(false);

  @override
  Future<void> saveDarkModel(bool darkModel) {
      // TODO: implement saveDarkModel
      throw UnimplementedError();
    }
  
    @override
    Future<String?> saveToken(String token) {
      // TODO: implement saveToken
      throw UnimplementedError();
    }
  
    @override
    Future<User> saveUser(User user) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }

}