
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arquitect02/commons/errors/failurre.dart';
import 'package:flutter_clean_arquitect02/commons/exceptions/exceptions.dart';
import 'package:flutter_clean_arquitect02/commons/network/network_info.dart';
import 'package:flutter_clean_arquitect02/layers/data/datasource/character_local_datasource.dart';
import 'package:flutter_clean_arquitect02/layers/data/datasource/character_network_datasource.dart';
import 'package:flutter_clean_arquitect02/layers/data/memory/in_memory_cache.dart';
import 'package:flutter_clean_arquitect02/layers/domain/entities/character.dart';
import 'package:flutter_clean_arquitect02/layers/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {

  final NetworkInfo networkInfo;
  final CharacterLocalDatasource localDatasource;
  final CharacterNetworkDatasource networkDatasource;
  final InMemoryCache inMemoryCache;

   CharacterRepositoryImpl({
    required this.networkInfo,
    required this.localDatasource,
    required this.networkDatasource,
    required this.inMemoryCache,
  });

  @override
  Future<Either<Failure, List<Character>>> getAllCharacters() async{
    if(inMemoryCache.isNotEmpty && inMemoryCache.hasNotExpired) {
      return Right(inMemoryCache.getCachedValue());
    }

    return await networkInfo.isConnected 
      ? _getAllCharactersFromNetwork()
      : _getAllCharactersFromLocalCache();
  }

  Future<Either<Failure, List<Character>>>_getAllCharactersFromNetwork() async {
    try {
      final allCharactersList = await networkDatasource.getAllCharacters();
      await localDatasource.cacheCharacterList(allCharactersList);
      inMemoryCache.save(allCharactersList);
      return Right(allCharactersList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<Character>>> _getAllCharactersFromLocalCache() async {
    try {
      final allCharactersList = await localDatasource.getAllCharacters();
      inMemoryCache.save(allCharactersList);
      return Right(allCharactersList);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}