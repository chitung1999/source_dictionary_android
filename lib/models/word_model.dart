import 'dart:collection';

class WordItem {
  List<String> keys = [];
  List<String> means = [];
  String note = '';


  String keysToString() {
    String key = '';
    for (String str in keys) {
      key += ((keys.isEmpty ? '' : ', ') + str);
    }
    return key;
  }

  String meansToString() {
    String mean = '';
    for (String str in means) {
      mean += ((means.isEmpty ? '' : ', ') + str);
    }
    return mean;
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
}