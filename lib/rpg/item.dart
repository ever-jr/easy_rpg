class Item {
  final String name;
  final String? description;

  const Item({
    required this.name,
    this.description,
  });
}

enum DamageType { perfuration }

class Weapon extends Item {
  final int damage;
  final DamageType damageType;

  const Weapon({
    required super.name,
    super.description,
    required this.damage,
    required this.damageType,
  });
}
