
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_arquitect02/layers/domain/entities/character.dart';

abstract class HomeState extends Equatable {

  const HomeState();

  @override
  List<Object?> get props => [];

}

class Initial extends HomeState {}

class Loading extends HomeState {}

class Error extends HomeState {
  final String errorMessage;

  Error(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class Success extends HomeState {
  final List<Character> characterList;

  Success({required this.characterList});

  @override
  List<Object?> get props => [characterList];
}