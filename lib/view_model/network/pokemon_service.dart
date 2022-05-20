import 'dart:convert';

import 'package:pokemon_app/models/response_detail_pokemon.dart';
import 'package:pokemon_app/models/response_pokemons.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/utils/constans.dart';

class PokemonService {
  static Future<ResponsePokemons> getPokemons() async {
    final response = await http.get(Uri.parse(BASE_URL + FIRST_LIMIT_URL));

    if (response.statusCode == SUCCESS) {
      return ResponsePokemons.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }

  static Future<ResponsePokemons> getLoadMorePokemons(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == SUCCESS) {
      return ResponsePokemons.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load more');
    }
  }

  static Future<ResponseDetailPokemon> getDetailPokemon(String url) async {
    final response =
        await http.get(Uri.parse(BASE_URL + DETAIL_POKEMON_URL + url));

    if (response.statusCode == SUCCESS) {
      return ResponseDetailPokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load detail');
    }
  }
}
