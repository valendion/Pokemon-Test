import 'package:pokemon_app/models/Pokemon.dart';

class ResponsePokemons {
  final int count;
  final String next;
  final String? previous;
  List<Pokemon> results;

  ResponsePokemons(
      {required this.count,
      required this.next,
      this.previous,
      required this.results});

  factory ResponsePokemons.fromJson(Map<String, dynamic> json) {
    return ResponsePokemons(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: List<Pokemon>.from(
            json['results'].map((data) => Pokemon.fromJson(data))));
  }
}
