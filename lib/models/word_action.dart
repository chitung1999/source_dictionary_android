import 'word_model.dart';

class WordAction {
  String query = '';
  Map<int, WordItem> resultSearch = {};
  bool isEng = true;
  bool isModify = true;
  int indexModify = 0;

  factory WordAction() {
    return _instance;
  }
  static final WordAction _instance = WordAction._internal();
  WordAction._internal();
}