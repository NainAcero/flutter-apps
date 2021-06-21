
import 'package:flutter_clean_chat/data/auth_repository.dart';
import 'package:flutter_clean_chat/domain/model/auth_user.dart';

class AuthLocalImpl extends AuthRepository {

  @override
  Future<AuthUser> getAuthUser() async{
    await Future.delayed(const Duration(seconds: 2));
    return AuthUser('nain');
  }

  @override
  Future<AuthUser> signIn() async{
    await Future.delayed(const Duration(seconds: 2));
    return AuthUser('nain');
  }

  @override
  Future<void> logout() async{
    return;
  }
}