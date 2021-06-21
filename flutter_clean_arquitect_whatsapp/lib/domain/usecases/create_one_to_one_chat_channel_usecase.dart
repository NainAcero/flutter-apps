
import 'package:flutter_clean_arquitect_whatsapp/domain/repositories/firebase_repository.dart';

class CreateOneToOneChatChannelUseCase{
  final FirebaseRepository repository;

  CreateOneToOneChatChannelUseCase({required this.repository});

  Future<void> call(String uid,String otherUid)async{
    return repository.createOneToOneChatChannel(uid, otherUid);
  }
}