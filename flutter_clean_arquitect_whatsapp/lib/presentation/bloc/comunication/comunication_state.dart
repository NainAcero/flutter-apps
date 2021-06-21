import 'package:equatable/equatable.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/entities/text_message_entity.dart';

abstract class CommunicationState extends Equatable {
  const CommunicationState();
}

class CommunicationInitial extends CommunicationState {
  @override
  List<Object> get props => [];
}

class CommunicationLoading extends CommunicationState {
  @override
  List<Object> get props => [];
}

class CommunicationLoaded extends CommunicationState {
  final List<TextMessageEntity> messages;
  CommunicationLoaded({required this.messages});

  @override
  List<Object> get props => [messages];
}

class CommunicationFailure extends CommunicationState {
  @override
  List<Object> get props => [];
}