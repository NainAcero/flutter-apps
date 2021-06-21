import 'dart:convert';
import 'package:clean_arquitect01/core/error/exceptions.dart';
import 'package:clean_arquitect01/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({ required this.client});
  
  Future<NumberTriviaModel> _getTriviaFromUrl(Uri url) async {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if(response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    }else {
      throw ServerExpection();
    }
  }

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
    _getTriviaFromUrl(Uri.parse('http://numbersapi.com/$number'));
  
  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
    _getTriviaFromUrl(Uri.parse('http://numbersapi.com/random'));

}