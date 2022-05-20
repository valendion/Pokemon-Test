import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pokemon_app/models/argument_pokemon.dart';
import 'package:pokemon_app/view/style/theme.dart';
import 'package:provider/provider.dart';

import '../../utils/format_number.dart';
import '../../view_model/pokemons_view_model.dart';
import '../widget/app_loading.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PokemonsViewModel pokemonViewModel = context.watch<PokemonsViewModel>();
    final args = ModalRoute.of(context)?.settings.arguments as ArgumentPokemon;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 30,
            bottom: 20,
            child: FloatingActionButton(
              heroTag: 'back',
              onPressed: () {
                int currentIndex = args.index;

                if (currentIndex != 0) {
                  currentIndex--;

                  var pokemon = pokemonViewModel.getPokemonIndex(currentIndex);
                  pokemonViewModel.getDetailPokemon(pokemon.name);
                  Navigator.pushReplacementNamed(context, '/detailPage',
                      arguments: ArgumentPokemon(
                          currentIndex,
                          int.parse(getNumberImage(pokemon.url)),
                          pokemon.name));
                } else {
                  notificationMessage('Anda sudah berada paling awal');
                }
              },
              child: const Icon(
                Icons.arrow_left,
                size: 40,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 30,
            child: FloatingActionButton(
              heroTag: 'next',
              onPressed: () {
                int currentIndex = args.index;

                if (currentIndex != pokemonViewModel.initPokemon.length - 1) {
                  currentIndex++;

                  var pokemon = pokemonViewModel.getPokemonIndex(currentIndex);
                  pokemonViewModel.getDetailPokemon(pokemon.name);
                  Navigator.pushReplacementNamed(context, '/detailPage',
                      arguments: ArgumentPokemon(
                          currentIndex,
                          int.parse(getNumberImage(pokemon.url)),
                          pokemon.name));
                } else {
                  notificationMessage('Anda sudah berada paling akhir');
                }
              },
              child: const Icon(
                Icons.arrow_right,
                size: 40,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: blueDarkColor,
        ),
      ),
      body: SafeArea(child: _uiDetail(pokemonViewModel, args)),
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

  _uiDetail(PokemonsViewModel pokemonsViewModel, ArgumentPokemon args) {
    if (pokemonsViewModel.loading) {
      return const AppLoading();
    }
    return Padding(
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
                  'Nama Pokemon           : ${pokemonsViewModel.responseDetailPokemon.name}',
                  style: textRegulerWhite,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Tinggi Pokemon           : ${pokemonsViewModel.responseDetailPokemon.height / 10} m',
                  style: textRegulerWhite,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Berat Pokemon            : ${pokemonsViewModel.responseDetailPokemon.weight / 10} kgs',
                  style: textRegulerWhite,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
