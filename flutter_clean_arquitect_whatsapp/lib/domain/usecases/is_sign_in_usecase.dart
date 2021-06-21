import 'package:flutter_clean_arquitect_whatsapp/domain/repositories/firebase_repository.dart';

class IsSignInUseCase{
  final FirebaseRepository repository;

  IsSignInUseCase({required this.repository});

  Future<bool> call() async{
    return await repository.isSignIn();
  }
}