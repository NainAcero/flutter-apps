
import 'package:clean_arquitect01/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class InvalidInputFailure extends Failure { }

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String string) {
    try {

      final integer = int.parse(string);

      if(integer < 0) {
        throw FormatException();
      }
      
      return Right(integer);

    } on FormatException{
      return Left(InvalidInputFailure());
    }
  }
}