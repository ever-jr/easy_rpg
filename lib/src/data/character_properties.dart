class CharacterProperties {
  final List<CharacterProperty> _properties;

  CharacterProperties(this._properties);

  int get length => _properties.length;

  CharacterProperty at(int index) {
    return _properties.elementAt(index);
  }
}

class CharacterProperty {
  final String name;
  dynamic value;

  CharacterProperty({required this.name, this.value});

  void setValue(dynamic newValue) {
    if (value != newValue) {
      value = newValue;
    }
  }
}