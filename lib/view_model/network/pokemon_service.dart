import 'dart:convert';

import 'package:pokemon_app/models/ResponsePokemons.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/utils/constans.dart';

class PokemonService {
  static Future<ResponsePokemons> getPokemons() async {
    final response = await http.get(Uri.parse(BASE_URL + FIRST_LIMIT_URL));

    if (response.statusCode == SUCCESS) {
      return ResponsePokemons.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }
}
