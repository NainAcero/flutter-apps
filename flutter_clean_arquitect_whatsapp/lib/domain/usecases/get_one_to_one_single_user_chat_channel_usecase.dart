import 'package:flutter_clean_arquitect_whatsapp/domain/repositories/firebase_repository.dart';

class GetOneToOneSingleUserChatChannelUseCase{
  final FirebaseRepository repository;

  GetOneToOneSingleUserChatChannelUseCase({required this.repository});

  Future<String> call(String uid,String otherUid)async{
    return await repository.getOneToOneSingleUserChannelId(uid, otherUid);
  }
}