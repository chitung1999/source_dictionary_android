import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'config_app.dart';
import 'word_model.dart';

class Database {
  final ConfigApp _configApp = ConfigApp();
  final WordModel _wordModel = WordModel();

  Future<Map<String, dynamic>> readFileLocal() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/dictionary_database.json');
    final data = await file.readAsString();
    return jsonDecode(data);
  }

  Future<void> writeFileLocal(Map<String, dynamic> data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/dictionary_database.json');
    final str = jsonEncode(data);
    await file.writeAsString(str);
  }

  Future<void> initialize() async {
    try {
      Map<String, dynamic> data = await readFileLocal();

      _configApp.loadData(data["config"]);
      _wordModel.loadData(data["words"]);
    } catch(e) {}
  }

  //Setting
  Future<void> setAccount(String u, String p) async {
    try {
      if(_configApp.username != u || _configApp.password != p) {
        Map<String, dynamic> data = await readFileLocal();
        data['config']['username'] = u;
        data['config']['password'] = p;
        _configApp.loadData(data["config"]);
        writeFileLocal(data);
      }
    } catch(e) {}
  }

  Future<void> setTheme(bool value) async {
    try {
      Map<String, dynamic> data = await readFileLocal();
      data['config']['theme'] = value ? 1 : 0;
      _configApp.loadData(data["config"]);
      writeFileLocal(data);
    } catch(e) {}
  }

  //Home
  Future<void> addGroup(List<String> keys, List<String> means, String note) async {
    try {
      Map<String, dynamic> data = await readFileLocal();

      final Map<String, dynamic> newGroup = {
        "words": keys,
        "means": means,
        "notes": note
      };

      data["words"].add(newGroup);
      _wordModel.loadData(data["words"]);
      writeFileLocal(data);
    } catch(e) {}
  }

  Future<void> modifyGroup(List<String> keys, List<String> means, String note, String query, bool isEng, int index) async {
    try {
      Map<String, dynamic> data = await readFileLocal();

      final Map<String, dynamic> newGroup = {
        "words": keys,
        "means": means,
        "notes": note
      };
      List<int>? group = isEng ? _wordModel.eng[query] : _wordModel.vn[query];

      data["words"][group?[index]] = newGroup;
      _wordModel.loadData(data["words"]);
      writeFileLocal(data);
    } catch(e) {}
  }

  Future<void> removeGroup(String query, bool isEng, int index) async {
    try {
      Map<String, dynamic> data = await readFileLocal();

      List<int>? group = isEng ? _wordModel.eng[query] : _wordModel.vn[query];

      data["words"].removeAt(group?[index]);
      _wordModel.loadData(data["words"]);
      writeFileLocal(data);
    } catch(e) {}
  }

  Future<bool> uploadDataToServer() async {
    //implement yet
    return true;
  }

  Future<bool> getDataFromServer() async {
    try {
      final String dataSever = await rootBundle.loadString('data/data.json');
      Map<String, dynamic> data = jsonDecode(dataSever);
      _wordModel.loadData(data["words"]);
      writeFileLocal(data);
      return true;
    } catch (e) {
      return false;
    }
  }
}