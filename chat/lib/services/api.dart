import 'package:http/http.dart' as http;

class Api {
  static final _api = Api._internal();

  factory Api() {
    return _api;
  }

  Api._internal();

  String token;
  String baseUrl = '192.168.0.14:8000';
  String path = 'api';

  Future<http.Response> httpGet(String endPath, {Map<String, String> query}) {
    Uri uri = (query != null)?  Uri.http(baseUrl, '$path/$endPath', query) : 
                              Uri.http(baseUrl, '$path/$endPath');

    return http.get(uri, headers: {
      'Authorization' : 'Bearer $token',
      'Accept' : 'application/json'
    });
  }

  Future<http.Response> httpPost(String endPath, Object body) {
    Uri uri = Uri.http(baseUrl, '$path/$endPath');

    return http.post(uri, body: body, headers: {
      'Authorization' : 'Bearer $token',
      'Accept' : 'application/json'
    });
  }
}