
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/entities/my_chat_entity.dart';

abstract class MyChatState extends Equatable {
  const MyChatState();
}

class MyChatInitial extends MyChatState {
  @override
  List<Object> get props => [];
}

class MyChatLoaded extends MyChatState {
  final List<MyChatEntity> myChat;

  MyChatLoaded({required this.myChat});
  
  @override
  List<Object> get props => [myChat];
}