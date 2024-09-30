class GrammarItem {
  String form = '';
  String structure = '';
}

class GrammarModel {
  List<GrammarItem> data = [];
  List<GrammarItem> resultSearch = [];
  List<int> listIndex = [];
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
      //resultSearch.add(grammarItem);
    }
    search();
  }

  void search() {
    resultSearch.clear();
    listIndex.clear();
    for (int i = 0; i < data.length; i++) {
      if (textTyping.isEmpty || data[i].form.toLowerCase().contains(textTyping.toLowerCase())
          || data[i].structure.toLowerCase().contains(textTyping.toLowerCase())) {
        resultSearch.add(data[i]);
        listIndex.add(i);
      }
    }
  }
}