class StringParsing {
  StringParsing._();

  static List<String> parseTextIntoMapObjects(String map) {
    final List<String> elements = [];

    for (int i = 0; i < map.length; i++) {
      final String emoji;

      switch (map[i]) {
        case 't':
          emoji = "🌳";
          break;

        case 'x':
          emoji = "🤨";
          break;

        case '\n':
          continue;

        default:
          emoji = " ";
      }

      elements.add(emoji);
    }

    return elements;
  }
}