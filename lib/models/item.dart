enum ItemType { item, weapon, armor }

class Item {
  final String name;
  final double weight;
  final double cost;
  final ItemType type;

  const Item({
    required this.name,
    required this.weight,
    required this.cost,
    required this.type,
  });
}

final class Armor extends Item {
  final int defense;

  const Armor({
    required super.name,
    required super.weight,
    required super.cost,
    required this.defense,
  }) : super(type: ItemType.armor);
}

final class Weapon extends Item {
  final int minDamage;
  final int maxDamage;

  const Weapon({
    required super.name,
    required super.weight,
    required super.cost,
    required this.minDamage,
    required this.maxDamage,
  }) : super(type: ItemType.weapon);
}
