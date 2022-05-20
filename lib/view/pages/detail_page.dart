import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_app/models/argument_pokemon.dart';
import 'package:pokemon_app/view/style/theme.dart';
import 'package:provider/provider.dart';

import '../../utils/format_number.dart';
import '../../view_model/pokemons_view_model.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PokemonsViewModel pokemonViewModel = context.watch<PokemonsViewModel>();
    final args = ModalRoute.of(context)?.settings.arguments as ArgumentPokemon;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: blueDarkColor,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                child: Hero(
                  tag: "ImageTag" + args.index.toString(),
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/image.png',
                      image:
                          'https://assets.pokemon.com/assets/cms2/img/pokedex/full/${addDigit(args.numberPokemon)}'),
                ),
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: (Radius.circular(10)),
                        topRight: (Radius.circular(10)))),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: (Radius.circular(10)),
                        bottomRight: (Radius.circular(10)))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Pokemon           : ${pokemonViewModel.responseDetailPokemon.name}',
                      style: textRegulerWhite,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Tinggi Pokemon           : ${pokemonViewModel.responseDetailPokemon.height / 10} m',
                      style: textRegulerWhite,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Berat Pokemon            : ${pokemonViewModel.responseDetailPokemon.weight / 10} kgs',
                      style: textRegulerWhite,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
