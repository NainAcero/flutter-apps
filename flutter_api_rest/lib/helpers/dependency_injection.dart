
import 'package:dio/dio.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/helpers/http.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

abstract class DependencyInjection {
  static void initialize() {
    final Dio dio = Dio(
      BaseOptions(baseUrl: 'https://curso-api-flutter.herokuapp.com'),
    );
    Logger logger = Logger();
    Http http = Http(
      dio: dio,
      logger: logger,
      logsEnabled: true,
    );
    final AuthenticationAPI authenticationAPI = AuthenticationAPI(http);

    GetIt.instance.registerSingleton<AuthenticationAPI>(authenticationAPI); 
  }
}