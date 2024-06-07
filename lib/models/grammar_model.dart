class GrammarItem {
  String form = '';
  String structure = '';
}

class GrammarModel {
  GrammarModel._internal();
  factory GrammarModel() {
    return _instance;
  }
  static final GrammarModel _instance = GrammarModel._internal();

  List<GrammarItem> data = [];

  void resetData() {
    data.clear();
  }

  void loadData(var jsonData) {
    resetData();
    for (Map<String, dynamic> item in jsonData) {
      GrammarItem grammarItem = GrammarItem();
      grammarItem.form = item["form"];
      grammarItem.structure = item["structure"];
      data.add(grammarItem);
    }
  }
}