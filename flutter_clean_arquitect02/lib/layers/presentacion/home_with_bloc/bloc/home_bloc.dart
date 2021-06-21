
import 'package:bloc/bloc.dart';
import 'package:flutter_clean_arquitect02/layers/domain/usecases/get_all_characters.dart';
import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_bloc/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  
  final GetAllCharacters getAllCharacters;

  HomeCubit({required this.getAllCharacters}) : super(Initial());

  void showLoadingAndFetchCharacters() async {

    emit(Loading());

    final result = await getAllCharacters();

    final updateState = result.fold(
      (e) => Error(""), 
      (list) => Success(characterList: list)
    );

    emit(updateState);
  }
}