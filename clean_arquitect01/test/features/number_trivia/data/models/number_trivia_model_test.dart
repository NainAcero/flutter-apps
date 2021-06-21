
import 'dart:convert';

import 'package:clean_arquitect01/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_arquitect01/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_arquitect01/fixtures/fixture_reader.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(
    number: 1,
    text: 'Test text.'
  );

  test(
    'should be a subclass of NumberTrivia entity', () async {
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    }
  );

  group(
    'fromJson', () {
      test(
        'should return a valid model when the JSON number is a interger',
          () async {
            final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
            final result = NumberTriviaModel.fromJson(jsonMap);
            expect(result, tNumberTriviaModel);
          }
      );

      test(
        'should return a valid model when the JSON number is regarded as a double',
        () async{
          final Map<String, dynamic> jsonMap = json.decode(fixture('trivia_double.json'));
          final result = NumberTriviaModel.fromJson(jsonMap);
          expect(result, tNumberTriviaModel);
        }
      );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () {
        final result = tNumberTriviaModel.toJson();
        final expectedMap = {"number": 1, "text": "Test text."};
        expect(result, expectedMap);
      }
    );
  });
}