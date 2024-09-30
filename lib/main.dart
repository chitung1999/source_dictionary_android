import 'package:flutter/material.dart';
import 'models/database.dart';
import 'modules/home/home_screen.dart';
import 'modules/grammar/grammar_screen.dart';
import 'modules/game/game_screen.dart';
import 'modules/setting/setting_screen.dart';
import 'common/enum.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StatusApp ret = await database.initialize();
  if(ret == StatusApp.RUN_APP_SUCCESS) {
    runApp(const DictionaryApp());
  }
}

class DictionaryApp extends StatefulWidget {
  const DictionaryApp({Key? key}) : super(key: key);

  @override
  _DictionaryAppState createState() => _DictionaryAppState();
}

class _DictionaryAppState extends State<DictionaryApp> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light, fontFamily: 'Roboto'),
      darkTheme: ThemeData( brightness: Brightness.dark, fontFamily: 'Roboto'),
      themeMode: database.configApp.theme == ThemeApp.LIGHT ? ThemeMode.light : ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const HomeScreen(),
            const GrammarScreen(),
            const GameScreen(),
            SettingScreen(onChangedTheme: (){setState(() {});}),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {setState(() {_currentIndex = index;});},
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.share), label: 'Grammar'),
            BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: 'Game'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
          ]
        )
      )
    );
  }
}