import 'package:flutter/material.dart';
import 'add_dialog.dart';
import 'search_page.dart';
import 'search_result.dart';
import 'list_page.dart';
import '../../../models/word_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WordModel wordModel = WordModel();
  SearchConfig _config = SearchConfig();
  bool _isShowList = true;

  Future<void> loadData() async {
    await wordModel.loadData();
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
                  SearchConfig? config = await showSearch<SearchConfig?>(
                    context: context,
                    delegate: SearchPage(data: wordModel)
                  );
                  if(config != null && config.isSearch) {
                    setState(() {
                      _isShowList = false;
                      _config = config;
                    });
                  }
                }
              ),
              IconButton(
                icon: const Icon(Icons.list, color: Colors.white),
                onPressed: () {
                  setState(() { _isShowList = true; });
                },
              )
            ]
        ),
        body: FutureBuilder<void>(
            future: loadData(),
            builder: (context, snapshot) {
              if (_isShowList) {
                return ListPage(data: wordModel.key);
              }
              return SearchResult(data: wordModel, config: _config);
            }
        )
    );
  }
}