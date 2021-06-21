import 'package:flutter_clean_arquitect_whatsapp/domain/entities/user_entity.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/repositories/firebase_repository.dart';

class GetCreateCurrentUserUseCase{
  final FirebaseRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> call(UserEntity user)async{
    return await repository.getCreateCurrentUser(user);
  }
}