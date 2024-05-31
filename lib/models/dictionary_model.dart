class Definition {
  String definition = '';
  String example = '';
}

class Mean {
  String partSpeech = '';
  String synonyms = '';
  String antonyms = '';
  List<Definition> definitions = [];
}

class DictionaryModel {
  late String word;
  late String phonetic;
  late String audio;
  late List<Mean> mean;

  DictionaryModel._internal() {
    resetData();
  }

  factory DictionaryModel() {
    return _instance;
  }

  static final DictionaryModel _instance = DictionaryModel._internal();

  void loadData(Map<String, dynamic> json) {
    resetData();
    if (json.isEmpty) { return; }

    if (json.containsKey('word') && json['word'].isNotEmpty) {
      word = json['word'];
    }

    if (json.containsKey('phonetics') && json['phonetics'].isNotEmpty) {
      for(Map<String, dynamic> item in json['phonetics']) {
        if(item.containsKey('text') && item.containsKey('audio') &&
            item['text'].toString().isNotEmpty && item['audio'].toString().isNotEmpty) {
          phonetic = item['text'].toString();
          audio = item['audio'].toString();
          break;
        }
      }
    }


    if (json.containsKey('meanings') && json['meanings'].isNotEmpty) {
      for(Map<String, dynamic> item in json['meanings']) {
        Mean meanItem = Mean();

        meanItem.partSpeech = item['partOfSpeech'].toString()
            .replaceRange(0, 1, item['partOfSpeech'].toString()[0].toUpperCase());

        for(String value in item['synonyms']) {
          meanItem.synonyms +=((meanItem.synonyms.isEmpty ? '' : ', ') + value);
        }

        for(String value in item['antonyms']) {
          meanItem.antonyms +=((meanItem.antonyms.isEmpty ? '' : ', ') + value);
        }

        for(Map<String, dynamic> value in item['definitions']) {
          Definition definition = Definition();
          if(value.containsKey('definition') && value['definition'].isNotEmpty) {
            definition.definition = value['definition'].toString();
          }
          if(value.containsKey('example') && value['example'].isNotEmpty) {
            definition.example = value['example'].toString();
          }
          meanItem.definitions.add(definition);
        }

        mean.add(meanItem);
      }
    }
  }

  void resetData() {
    word = '';
    phonetic = '';
    audio = '';
    mean = [];
  }
}