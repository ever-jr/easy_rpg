class Item {
  final String name;
  final double weight;
  final double cost;

  const Item({
    required this.name,
    required this.weight,
    required this.cost,
  });
}

final class Armor extends Item {
  final int defense;

  const Armor({
    required super.name,
    required super.weight,
    required super.cost,
    required this.defense,
  });
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
  });
}
