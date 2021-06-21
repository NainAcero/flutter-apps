
import 'dart:convert';

import 'package:flutter_clean_arquitect02/commons/exceptions/exceptions.dart';
import 'package:flutter_clean_arquitect02/layers/data/datasource/character_network_datasource.dart';
import 'package:flutter_clean_arquitect02/layers/data/models/character_data.dart';

import 'package:http/http.dart' as http;

class CharacterNetworkDatasourceImpl implements CharacterNetworkDatasource {
  final http.Client client;

  CharacterNetworkDatasourceImpl({required this.client});

  @override
  Future<List<CharacterData>> getAllCharacters() async  {
    final response = await client.get(
      Uri.parse("https://rickandmortyapi.com/api/character/"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> infoAndResult = json.decode(response.body);
      List<dynamic> result = infoAndResult['results'];

      List<CharacterData> charactersList = [];

      for (Map<String, dynamic> item in result) {
        charactersList.add(CharacterData.fromJson(item));
      }

      return charactersList;
    } else {
      throw ServerException();
    }
  }

}