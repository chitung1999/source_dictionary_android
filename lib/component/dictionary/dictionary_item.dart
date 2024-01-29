class DictionaryItem {
  String word = '';
  String phonetic = '';
  String audio = '';
  List<Map<String, String>> mean = [];

  DictionaryItem(this.word, this.phonetic, this.audio, this.mean);

  DictionaryItem.fromJson(Map<String, dynamic> json) {
    _resetData();
    if (json.isNotEmpty) { return; }

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
        Map<String, dynamic> meaning = {};
        meaning['partOfSpeech'] = item['partOfSpeech'];
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