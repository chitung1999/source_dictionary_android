import 'package:flutter/material.dart';
import 'add_dialog.dart';
import 'search_page.dart';
import 'list_page.dart';
import 'search_result.dart';
import '../../models/word_search_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final WordSearchModel _wordSearch = WordSearchModel();

  void _searchFromList() {
    setState(() {
      _currentIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: const Text('Dictionary', style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
            actions: [
              IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    showDialog(context: context, builder: (BuildContext context) {
                      return const AddDialog();
                    });
                  }
              ),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () async {
                  bool? ret = await showSearch<bool?> (
                    context: context,
                    delegate: SearchPage()
                  );
                  if(ret != null && ret) {
                    setState(() {_currentIndex = 1;});
                  }

                }
              ),
              IconButton(
                icon: const Icon(Icons.list, color: Colors.white),
                onPressed: () {
                  setState(() { _currentIndex = 0; });
                },
              )
            ]
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            ListPage(onClick: _searchFromList),
            SearchResult(wordSearch: _wordSearch)
          ]
        )
    );
  }
}