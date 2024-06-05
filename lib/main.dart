import 'package:flutter/material.dart';
import 'modules/taskbar.dart';
import 'models/database.dart';

void main() {
  runApp(const DictionaryApp());
}

class DictionaryApp extends StatefulWidget {
  const DictionaryApp({Key? key}) : super(key: key);

  @override
  _DictionaryAppState createState() => _DictionaryAppState();
}

class _DictionaryAppState extends State<DictionaryApp> {

  bool isThemeLight = true;

  void _onChangedTheme(bool value) async {
    setState(() {isThemeLight = value;});
  }

  void _loadData() async {
    final Database data = Database();
    await data.initialize();
    //await config.getData();
   // setState(() {isThemeLight = (config.theme == ThemeApp.light ? true : false);});
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