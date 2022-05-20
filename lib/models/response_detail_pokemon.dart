class ResponseDetailPokemon {
  final int id;
  final String name;
  final int height;
  final int weight;

  ResponseDetailPokemon(
      {required this.id,
      required this.name,
      required this.height,
      required this.weight});

  factory ResponseDetailPokemon.fromJson(Map<String, dynamic> json) {
    return ResponseDetailPokemon(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
    );
  }
}
