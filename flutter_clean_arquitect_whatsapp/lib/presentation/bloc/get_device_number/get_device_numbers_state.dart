
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/entities/contact_entity.dart';

abstract class GetDeviceNumbersState extends Equatable {
  const GetDeviceNumbersState();
}

class GetDeviceNumbersInitial extends GetDeviceNumbersState {
  @override
  List<Object> get props => [];
}

class GetDeviceNumbersLoading extends GetDeviceNumbersState {
  @override
  List<Object> get props => [];
}

class GetDeviceNumbersLoaded extends GetDeviceNumbersState {
  final List<ContactEntity> contacts;

  GetDeviceNumbersLoaded({required this.contacts});
  
  @override
  List<Object> get props => [];
}

class GetDeviceNumbersFailure extends GetDeviceNumbersState {
  @override
  List<Object> get props => [];
}