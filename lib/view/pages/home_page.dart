import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pokemonViewModel.loadMorePokemons(pokemonViewModel.pokemons.next);
          notificationMessage('Pokemon berhasil ditambahkan');
        },
        child: const Icon(Icons.add),
      ),
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
              onChanged: (value) => pokemonViewModel.resultData(value),
              decoration: InputDecoration(
                  fillColor: backgroundInputColor,
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Name'),
            ),
            const SizedBox(
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
      return const AppLoading();
    }

    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        itemCount: pokemonViewModel.resultPokemon.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 2,
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            mainAxisExtent: 150,
            crossAxisSpacing: 20),
        itemBuilder: (context, index) {
          return CardPokemon(
              name: pokemonViewModel.resultPokemon[index].name,
              numberPokemon: int.parse(
                  getNumberImage(pokemonViewModel.resultPokemon[index].url)));
        },
      ),
    );
  }

  notificationMessage(String? msg) {
    if (msg != null) {
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: whiteColor,
          textColor: blueColor,
          fontSize: 16.0);
    }
  }
}
