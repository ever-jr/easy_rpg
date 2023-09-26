enum Language { enUS, ptBR }

extension Translator on String {
  String translateTo(Language language) {
    return _data[this]?[language] ?? this;
  }
}

const Map<String, Map<Language, String>> _data = {
  'Name': {
    Language.ptBR: 'Nome',
  },
};
