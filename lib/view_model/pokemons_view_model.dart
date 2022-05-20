import 'package:flutter/foundation.dart';
import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/models/response_detail_pokemon.dart';
import 'package:pokemon_app/models/response_pokemons.dart';
import 'network/pokemon_service.dart';

class PokemonsViewModel extends ChangeNotifier {
  bool _loading = false;

  ResponsePokemons _pokemons =
      ResponsePokemons(count: 0, next: '', results: []);

  ResponseDetailPokemon _responseDetailPokemon =
      ResponseDetailPokemon(id: 0, name: '', height: 0, weight: 0);

  final List<Pokemon> _initPokemons = [];

  final List<Pokemon> _resultPokemon = [];

  bool get loading => _loading;

  ResponsePokemons get pokemons => _pokemons;
  ResponseDetailPokemon get responseDetailPokemon => _responseDetailPokemon;
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

  _setpokemons(ResponsePokemons pokemons) {
    _pokemons = pokemons;
  }

  _setDetailPokemon(ResponseDetailPokemon detailPokemon) {
    _responseDetailPokemon = detailPokemon;
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

    _setpokemons(response);
    setInitPokemon(pokemons.results);
    setResultPokemon(initPokemon);

    _setLoading(false);
  }

  void loadMorePokemons(String url) async {
    _setLoading(true);

    ResponsePokemons response = await PokemonService.getLoadMorePokemons(url);

    _setpokemons(response);
    setInitPokemon(response.results);
    setResultPokemon(initPokemon);

    _setLoading(false);
  }

  void getDetailPokemon(String url) async {
    _setLoading(true);

    ResponseDetailPokemon response = await PokemonService.getDetailPokemon(url);

    _setDetailPokemon(response);

    _setLoading(false);
  }
}
