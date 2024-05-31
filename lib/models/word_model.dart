import 'dart:collection';
import 'dart:convert';
import 'package:flutter/services.dart';

class WordItem {
  String keys = '';
  String means = '';
  String note = '';
}

class WordModel {

  WordModel._internal() {
    loadData();
  }

  factory WordModel() {
    return _instance;
  }

  static final WordModel _instance = WordModel._internal();

  SplayTreeMap<String, List<int>> key = SplayTreeMap<String, List<int>>();
  SplayTreeMap<String, List<int>> mean = SplayTreeMap<String, List<int>>();
  List<WordItem> data = [];

  void reset() {
    key.clear();
    mean.clear();
    data.clear();
  }

  Future<void> loadData() async {
    reset();
    final String response = await rootBundle.loadString('data/data.json');
    final jsonResponse = await json.decode(response);
    for(Map<String, dynamic> item in jsonResponse['words']) {
      WordItem wordItem = WordItem();
      String keys = '';
      for(String str in item['words']) {
        if (key.containsKey(str)) {
          key[str]!.add(item['index']);
        } else {
          key[str] = [item['index']];
        }
        keys += ((keys.isEmpty ? '' : ', ') + str);
      }

      String means = '';
      for(String str in item['means']) {
        if (mean.containsKey(str)) {
          mean[str]!.add(item['index']);
        } else {
          mean[str] = [item['index']];
        }
        means += ((means.isEmpty ? '' : ', ') + str);
      }

      wordItem.keys = keys;
      wordItem.means = means;
      wordItem.note = item['notes'].toString();
      data.add(wordItem);
    }
  }
}