import 'package:easy_rpg/src/data/character_properties.dart';
import 'package:flutter/material.dart';


class Identifier {
  final int id;
  const Identifier(this.id);
}

enum PlayerOnlineState { online, offline }

class Player {
  Player({
    required this.id,
    this.character,
    this.onlineState = PlayerOnlineState.offline,
  });

  final Identifier id;
  PlayerOnlineState onlineState;

  Character? character;
}

class PlayerNotifier extends ChangeNotifier {
  Player? _player;
  Player? get player => _player;

  bool get isLoggedIn => player != null;

  void setPlayer(Identifier id) {
    _player = Player(id: id);
    notifyListeners();
  }

  void logout() {
    _player = null;
    notifyListeners();
  }
}


class Character {
  Character({
    required this.id,
    required this.name,
    required this.properties,
  });

  final Identifier id;
  final String name;
  final CharacterProperties properties;
  MapPosition? mapPosition;
}


class MapPosition {}