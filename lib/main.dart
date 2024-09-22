import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'models/database.dart';
import 'common/enum.dart';
import 'modules/home/home_screen.dart';
import 'modules/grammar/grammar_screen.dart';
import 'modules/game/game_screen.dart';
import 'modules/setting/setting_screen.dart';

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
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;
  int _currentIndex = 0;

  void _onChangedTheme() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      print("AAAAAAAAAAAAAAAAAA: ${_controller.text}");
    });
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
            if(_currentIndex == 0 || _currentIndex == 1) AnimSearchBar(
              textController: _controller,
              width: MediaQuery.of(context).size.width - 48,
              color: Colors.transparent,
              boxShadow: false,
              searchIconColor: Colors.white,
              onSuffixTap: () {_controller.text = ''; print('AAAA');},
              onSubmitted: (String) {print('BBBB');},
            ),
            if(_currentIndex == 0 || _currentIndex == 1) IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () async {
                  // await showDialog(context: context, builder: (BuildContext context) {
                  //   WordAction _wordAction = WordAction();
                  //   _wordAction.isModify = false;
                  //   return const ManageDialog();
                  // });
                  // setState(() {_currentIndex = 1;});
                }
            ),
          ]
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(isSearching: _isSearching, query: _controller.text),
            GrammarScreen(),
            const GameScreen(),
            SettingScreen(onChangedTheme: _onChangedTheme),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
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