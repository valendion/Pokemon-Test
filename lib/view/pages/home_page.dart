import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokemon_app/view/style/theme.dart';
import 'package:pokemon_app/view/widget/app_loading.dart';
import 'package:pokemon_app/view/widget/card_pokemon.dart';
import 'package:pokemon_app/view_model/pokemons_view_model.dart';
import 'package:provider/provider.dart';

import '../../utils/format_number.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PokemonsViewModel pokemonViewModel = context.watch<PokemonsViewModel>();

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Pokemon',
              style: textTitle,
            ),
            const SizedBox(height: 8),
            Text(
              'Carilah seekor Pokemon berdasarkan nama',
              style: textReguler,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                  fillColor: backgroundInputColor,
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  labelText: 'Name'),
            ),
            SizedBox(
              height: 16,
            ),
            _ui(pokemonViewModel)
          ],
        ),
      )),
    );
  }

  _ui(PokemonsViewModel pokemonViewModel) {
    if (pokemonViewModel.loading) {
      return AppLoading();
    }

    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        itemCount: pokemonViewModel.pokemons.results.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 2,
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            mainAxisExtent: 150,
            crossAxisSpacing: 20),
        itemBuilder: (context, index) {
          log('Number ${addDigit(getNumberImage(pokemonViewModel.pokemons.results[index].url))}');
          return CardPokemon(
              name: '${pokemonViewModel.pokemons.results[index].name}',
              numberPokemon: index + 1);
        },
      ),
    );
  }
}
