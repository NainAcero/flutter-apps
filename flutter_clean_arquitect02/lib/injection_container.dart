
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_arquitect02/commons/network/network_info.dart';
import 'package:flutter_clean_arquitect02/layers/data/datasource/character_local_datasource.dart';
import 'package:flutter_clean_arquitect02/layers/data/datasource/character_network_datasource.dart';
import 'package:flutter_clean_arquitect02/layers/data/memory/in_memory_cache.dart';
import 'package:flutter_clean_arquitect02/layers/data/repositories/character_repository_impl.dart';
import 'package:flutter_clean_arquitect02/layers/domain/repositories/character_repository.dart';
import 'package:flutter_clean_arquitect02/layers/domain/usecases/get_all_characters.dart';
import 'package:flutter_clean_arquitect02/layers/local/datasources/character_local_datasource_impl.dart';
import 'package:flutter_clean_arquitect02/layers/network/datasources/character_network_datasource_impl.dart';
import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_bloc/bloc/home_bloc.dart';
import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_provider/notifiers/home_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {

  WidgetsFlutterBinding.ensureInitialized();

  // * Presenter Layer
  // to BLOC version
  sl.registerFactory(() => HomeCubit(getAllCharacters:sl() ));

  // to plain Provider version
  sl.registerFactory(
    () => HomeNotifier(getAllCharacters: sl()),
  );

  // * Domain Layer
  sl.registerFactory(() => GetAllCharacters(characterRepository: sl()));

  // * Data Layer
  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(
      localDatasource: sl(),
      networkDatasource: sl(),
      networkInfo: sl(),
      inMemoryCache: sl()
    )
  );

  sl.registerFactory(() => InMemoryCache());

  // * Network Layer
  sl.registerFactory<CharacterNetworkDatasource>(
    () => CharacterNetworkDatasourceImpl(client: sl()),
  );

  // * Local Layer
  sl.registerFactory<CharacterLocalDatasource>(
    () => CharacterLocalDatasourceImpl(sharedPreferences: sl())
  );

  // * Commons
  sl.registerFactory<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // * External
  final sharedPref = await SharedPreferences.getInstance();
  sl.registerFactory(() => sharedPref);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}