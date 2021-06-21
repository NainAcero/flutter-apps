// This contains a dummy entry point, and is opted out
// @dart=2.9
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arquitect02/layers/domain/repositories/character_repository.dart';
import 'package:flutter_clean_arquitect02/layers/domain/usecases/get_all_characters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test_resources/fake/characters_fake_factory.dart';

class CharacterRepositoryMock extends Mock implements CharacterRepository {}

void main() {
  GetAllCharacters getAllCharacters;
  CharacterRepositoryMock characterRepositoryMock;

  setUp(() {
    characterRepositoryMock = CharacterRepositoryMock();
    getAllCharacters = GetAllCharacters(
      characterRepository: characterRepositoryMock,
    );
  });

  final testCharacters = CharacterFakeFactory.createList(size: 10);
  
  test(
    'it should fetch a list of characters from CharacterRepository',
    () async {
      // arrange
      when(characterRepositoryMock.getAllCharacters())
          .thenAnswer((realInvocation) async => Right(testCharacters));

      // act
      final result = await getAllCharacters();

      // assert
      expect(result, Right(testCharacters));
      verify(characterRepositoryMock.getAllCharacters());
      verifyNoMoreInteractions(characterRepositoryMock);
    },
  );
}