
import 'package:flutter_delivery/domain/model/user.dart';
import 'package:flutter_delivery/domain/model/product.dart';
import 'package:flutter_delivery/domain/repository/api_repository.dart';
import 'package:flutter_delivery/domain/response/login_response.dart';
import 'package:flutter_delivery/domain/request/login_request.dart';

class ApiRepositoryMock extends ApiRepositoryInterface{
  @override
  Future<List<Product>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<User> getUserFromToken(String token) {
      // TODO: implement getUserFromToken
      throw UnimplementedError();
    }
  
    @override
    Future<LoginResponse> login(LoginRequest login) {
      // TODO: implement login
      throw UnimplementedError();
    }
  
    @override
    Future<void> logout(String token) {
    // TODO: implement logout
    throw UnimplementedError();
  }

}