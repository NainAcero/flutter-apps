import 'package:dio/dio.dart';
import 'package:flutter_maps/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchAPI {
  SearchAPI._internal();
  static SearchAPI get instance => SearchAPI._internal();

  final Dio _dio = Dio();

  Future<List<Place>> searchPlace(String query, LatLng at) async {
    final response = await this._dio.get(
      'https://places.ls.hereapi.com/places/v1/autosuggest',
      queryParameters: {
        "q": query,
        "apiKey": "ZN3AGFX8MkoWCbReNlQhHhN7AN-yosrOypjW1rTzVaw",
        "at": "${at.latitude},${at.longitude}",
      },
    );
    final List<Place> places = (response.data['results'] as List)
        .where((element) => element['position'] != null)
        .map((item) => Place.fromJson(item))
        .toList();
    return places;
  }
}