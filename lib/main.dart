import 'package:flutter/material.dart';
import 'package:source_dictionary_mobile/models/config_app.dart';
import 'modules/taskbar.dart';
import 'models/database.dart';
import '../../models/enum_app.dart';

void main() {
  runApp(const DictionaryApp());
}

class DictionaryApp extends StatefulWidget {
  const DictionaryApp({Key? key}) : super(key: key);

  @override
  _DictionaryAppState createState() => _DictionaryAppState();
}

class _DictionaryAppState extends State<DictionaryApp> {
  ConfigApp config = ConfigApp();

  void _onChangedTheme() {
    setState(() {});
  }

  Future<bool>? _loadData() async {
    final Database data = Database();
    await data.initialize();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _loadData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return MaterialApp(
          home: Taskbar(onChangedTheme: _onChangedTheme,),
          theme: ThemeData(brightness: Brightness.light, fontFamily: 'Roboto'),
          darkTheme: ThemeData( brightness: Brightness.dark, fontFamily: 'Roboto'),
          themeMode: config.theme == ThemeApp.light ? ThemeMode.light : ThemeMode.dark,
          debugShowCheckedModeBanner: false,
        );
      }
    );
  }
}