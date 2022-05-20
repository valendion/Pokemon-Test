import 'package:flutter/material.dart';
import 'package:pokemon_app/models/argument_pokemon.dart';
import 'package:pokemon_app/utils/format_number.dart';
import 'package:pokemon_app/view/style/theme.dart';
import 'package:provider/provider.dart';
import '../../view_model/pokemons_view_model.dart';

class CardPokemon extends StatelessWidget {
  final int numberPokemon;
  final String name;
  final int index;

  const CardPokemon(
      {Key? key,
      required this.numberPokemon,
      required this.name,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PokemonsViewModel pokemonViewModel = context.watch<PokemonsViewModel>();

    return GestureDetector(
      onTap: () {
        pokemonViewModel.getDetailPokemon(name);
        Navigator.pushNamed(context, '/detailPage',
            arguments: ArgumentPokemon(index, numberPokemon, name));
      },
      child: Wrap(children: [
        Card(
          color: blueColor,
          elevation: 5,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: whiteColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Hero(
                  tag: "ImageTag" + index.toString(),
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/image.png',
                      image:
                          'https://assets.pokemon.com/assets/cms2/img/pokedex/full/${addDigit(numberPokemon)}'),
                ),
                Text(
                  name,
                  style: textReguler,
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
