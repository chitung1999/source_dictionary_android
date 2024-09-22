import 'package:flutter/material.dart';
import 'package:source_dictionary_mobile/models/word_action.dart';
import 'manage_dialog.dart';
import 'search_page.dart';
import 'list_page.dart';
import 'search_result.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.isSearching, required this.query}) : super(key: key);

  final bool isSearching;
  final String query;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _showSearchResult() {
    setState(() {
      _currentIndex = 0;
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
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () async {
              bool? ret = await showSearch<bool?> (context: context, delegate: SearchPage());

              if(ret != null && ret) {
                _showSearchResult();
              }
            }
          ),
          IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () async {
                await showDialog(context: context, builder: (BuildContext context) {
                  WordAction _wordAction = WordAction();
                  _wordAction.isModify = false;
                  return const ManageDialog();
                });
                setState(() {_currentIndex = 1;});
              }
          ),
          IconButton(
            icon: const Icon(Icons.list, color: Colors.white),
            onPressed: () {
              setState(() { _currentIndex = 1; });
            },
          )
        ]
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [SearchResult(), ListPage(onClick: _showSearchResult)]
      )
    );
  }
}