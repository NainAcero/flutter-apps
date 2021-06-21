import 'package:flutter_clean_arquitect_whatsapp/domain/repositories/firebase_repository.dart';

class SignInWithPhoneNumberUseCase{
  final FirebaseRepository repository;

  SignInWithPhoneNumberUseCase({required this.repository});

  Future<void> call(String smsPinCode) async{
    return await repository.signInWithPhoneNumber(smsPinCode);
  }
}