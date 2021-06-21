

import 'package:clean_arquitect01/core/error/failures.dart';
import 'package:clean_arquitect01/core/use_cases/use_case.dart';
import 'package:clean_arquitect01/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_arquitect01/features/number_trivia/domain/repositories/number_triva_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Params extends Equatable {

  final int number;
  Params({required this.number});

  @override
  List<Object> get props => [number];
}

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);
  
  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async{
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

