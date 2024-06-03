import 'package:flutter/material.dart';
import 'add_dialog.dart';
import 'search_page.dart';
import 'list_page.dart';
import 'search_result.dart';
import '../../models/word_search_model.dart';
import '../../component/NotifyDialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final WordSearchModel _wordSearch = WordSearchModel();

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
                    int ret = await showDialog(context: context, builder: (BuildContext context) {
                      return const AddDialog();
                    });
                    if(ret != 0 && mounted) {
                      await showDialog(
                           context: context, builder: (BuildContext context) {
                        return NotifyDialog(message: (ret == 1 ?
                          'Key or Mean is empty!' : 'Add word successfully!'));
                      });
                    }
                    _showSearchResult();
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
            SearchResult(wordSearch: _wordSearch),
            ListPage(onClick: _showSearchResult)
          ]
        )
    );
  }
}