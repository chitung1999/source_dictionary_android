class MeanIteam {
  String partSpeech = '';
  String synonyms = '';
  String antonyms = '';
  List<String> definitions = [];
}

class DictionaryItem {
  String word = '';
  String phonetic = '';
  String audio = '';
  List<MeanIteam> mean = [];

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
        MeanIteam meanItem = MeanIteam();

        meanItem.partSpeech = item['partOfSpeech'].toString()
            .replaceRange(0, 1, item['partOfSpeech'].toString()[0].toUpperCase());

        for(String str in item['synonyms']) {
          meanItem.synonyms +=((meanItem.synonyms.isEmpty ? '' : ', ') + str);
        }

        for(String str in item['antonyms']) {
          meanItem.antonyms +=((meanItem.antonyms.isEmpty ? '' : ', ') + str);
        }

        for(Map<String, dynamic> definition in item['definitions']) {
          meanItem.definitions.add(definition['definition'].toString());
          meanItem.definitions.add(definition['example'].toString());
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