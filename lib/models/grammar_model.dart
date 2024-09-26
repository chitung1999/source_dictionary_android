class GrammarItem {
  String form = '';
  String structure = '';
}

class GrammarModel {
  List<GrammarItem> data = [];
  List<GrammarItem> resultSearch = [];
  String textTyping = '';

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
      resultSearch.add(grammarItem);
    }
  }

  void search() {
    resultSearch.clear();
    for (GrammarItem item in data) {
      if (textTyping.isEmpty || item.form.toLowerCase().contains(textTyping.toLowerCase())
          || item.structure.toLowerCase().contains(textTyping.toLowerCase())) {
        resultSearch.add(item);
      }
    }
  }
}