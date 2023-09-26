import 'package:easy_rpg/rpg/item.dart';

enum CampaignType { simple, customizable, veryCustomizable }

class Campaign {
  final String name;
  final String description;
  final List<Race> races;
  final List<Class> classes;
  final List<Item> items;
  final List<Player> players;

  const Campaign({
    required this.name,
    required this.description,
    required this.races,
    required this.classes,
    required this.items,
    required this.players,
  });
}

class Player {}

class Race {
  final String name;

  const Race({required this.name});
}

class Class {
  final String name;

  const Class({required this.name});
}
