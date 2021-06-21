// This contains a dummy entry point, and is opted out
// @dart=2.9
import 'package:flutter_clean_arquitect02/commons/exceptions/exceptions.dart';
import 'package:flutter_clean_arquitect02/layers/data/models/character_data.dart';
import 'package:flutter_clean_arquitect02/layers/network/datasources/character_network_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../test_resources/fixtures/fixture_reader.dart';


class HttpClientMock extends Mock implements http.Client {}

void main() {
  CharacterNetworkDatasourceImpl datasource;
  http.Client httpClientMock;

 setUp(() {
    httpClientMock = HttpClientMock();
    datasource = CharacterNetworkDatasourceImpl(client: httpClientMock);
  });

  void setUpMockHttpClientSuccess200() {

    when(httpClientMock.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('all_characters.json'), 200));
  }

  void setUpMockHttpClientFailure404() {

    when(httpClientMock.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

    test(
    'It should call the right endpoint when asking for all characters',
    () async {
      // arrange
      setUpMockHttpClientSuccess200();

      // act
      await datasource.getAllCharacters();

      // assert
      verify(httpClientMock.get(
        Uri.parse("https://rickandmortyapi.com/api/character/"),
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    },
  );

  test(
    'should return List<CharacterData> when the response code is 200 (success)',
    () async {
      // arrange
      setUpMockHttpClientSuccess200();

      // act
      final result = await datasource.getAllCharacters();
      // assert
      expect(result, isA<List<CharacterData>>());
    },
  );

  test(
    'when the code is 404 it should return error',
    () async {
      // arrange
      setUpMockHttpClientFailure404();

      // act
      final call = datasource.getAllCharacters;

      // assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    }
  );
}
