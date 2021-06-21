
import 'package:flutter_clean_arquitect02/layers/data/models/character_data.dart';

abstract class CharacterNetworkDatasource {
  /// Calls the https://rickandmortyapi.com/api/character/ endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  /// 
  Future<List<CharacterData>> getAllCharacters();
}