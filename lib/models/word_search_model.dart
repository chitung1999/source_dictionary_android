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
    data[index].keys = keys;
    data[index].means = means;
    data[index].note = notes;
  }
}