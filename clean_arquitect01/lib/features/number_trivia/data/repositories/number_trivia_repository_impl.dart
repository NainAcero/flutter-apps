
import 'package:clean_arquitect01/core/error/exceptions.dart';
import 'package:clean_arquitect01/core/error/failures.dart';
import 'package:clean_arquitect01/core/network/network_info.dart';
import 'package:clean_arquitect01/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:clean_arquitect01/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:clean_arquitect01/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_arquitect01/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_arquitect01/features/number_trivia/domain/repositories/number_triva_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<NumberTrivia> _ConcreateOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {

  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo
  });

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreateOrRandomChooser getConcreteOrRandom,
  ) async {
    if(await networkInfo.isConnected) {
      try {
        final NumberTriviaModel remoteTrivia = await getConcreteOrRandom() as NumberTriviaModel;
        localDataSource.cacheNumberTrivia(
          remoteTrivia
        );
        return Right(remoteTrivia);
      } on ServerExpection {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheExpection {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) async{
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async{
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

}
