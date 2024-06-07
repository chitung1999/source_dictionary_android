import 'word_model.dart';

class WordSearchModel {
  late String query;
  late List<WordItem> data;
  late bool isEng = true;

  WordSearchModel._internal() {
    reset();
  }

  factory WordSearchModel() {
    return _instance;
  }

  static final WordSearchModel _instance = WordSearchModel._internal();

  void reset() {
    query = '';
    data = [];
  }

  void modify(List<String> keys, List<String> means, notes, index) {
    print(keys);

    data[index].keys = '';
    for(String str in keys) {
      data[index].keys += ((data[index].keys.isEmpty ? '' : ', ') + str);
    }
    data[index].means = '';
    for(String str in means) {
      data[index].means += ((data[index].means.isEmpty ? '' : ', ') + str);
    }
    data[index].note = notes;
  }
}