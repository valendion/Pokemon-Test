import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokemon_app/utils/format_number.dart';
import 'package:pokemon_app/view/style/theme.dart';

class CardPokemon extends StatelessWidget {
  final int numberPokemon;
  final String name;

  const CardPokemon({Key? key, required this.numberPokemon, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                FadeInImage.assetNetwork(
                    placeholder: 'assets/images/image.png',
                    image:
                        'https://assets.pokemon.com/assets/cms2/img/pokedex/full/${addDigit(numberPokemon)}'),
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
