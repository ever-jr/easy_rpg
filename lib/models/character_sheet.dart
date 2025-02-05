enum InputType { boolean, text, number }


class CharacterSheet {
  final List<InputData> _inputs = [];

  CharacterSheet();

  void addInput(InputData data) {
    _inputs.add(data);
  }
}


class InputData {
  final InputType type;

  String _text = "";

  InputData({
    required this.type,
  });

  String get text => _text;

  set text(String value) {
    if (_text != value) {
      _text = value;
    }
  }
}