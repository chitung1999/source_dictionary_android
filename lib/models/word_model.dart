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

  void addWord(List<String> keys, List<String> means, String note) {
    // if (eng.containsKey(keys[0])) {
    //   eng[keys[0]]!.add(1);
    // } else {
    //   eng[keys[0]] = [1];
    // }

    //loadData();
  }


  Future<void> writeJson() async {
    // Lấy thư mục tài liệu của ứng dụng
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/my_data.json';

    // Dữ liệu JSON để ghi
    final Map<String, dynamic> jsonData = {
      'name': 'John Doe',
      'age': 30,
      'email': 'john.doe@example.com'
    };

    // Chuyển đổi Map thành chuỗi JSON
    final jsonString = jsonEncode(jsonData);

    // Tạo tệp và ghi chuỗi JSON vào tệp
    final file = File(filePath);
    await file.writeAsString(jsonString);

    print('JSON data has been written to $filePath');
  }

  Future<void> loadData() async {
    reset();
    final String response = await rootBundle.loadString('data/data.json');
    final jsonResponse = await json.decode(response);
    for(Map<String, dynamic> item in jsonResponse['words']) {
      WordItem wordItem = WordItem();
      String keys = '';
      for(String str in item['words']) {
        if (eng.containsKey(str)) {
          eng[str]!.add(item['index']);
        } else {
          eng[str] = [item['index']];
        }
        keys += ((keys.isEmpty ? '' : ', ') + str);
      }

      String means = '';
      for(String str in item['means']) {
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
}