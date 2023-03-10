import 'package:either_dart/either.dart';
import 'package:poke_tiktok_flutter/pokemon-slider/api/pokemon_slider_api.dart';
import '../controllers/pokemon.dart';
import '../controllers/server_error.dart';

class PokemonSliderRepository {
  PokemonSliderAPI pokemonSliderAPI = PokemonSliderAPI();
  Future<Either<ServerError, Pokemon>> loadPokemon(
      int lastLoadedPokemon) async {
    return await pokemonSliderAPI.loadPokemon(lastLoadedPokemon);
  }
}
