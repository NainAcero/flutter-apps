import 'package:flutter_delivery/domain/model/user.dart';

class LoginResponse {
  const LoginResponse(this.token, this.user);

  final String token;
  final User user;
}