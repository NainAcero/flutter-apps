
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arquitect02/commons/errors/failurre.dart';
import 'package:flutter_clean_arquitect02/layers/domain/entities/character.dart';


abstract class CharacterRepository {
  Future<Either<Failure, List<Character>>> getAllCharacters();
}