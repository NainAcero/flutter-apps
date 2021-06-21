
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_arquitect02/layers/domain/entities/character.dart';
import 'package:flutter_clean_arquitect02/layers/domain/usecases/get_all_characters.dart';

class HomeNotifier with ChangeNotifier {

  final GetAllCharacters _getAllCharacters;

  HomeNotifier({ required GetAllCharacters getAllCharacters,})
    : _getAllCharacters = getAllCharacters;

  late bool isLoading = false;
  List<Character>? characterList;
  String? error;

  Future<void> loadCharacters() async {

    // show loading
    isLoading = true;
    notifyListeners();

    // Fetch the list
    final result = await _getAllCharacters();

    // Handle success or error
    result.fold((e) {
      error = "fail";
      isLoading = false;
    }, (list) {
      characterList = list;
      isLoading = true;
    });

    notifyListeners();
  }


}