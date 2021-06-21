
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadButtonClickEvent extends HomeEvent {}