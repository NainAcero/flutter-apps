import 'package:flutter_clean_arquitect_whatsapp/domain/entities/my_chat_entity.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/repositories/firebase_repository.dart';

class GetMyChatUseCase{
  final FirebaseRepository repository;

  GetMyChatUseCase({required this.repository});

  Stream<List<MyChatEntity>> call(String uid){
    return repository.getMyChat(uid);
  }
}