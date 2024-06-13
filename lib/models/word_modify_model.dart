enum ModifyType {
  add,
  modify,
}

class WordModifyModel {
  late ModifyType type;
  late List<String> keys;
  late List<String> means;
  late String note;
  late String query;
  late bool isEng;
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
    query = '';
    isEng = true;
    index = 0;
  }

  void modify(List<String> mKeys, List<String> mMeans, String mNote, String mQuery, bool mIsEng, int mIndex) {
    reset();
    type = ModifyType.modify;
    keys = mKeys;
    means = mMeans;
    note = mNote;
    query = mQuery;
    isEng = mIsEng;
    index = mIndex;
  }
}