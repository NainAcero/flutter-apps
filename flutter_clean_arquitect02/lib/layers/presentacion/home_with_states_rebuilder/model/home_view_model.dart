
import 'package:flutter_clean_arquitect02/layers/domain/entities/character.dart';
import 'package:flutter_clean_arquitect02/layers/domain/usecases/get_all_characters.dart';

class HomeViewModel {

  final GetAllCharacters _getAllCharacters;

  HomeViewModel({
    required GetAllCharacters getAllCharacters
  }) : this._getAllCharacters = getAllCharacters;

  // bool isLoading = false; // * No need to loading
  List<Character>? charList;
  String? error;

  Future<void> loadAllCharacters() async {
    final result = await _getAllCharacters();

    result.fold(
      (e) => error = 'Error', 
      (list) => charList = list 
    );
  }

}