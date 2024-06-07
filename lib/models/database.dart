import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'config_app.dart';
import 'word_model.dart';
import 'grammar_model.dart';

class Database {
  final ConfigApp _configApp = ConfigApp();
  final WordModel _wordModel = WordModel();
  final GrammarModel _grammarModel = GrammarModel();

  Future<Map<String, dynamic>> readFileLocal() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/dictionary_database.json');
      final data = await file.readAsString();
      return jsonDecode(data);
    } catch(e) {
      print('Fail to read file local: $e');
      return {};
    }
  }

  Future<bool> writeFileLocal(Map<String, dynamic> data) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/dictionary_database.json');
      final str = jsonEncode(data);
      await file.writeAsString(str);
      return true;
    } catch(e) {
      print('Fail to write file local: $e');
      return false;
    }
  }

  Future<bool> initialize() async {
    try {
      Map<String, dynamic> data = await readFileLocal();
      if(data.isEmpty) {
        data = await getDefaultData();
        await writeFileLocal(data);
      }

      _wordModel.loadData(data["words"]);
      _configApp.loadData(data["config"]);
      _grammarModel.loadData(data["grammar"]);
      return true;
    } catch(e) {
      print('Fail to initialize data: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> getDefaultData() async {
    try {
      final String strDefault = await rootBundle.loadString('data/default_data.json');
      Map<String, dynamic> data = jsonDecode(strDefault);
      return data;
    } catch (e) {
      print('Fail to get default data: $e');
      return {};
    }
  }

  //Setting
  Future<bool> setAccount(String u, String p) async {
    try {
      if(_configApp.username != u || _configApp.password != p) {
        Map<String, dynamic> data = await readFileLocal();
        data['config']['username'] = u;
        data['config']['password'] = p;
        bool ret = await writeFileLocal(data);
        if(!ret) {
          return false;
        }
        _configApp.loadData(data["config"]);
      }
      return true;
    } catch(e) {
      print('Fail to set account: $e');
      return false;
    }
  }

  Future<bool> setTheme(bool value) async {
    try {
      Map<String, dynamic> data = await readFileLocal();
      data['config']['theme'] = value ? 1 : 0;
      writeFileLocal(data);
      bool ret = await writeFileLocal(data);
      if(!ret) {
        return false;
      }
      _configApp.loadData(data["config"]);
      return true;
    } catch(e) {
      print('Fail to set theme: $e');
      return false;
    }
  }

  //Home
  Future<bool> addGroup(List<String> keys, List<String> means, String note) async {
    try {
      Map<String, dynamic> data = await readFileLocal();

      final Map<String, dynamic> newGroup = {
        "keys": keys,
        "means": means,
        "notes": note
      };

      data["words"].add(newGroup);
      bool ret = await writeFileLocal(data);
      if(!ret) {
        return false;
      };
      _wordModel.loadData(data["words"]);
      return true;
    } catch(e) {
      print('Fail to add new group: $e');
      return false;
    }
  }

  Future<bool> modifyGroup(List<String> keys, List<String> means, String note, String query, bool isEng, int index) async {
    try {
      Map<String, dynamic> data = await readFileLocal();

      final Map<String, dynamic> newGroup = {
        "keys": keys,
        "means": means,
        "notes": note
      };
      List<int>? group = isEng ? _wordModel.eng[query] : _wordModel.vn[query];

      data["words"][group?[index]] = newGroup;
      bool ret = await writeFileLocal(data);
      if(!ret) {
        return false;
      };
      _wordModel.loadData(data["words"]);
      return true;
    } catch(e) {
      print('Fail to modify group: $e');
      return false;
    }
  }

  Future<bool> removeGroup(String query, bool isEng, int index) async {
    try {
      Map<String, dynamic> data = await readFileLocal();

      List<int>? group = isEng ? _wordModel.eng[query] : _wordModel.vn[query];

      data["words"].removeAt(group?[index]);
      bool ret = await writeFileLocal(data);
      if(!ret) {
        return false;
      };
      _wordModel.loadData(data["words"]);
      return true;
    } catch(e) {
      print('Fail to remove group: $e');
      return false;
    }
  }

  //Grammar
  Future<bool> addGrammar(String form, String structure) async {
    try {
      Map<String, dynamic> data = await readFileLocal();

      final Map<String, dynamic> newGrammar = {
        "form": form,
        "structure": structure
      };

      data["grammar"].add(newGrammar);
      bool ret = await writeFileLocal(data);
      if(!ret) {
        return false;
      };
      _grammarModel.loadData(data["grammar"]);
      return true;
    } catch(e) {
      print('Fail to add new grammar: $e');
      return false;
    }
  }

  Future<bool> modifyGrammar(String form, String structure, int index) async {
    try {
      Map<String, dynamic> data = await readFileLocal();

      final Map<String, dynamic> newGrammar = {
        "form": form,
        "structure": structure
      };

      data["grammar"][index] = newGrammar;
      bool ret = await writeFileLocal(data);
      if(!ret) {
        return false;
      };
      _grammarModel.loadData(data["grammar"]);
      return true;
    } catch(e) {
      print('Fail to modify grammar: $e');
      return false;
    }
  }

  Future<bool> removeGrammar(int index) async {
    try {
      Map<String, dynamic> data = await readFileLocal();

      data["grammar"].removeAt(index);
      bool ret = await writeFileLocal(data);
      if(!ret) {
        return false;
      };
      _grammarModel.loadData(data["grammar"]);
      return true;
    } catch(e) {
      print('Fail to remove grammar: $e');
      return false;
    }
  }

  Future<bool> uploadDataToServer() async {
    //implement yet
    try {
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<bool> getDataFromServer() async {
    try {
      final String dataSever = await rootBundle.loadString('data/data.json');
      Map<String, dynamic> data = jsonDecode(dataSever);
      bool ret = await writeFileLocal(data);
      if(!ret) {
        return false;
      };
      _wordModel.loadData(data["words"]);
      return true;
    } catch (e) {
      print('Fail to get data from sever: $e');
      return false;
    }
  }
}