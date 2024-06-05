import 'package:flutter/material.dart';
import 'package:source_dictionary_mobile/models/config_app.dart';
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
  //
  Future<bool>? _loadData() async {
    final Database data = Database();
    await data.initialize();
    ConfigApp config = ConfigApp();
    isThemeLight = (config.theme == ThemeApp.light ? true : false);
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<bool>(
      future: _loadData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return MaterialApp(
          home: Taskbar(onChangedTheme: _onChangedTheme,),
          theme: ThemeData(brightness: Brightness.light),
          darkTheme: ThemeData( brightness: Brightness.dark),
          themeMode: isThemeLight ? ThemeMode.light : ThemeMode.dark,
          debugShowCheckedModeBanner: false,
        );
      }
    );
  }
}