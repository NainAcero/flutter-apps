
import 'package:clean_arquitect01/core/error/failures.dart';
import 'package:clean_arquitect01/core/use_cases/use_case.dart';
import 'package:clean_arquitect01/core/utils/input_converter.dart';
import 'package:clean_arquitect01/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_arquitect01/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:clean_arquitect01/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:clean_arquitect01/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server failure.';
const String CACHE_FAILURE_MESSAGE = 'Cache failure.';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;
  
  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  })  : super(Empty());

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event) async*{
    if(event is GetTriviaForConcreteNumber) {
      final inputEiter = inputConverter.stringToUnsignedInteger(
        event.numberString,
      );

      yield* inputEiter.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        }, 
        (integer) async* {
          yield Loading();
          final failureOrTrivia = await getConcreteNumberTrivia(
            Params(number: integer),
          );
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
        }
      );

    } else if(event is GetTriviaForRandomNumber) {
      yield Loading();
      final failureOrTrivia = await getRandomNumberTrivia(
        NoParams(),
      );

      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failure, NumberTrivia> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (failure) => Error(
        message: _mapFailureToMessage(failure),
      ),
      (trivia) => Loaded(trivia: trivia),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error.';
    }
  }
}