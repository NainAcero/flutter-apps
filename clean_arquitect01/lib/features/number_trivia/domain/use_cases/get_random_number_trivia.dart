
import 'package:clean_arquitect01/core/error/failures.dart';
import 'package:clean_arquitect01/core/use_cases/use_case.dart';
import 'package:clean_arquitect01/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_arquitect01/features/number_trivia/domain/repositories/number_triva_repository.dart';
import 'package:dartz/dartz.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams>{
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}