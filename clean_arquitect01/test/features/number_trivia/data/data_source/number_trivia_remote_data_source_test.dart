// This contains a dummy entry point, and is opted out
// @dart=2.9
import 'dart:convert';

import 'package:clean_arquitect01/core/error/exceptions.dart';
import 'package:clean_arquitect01/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:clean_arquitect01/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_arquitect01/fixtures/fixture_reader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {

  NumberTriviaRemoteDataSourceImpl remoteDataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSource = NumberTriviaRemoteDataSourceImpl(
      client: mockHttpClient,
    );
  });

  void setUpMockHttpClientSucess200() {
    when(
      mockHttpClient.get(
        any,
        headers: anyNamed('headers')
      ),
    ).thenAnswer(
      (_) async => http.Response(fixture('trivia.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(
      mockHttpClient.get(
        any,
        headers: anyNamed('headers'),
      ),
    ).thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group(
    'getConcreteNumberTrivia', () {
      final tNumber = 1;
      final tNumberTriviaModel = NumberTriviaModel.fromJson(
        json.decode(
          fixture('trivia.json')
        ),
      );

      test(
        '''should perform a GET request on a URL with number
        being the endpoint and with application/json header''',
        () async {
          setUpMockHttpClientSucess200();

          remoteDataSource.getConcreteNumberTrivia(tNumber);

          verify(
            mockHttpClient.get(
              Uri.parse('http://numbersapi.com/$tNumber'),
              headers: {
                'Content-Type': 'application/json',
              }
            )
          );
        }
      );

      test(
        'should return NumberTrivia when the response code is 200 (success)',
        () async {
          setUpMockHttpClientSucess200();

          final result = await remoteDataSource.getConcreteNumberTrivia(tNumber);
          expect(result, equals(tNumberTriviaModel));
        }
      );

      test(
        'should throw a server exception when the response code is 404 or other',
        () async {
          setUpMockHttpClientFailure404();

          final call = remoteDataSource.getConcreteNumberTrivia;
          expect(() => call(tNumber), throwsA(TypeMatcher<ServerExpection>()));
        }
      );
    }
  );

  group(
    'getRandomNumberTrivia', () {
      final tNumberTriviaModel = NumberTriviaModel.fromJson(
        json.decode(
          fixture('trivia.json'),
        ),
      );

      test(
        '''should perform a GET request on a URL with number
        being the endpoint and with application/json header''',
        () async {
          setUpMockHttpClientSucess200();

          remoteDataSource.getRandomNumberTrivia();

          verify(
            mockHttpClient.get(
              Uri.parse('http://numbersapi.com/random'),
              headers: {
                'Content-Type': 'application/json',
              },
            ),
          );
        }
      );

      test(
        'should return NumberTrivia when the response code is 200 (success)',
        () async {
          setUpMockHttpClientSucess200();

          final result = await remoteDataSource.getRandomNumberTrivia();

          expect(result, equals(tNumberTriviaModel));
        }
      );

      test(
        'should throw a server exception when the response code is 404 or other',
        () async {
          setUpMockHttpClientFailure404();

          final call = remoteDataSource.getRandomNumberTrivia;
          expect(() => call(), throwsA(TypeMatcher<ServerExpection>()));
        }
      );
    }
  );

}