import 'package:flutter/material.dart';
import 'models/database.dart';
import 'modules/home/home_screen.dart';
import 'modules/grammar/grammar_screen.dart';
import 'modules/game/game_screen.dart';
import 'modules/setting/setting_screen.dart';
import 'common/enum.dart';
import 'common/search_bar.dart';
import 'common/change_data.dart';

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
  bool _isSearching = false;
  int _currentIndex = 0;

  void _onChangedTheme() {setState(() {});}

  void _onSelect() {setState(() {_isSearching = false;});}

  void _onSearch() {
    if(_currentIndex == 0) {
      database.wordModel.query.textTyping = '';
      database.wordModel.search();
    } else {
      database.grammarModel.textTyping = '';
      database.grammarModel.search();
    }
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  void _onTyping(String str) {
    if(_currentIndex == 0) {
      database.wordModel.query.textTyping = str;
      database.wordModel.search();
    } else {
      database.grammarModel.textTyping = str;
      database.grammarModel.search();
    }
    setState(() {});
  }

  void _onChangedLanguage() {
    database.wordModel.search();
    setState(() {});
  }

  void _onAdd() {
    if(_currentIndex == 0) {
      database.wordModel.search();
    } else {
      database.grammarModel.search();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light, fontFamily: 'Roboto'),
      darkTheme: ThemeData( brightness: Brightness.dark, fontFamily: 'Roboto'),
      themeMode: database.configApp.theme == ThemeApp.LIGHT ? ThemeMode.light : ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dictionary', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff355C7D), Color(0xff6C5B7B), Color(0xffC06C84)],
                stops: [0, 0.5, 1],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          actions: [
            if(_currentIndex == 0 || _currentIndex == 1) SearchBarApp(isSearching: _isSearching, onClick: _onSearch, onTyping: _onTyping),
            SizedBox(width: 10),
            if(_currentIndex == 0 || _currentIndex == 1) Builder(
              builder: (context) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      await showDialog(context: context, builder: (BuildContext context) {
                         return ChangeData(isHome: _currentIndex == 0, isAddNew: true, onSuccess: _onAdd);
                      });
                    }
                  ),
                );
              }
            ),
            SizedBox(width: 20)
          ]
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(isSearching: _isSearching, onSelect: _onSelect, onChangedLanguage: _onChangedLanguage),
            GrammarScreen(),
            const GameScreen(),
            SettingScreen(onChangedTheme: _onChangedTheme),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            if(_currentIndex != index) {
              setState(() {
                _currentIndex = index;
                _isSearching = false;
              });
            }
          },
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