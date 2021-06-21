
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arquitect02/commons/errors/failurre.dart';
import 'package:flutter_clean_arquitect02/layers/domain/entities/character.dart';
import 'package:flutter_clean_arquitect02/layers/domain/repositories/character_repository.dart';

class GetAllCharacters {

  final CharacterRepository characterRepository;

  GetAllCharacters({required this.characterRepository});

  Future<Either<Failure, List<Character>>> call() async {
    return characterRepository.getAllCharacters();
  }
}