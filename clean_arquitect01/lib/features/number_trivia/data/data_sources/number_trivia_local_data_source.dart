
import 'dart:convert';

import 'package:clean_arquitect01/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/number_trivia_model.dart';

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({ required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA,
      json.encode(
        triviaToCache.toJson()
      ),
    );
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);

    if(jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheExpection();
    }
  }

}