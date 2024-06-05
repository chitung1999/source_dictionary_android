import 'dart:collection';

class WordItem {
  String keys = '';
  String means = '';
  String note = '';
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
      String keys = '';
      for (String str in item['words']) {
        if (eng.containsKey(str)) {
          eng[str]!.add(index);
        } else {
          eng[str] = [index];
        }
        keys += ((keys.isEmpty ? '' : ', ') + str);
      }

      String means = '';
      for (String str in item['means']) {
        if (vn.containsKey(str)) {
          vn[str]!.add(index);
        } else {
          vn[str] = [index];
        }
        means += ((means.isEmpty ? '' : ', ') + str);
      }

      wordItem.keys = keys;
      wordItem.means = means;
      wordItem.note = item['notes'].toString();
      data.add(wordItem);
      index++;
    }
  }
}