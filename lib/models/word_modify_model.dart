import 'word_model.dart';

enum ModifyType {
  add,
  modify,
}

class WordModifyModel {
  late ModifyType type;
  late List<String> keys;
  late List<String> means;
  late String note;
  late int index;

  WordModifyModel._internal() {
    reset();
  }

  factory WordModifyModel() {
    return _instance;
  }

  static final WordModifyModel _instance = WordModifyModel._internal();

  void reset() {
    type = ModifyType.add;
    keys = [];
    means = [];
    note = '';
    index = 0;
  }

  void modify(String mKeys, String mMeans, mNote, mIndex) {
    reset();
    type = ModifyType.modify;
    keys.add(mKeys);
    means.add(mMeans);
    note = mNote;
    index = mIndex;
  }
}