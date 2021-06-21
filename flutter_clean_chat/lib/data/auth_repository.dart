import 'package:flutter_clean_chat/domain/model/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser?> getAuthUser();
  Future<AuthUser> signIn();
  Future<void> logout();
}