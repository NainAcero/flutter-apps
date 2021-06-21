import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/usecases/create_one_to_one_chat_channel_usecase.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/usecases/get_all_user_usecase.dart';
import 'package:flutter_clean_arquitect_whatsapp/presentation/bloc/user/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetAllUserUseCase getAllUserUseCase;
  final CreateOneToOneChatChannelUseCase createOneToOneChatChannelUseCase;

  UserCubit({
    required this.getAllUserUseCase,
    required this.createOneToOneChatChannelUseCase,
  }) : super(UserInitial());

  Future<void> getAllUsers() async {
    try{
     final userStreamData = getAllUserUseCase.call();
     userStreamData.listen((users) {
       emit(UserLoaded(users));
     });
   }on SocketException catch(_){
     emit(UserFailure());
   }catch(_){
     emit(UserFailure());
   }
  }

  Future<void> createChatChannel({required String uid,required String otherUid}) async {
    try{
      await createOneToOneChatChannelUseCase.call(uid, otherUid);
    }on SocketException catch(_){
      emit(UserFailure());
    }catch(_){
      emit(UserFailure());
    }
  }
}