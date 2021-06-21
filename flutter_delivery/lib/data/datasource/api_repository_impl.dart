
import 'package:flutter_delivery/data/in_memory_products.dart';
import 'package:flutter_delivery/domain/exception/auth_exception.dart';
import 'package:flutter_delivery/domain/model/product.dart';
import 'package:flutter_delivery/domain/model/user.dart';
import 'package:flutter_delivery/domain/repository/api_repository.dart';
import 'package:flutter_delivery/domain/response/login_response.dart';
import 'package:flutter_delivery/domain/request/login_request.dart';

class ApiRepositoryImpl extends ApiRepositoryInterface{
  @override
  Future<User> getUserFromToken(String token) async{
    await Future.delayed(const Duration(seconds: 3));
    if(token == 'AA111') {
      return User(
        name: 'Nain Acero Mamani',
        username: 'nainacero',
        image: 'assets/nain.jpg'
      );
    } else if(token == 'AA222') {
      return User(
        name: 'Nain Acero Mamani 2',
        username: 'nainacero2',
        image: 'assets/nain2.jpg'
      );
    }

    throw AuthException();
  }
  
  @override
  Future<LoginResponse> login(LoginRequest login) async{
    await Future.delayed(const Duration(seconds: 3));
    if(login.username == 'nainacero' && login.password == 'nainacero'){
        return LoginResponse(
          'AA111',
          User(
            name: 'Nain Acero Mamani',
            username: 'nainacero',
            image: 'assets/nain.jpg'
          ),
        );
    }else if(login.username == 'nainacero2' && login.password == 'nainacero2'){
        return LoginResponse(
          'AA222',
          User(
            name: 'Nain Acero Mamani 2',
            username: 'nainacero2',
            image: 'assets/nain2.jpg'
          ),
        );
    }
    throw AuthException();
  }
  
  @override
  Future<void> logout(String token) async{
    print('removing token from server');
    return;
  }

  @override
  Future<List<Product>> getProducts() async{
    await Future.delayed(const Duration(seconds: 1));
    return products;
  }

}