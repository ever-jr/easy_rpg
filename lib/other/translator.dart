enum Language { enUS, ptBR }

extension Translator on String {
  String translateTo(Language language) {
    return _data[toLowerCase()]?[language] ?? this;
  }
}

const Map<String, Map<Language, String>> _data = {
  'name': {
    Language.ptBR: 'Nome',
  },
  'cancel': {
    Language.ptBR: 'Cancelar',
  },
  'create': {
    Language.ptBR: 'Criar',
  },
  'create campaign': {
    Language.ptBR: 'Criar campanha',
  },
  'campaign\'s name': {
    Language.ptBR: 'Nome da campanha',
  }
};
