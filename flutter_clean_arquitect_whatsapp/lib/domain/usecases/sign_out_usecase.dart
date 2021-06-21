import 'package:flutter_clean_arquitect_whatsapp/domain/repositories/firebase_repository.dart';

class SignOutUseCase{
  final FirebaseRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call()async{
    return await repository.signOut();
  }
}