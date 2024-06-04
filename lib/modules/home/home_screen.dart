import 'package:flutter/material.dart';
import 'add_dialog.dart';
import 'search_page.dart';
import 'list_page.dart';
import 'search_result.dart';
import '../../models/word_modify_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () async {
                    await showDialog(context: context, builder: (BuildContext context) {
                      WordModifyModel wordModify = WordModifyModel();
                      wordModify.reset();
                      return const AddDialog();
                    });
                  }
              ),
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
                icon: const Icon(Icons.list, color: Colors.white),
                onPressed: () {
                  setState(() { _currentIndex = 1; });
                },
              )
            ]
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            SearchResult(),
            ListPage(onClick: _showSearchResult)
          ]
        )
    );
  }
}