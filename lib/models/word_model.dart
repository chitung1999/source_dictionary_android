import 'dart:collection';

class WordItem {
  List<String> keys = [];
  List<String> means = [];
  String note = '';


  String keysToString() {
    String key = '';
    for (String str in keys) {
      key += ((key.isEmpty ? '' : ', ') + str);
    }
    return key;
  }

  String meansToString() {
    String mean = '';
    for (String str in means) {
      mean += ((mean.isEmpty ? '' : ', ') + str);
    }
    return mean;
  }
}

class Query {
  String textTyping = '';
  String textSearch = '';
  bool isEng = true;

  void set(String t, bool i) {
    textSearch = t;
    isEng = i;
  }
}

class WordModel {

  WordModel._internal();

  factory WordModel() {
    return _instance;
  }

  static final WordModel _instance = WordModel._internal();

  SplayTreeMap<String, List<int>> eng = SplayTreeMap<String, List<int>>();
  SplayTreeMap<String, List<int>> vn = SplayTreeMap<String, List<int>>();
  List<WordItem> data = [];
  List<String> resultSearch = [];
  Query query = Query();

  void reset() {
    eng.clear();
    vn.clear();
    data.clear();
  }

  void loadData(var jsonData) {
    reset();
    int index = 0;
    for (Map<String, dynamic> item in jsonData) {
      WordItem wordItem = WordItem();

      for (String str in item['keys']) {
        if (eng.containsKey(str)) {
          eng[str]!.add(index);
        } else {
          eng[str] = [index];
        }
        wordItem.keys.add(str);
      }

      for (String str in item['means']) {
        if (vn.containsKey(str)) {
          vn[str]!.add(index);
        } else {
          vn[str] = [index];
        }
        wordItem.means.add(str);
      }

      wordItem.note = item['notes'];
      data.add(wordItem);
      index++;
    }
  }

  void search() {
    resultSearch.clear();
    for(String item in (query.isEng ? eng.keys : vn.keys)) {
      if(query.textTyping.isEmpty || item.toLowerCase().startsWith(query.textTyping..toLowerCase())) {
        resultSearch.add(item);
      }
    }
  }
}