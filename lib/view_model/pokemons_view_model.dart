import 'package:flutter/foundation.dart';
import 'package:pokemon_app/models/ResponsePokemons.dart';

import 'network/pokemon_service.dart';

class PokemonsViewModel extends ChangeNotifier {
  bool _loading = false;

  ResponsePokemons _pokemons =
      ResponsePokemons(count: 0, next: "", results: []);

  bool get loading => _loading;
  ResponsePokemons get pokemons => _pokemons;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setpokemons(ResponsePokemons pokemons) {
    _pokemons = pokemons;
  }

  PokemonsViewModel() {
    getPokemons();
  }

  void getPokemons() async {
    setLoading(true);
    ResponsePokemons response = await PokemonService.getPokemons();
    setpokemons(response);
    setLoading(false);
  }
}
