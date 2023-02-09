// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:poke_tiktok_flutter/app_constants.dart';
import 'package:poke_tiktok_flutter/general/controllers/general_controller.dart';

import '../controllers/pokemon.dart';
import '../controllers/server_error.dart';

class PokemonSliderAPI extends GetxController {
  GeneralController generalController = Get.put(GeneralController());

  Future<Either<ServerError, Pokemon>> loadPokemon(
      int lastLoadedPokemon) async {
    String pokemonToLoad = (lastLoadedPokemon + 1).toString();
    try {
      var response = await generalController.dioService
          .get('${AppConstants.apiUrl}/$pokemonToLoad');
      String name = json
          .decode(json.encode(response.data))['forms'][0]['name']
          .toString();
      List<String> types = [];
      for (var i = 0;
          i < json.decode(json.encode(response.data))['types'].length;
          i++) {
        types.add(json.decode(json.encode(response.data))['types'][i]['type']
            ['name']);
      }
      String hp = json
          .decode(json.encode(response.data))['stats'][0]['base_stat']
          .toString();
      String attack = json
          .decode(json.encode(response.data))['stats'][1]['base_stat']
          .toString();
      String defense = json
          .decode(json.encode(response.data))['stats'][2]['base_stat']
          .toString();
      String mainSpriteUrl =
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${pokemonToLoad}.png';
      String secondarySpriteUrl =
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/back/${pokemonToLoad}.png';
      List<String> moves = [];
      moves.add(generalController.capitalize(
          json.decode(json.encode(response.data))['moves'][0]['move']['name']));
      moves.add(generalController.capitalize(
          json.decode(json.encode(response.data))['moves'][1]['move']['name']));
      print(moves);
      Pokemon loadedPokemon = Pokemon(
          number: pokemonToLoad,
          name: name,
          types: types,
          hp: hp,
          attack: attack,
          defense: defense,
          mainSpriteUrl: mainSpriteUrl,
          secondarySpriteUrl: secondarySpriteUrl,
          moves: []);
      return Right(loadedPokemon);
    } catch (e) {
      print('API Call Error: ${e.toString()}');
      return Left(
        ServerError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}