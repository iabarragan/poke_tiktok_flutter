import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:get/get.dart';
import 'package:poke_tiktok_flutter/pokemon-slider/controllers/pokemon.dart';
import 'package:poke_tiktok_flutter/pokemon-slider/repository/pokemon_slider_repository.dart';
import '../../general/controllers/general_controller.dart';
import '../ui/screens/pokemon_slider.dart';

class PokemonSliderController extends GetxController {
  GeneralController generalController = Get.put(GeneralController());
  PokemonSliderRepository pokemonSliderRepository =
      Get.put(PokemonSliderRepository());
  CarouselController carouselController = CarouselController();

  final pokemonList = [].obs;
  final isLoadingPokemon = false.obs;
  final lastLoadedPokemon = 0.obs;
  final carouselIndex = 1.obs;
  final isGestureDetectorVisible = false.obs;

  @override
  void onReady() {
    super.onReady();
    _init();
  }

  _init() async {
    FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
    await loadNextFivePokemon();
    if (pokemonList.isNotEmpty) {
      generalController.setIsSplashContentVisible(false);
      await Future.delayed(const Duration(milliseconds: 500));
      FullScreen.exitFullScreen();
      Get.to(
        () => PokemonSlider(),
        duration: const Duration(milliseconds: 1500),
        transition: Transition.circularReveal,
        curve: Curves.easeInExpo,
      );
    } else {
      FullScreen.exitFullScreen();
    }
  }

  void setLastLoadedPokemon(newValue) => lastLoadedPokemon.value = newValue;

  void setIsLoadingPokemon(newValue) => isLoadingPokemon.value = newValue;

  void setCarouselIndex(newValue) => carouselIndex.value = newValue;

  void setIsGestureDetectorVisible(newValue) =>
      isGestureDetectorVisible.value = newValue;

  Future<void> loadPokemon() async {
    Pokemon pokemon;
    var response =
        await pokemonSliderRepository.loadPokemon(lastLoadedPokemon.value);
    if (response.isRight) {
      pokemon = response.right;
      pokemonList.add(pokemon);
      lastLoadedPokemon.value++;
    }
  }

  Future<void> loadNextFivePokemon() async {
    for (var i = 0; i < 5; i++) {
      await loadPokemon();
    }
  }
}
