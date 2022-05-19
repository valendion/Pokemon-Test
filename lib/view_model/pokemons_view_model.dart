import 'package:flutter/foundation.dart';
import 'package:pokemon_app/models/Pokemon.dart';
import 'package:pokemon_app/models/ResponsePokemons.dart';

import 'network/pokemon_service.dart';

class PokemonsViewModel extends ChangeNotifier {
  bool _loading = false;

  ResponsePokemons _pokemons =
      ResponsePokemons(count: 0, next: "", results: []);

  List<Pokemon> _initPokemons = [];

  List<Pokemon> _resultPokemon = [];

  bool get loading => _loading;

  ResponsePokemons get pokemons => _pokemons;
  List<Pokemon> get initPokemon => _initPokemons;
  List<Pokemon> get resultPokemon => _resultPokemon;

  setInitPokemon(List<Pokemon> pokemons) {
    for (var value in pokemons) {
      {
        _initPokemons.add(value);
      }
    }
    notifyListeners();
  }

  setResultPokemon(List<Pokemon> pokemons) {
    resultPokemon.clear();
    for (var value in pokemons) {
      {
        _resultPokemon.add(value);
      }
    }
    notifyListeners();
  }

  _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setpokemons(ResponsePokemons pokemons) {
    _pokemons = pokemons;
  }

  PokemonsViewModel() {
    getPokemons();
  }

  resultData(String inputName) {
    if (inputName.isEmpty) {
      setResultPokemon(initPokemon);
      notifyListeners();
    } else {
      setResultPokemon(initPokemon
          .where((pokemon) =>
              pokemon.name.toLowerCase().contains(inputName.toLowerCase()))
          .toList());
      notifyListeners();
    }
  }

  void getPokemons() async {
    _setLoading(true);
    ResponsePokemons response = await PokemonService.getPokemons();

    setpokemons(response);
    setInitPokemon(pokemons.results);
    setResultPokemon(initPokemon);

    _setLoading(false);
  }

  void loadMorePokemons(String url) async {
    _setLoading(true);
    ResponsePokemons response = await PokemonService.getLoadMorePokemons(url);
    setpokemons(response);
    setInitPokemon(response.results);
    setResultPokemon(initPokemon);
    _setLoading(false);
  }
}
