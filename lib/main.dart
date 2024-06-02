import 'package:flutter/material.dart';
import 'modules/taskbar.dart';
import 'models/word_model.dart';

void main() {
  runApp(DictionaryApp());
}

class DictionaryApp extends StatefulWidget {
  const DictionaryApp({Key? key}) : super(key: key);

  @override
  _DictionaryAppState createState() => _DictionaryAppState();
}

class _DictionaryAppState extends State<DictionaryApp> {
  bool isThemeLight = true;

  void _onChangedTheme(bool value) {
    setState(() {isThemeLight = value;});
  }

  void _loadData() {
    final WordModel word = WordModel();
    word.loadData();
  }

  @override
  Widget build(BuildContext context) {
    _loadData();

    return MaterialApp(
      home: Taskbar(onChangedTheme: _onChangedTheme,),
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData( brightness: Brightness.dark),
      themeMode: isThemeLight ? ThemeMode.light : ThemeMode.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}