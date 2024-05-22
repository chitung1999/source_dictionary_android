class DefinitionItem {
  String definition = '';
  String example = '';
}

class MeanItem {
  String partSpeech = '';
  String synonyms = '';
  String antonyms = '';
  List<DefinitionItem> definitions = [];
}

class DictionaryItem {
  String word = '';
  String phonetic = '';
  String audio = '';
  List<MeanItem> mean = [];

  DictionaryItem(this.word, this.phonetic, this.audio, this.mean);

  DictionaryItem.fromJson(Map<String, dynamic> json) {
    _resetData();
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
        MeanItem meanItem = MeanItem();

        meanItem.partSpeech = item['partOfSpeech'].toString()
            .replaceRange(0, 1, item['partOfSpeech'].toString()[0].toUpperCase());

        for(String value in item['synonyms']) {
          meanItem.synonyms +=((meanItem.synonyms.isEmpty ? '' : ', ') + value);
        }

        for(String value in item['antonyms']) {
          meanItem.antonyms +=((meanItem.antonyms.isEmpty ? '' : ', ') + value);
        }

        for(Map<String, dynamic> value in item['definitions']) {
          DefinitionItem definition = DefinitionItem();
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

  void _resetData() {
    word = '';
    phonetic = '';
    audio = '';
    mean = [];
  }
}