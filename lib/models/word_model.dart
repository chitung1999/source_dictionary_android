import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class WordItem {
  String keys = '';
  String means = '';
  String note = '';
}

class WordModel {

  WordModel._internal();

  factory WordModel() {
    return _instance;
  }

  static final WordModel _instance = WordModel._internal();

  SplayTreeMap<String, List<int>> eng = SplayTreeMap<String, List<int>>();
  SplayTreeMap<String, List<int>> vn = SplayTreeMap<String, List<int>>();
  List<WordItem> data = [];

  void reset() {
    eng.clear();
    vn.clear();
    data.clear();
  }

  Future<void> addWord(List<String> keys, List<String> means, String note) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data.json');
      final stringData = await file.readAsString();
      final Map<String, dynamic> jsonData = jsonDecode(stringData);

      final Map<String, dynamic> newData = {
        "index": jsonData["words"].length,
        "words": keys,
        "means": means,
        "notes": note
      };

      jsonData["words"].add(newData);
      final stringInput = jsonEncode(jsonData);
      await file.writeAsString(stringInput);
      loadData();
    } catch(e) {}
  }

  Future<void> uploadDataToServer() async {
    //implement yet
  }

  Future<void> getDataFromServer() async {
    try {
      final String dataSever = await rootBundle.loadString('data/data.json');

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data.json');
      await file.writeAsString(dataSever);

      loadData();
    } catch (e) {}
  }

  Future<void> loadData() async {
    try {
      reset();
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data.json');
      final stringData = await file.readAsString();
      final Map<String, dynamic> jsonData = jsonDecode(stringData);

      for (Map<String, dynamic> item in jsonData['words']) {
        WordItem wordItem = WordItem();
        String keys = '';
        for (String str in item['words']) {
          if (eng.containsKey(str)) {
            eng[str]!.add(item['index']);
          } else {
            eng[str] = [item['index']];
          }
          keys += ((keys.isEmpty ? '' : ', ') + str);
        }

        String means = '';
        for (String str in item['means']) {
          if (vn.containsKey(str)) {
            vn[str]!.add(item['index']);
          } else {
            vn[str] = [item['index']];
          }
          means += ((means.isEmpty ? '' : ', ') + str);
        }

        wordItem.keys = keys;
        wordItem.means = means;
        wordItem.note = item['notes'].toString();
        data.add(wordItem);
      }
    }
    catch(e) {}
  }
}