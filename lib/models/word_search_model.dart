import 'word_model.dart';

class WordSearchModel {
  late String query;
  late List<WordItem> data;

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
}