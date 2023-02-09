class Pokemon {
  String number;
  String name;
  List<String> types;
  String hp;
  String attack;
  String defense;
  String mainSpriteUrl;
  String secondarySpriteUrl;
  List<String> moves;

  Pokemon(
      {required this.number,
      required this.name,
      required this.types,
      required this.hp,
      required this.attack,
      required this.defense,
      required this.mainSpriteUrl,
      required this.secondarySpriteUrl,
      required this.moves});
}
