import 'package:flutter_clean_chat/data/auth_repository.dart';
import 'package:flutter_clean_chat/data/stream_api_repository.dart';
import 'package:flutter_clean_chat/domain/exceptions/auth_exception.dart';
import 'package:flutter_clean_chat/domain/model/auth_user.dart';

class LoginUseCase {
  LoginUseCase(
    this.authRepository,
    this.streamApiRepository
  );

  final AuthRepository authRepository;
  final StreamApiRepository streamApiRepository;

  Future<bool> validateLogin() async {
    final user = await authRepository.getAuthUser();
    if(user != null) {
      final result = await streamApiRepository.connectIfExist(user.id);
      if(result) {
        return true;
      } else {
        throw AuthException(AuthErrorCode.not_chat_user);
      }
    }
    throw AuthException(AuthErrorCode.not_auth);
  }

  Future<AuthUser> signIn() async {
    return await authRepository.signIn();
  }
}