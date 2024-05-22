import 'package:flutter/material.dart';
import 'add_dialog.dart';
import 'search_bar.dart';
import 'search_result.dart';
import '../../model/word_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WordModel wordModel = WordModel();

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
                onPressed: () {
                  showSearch(context: context, delegate: SearchBarCustom(data: wordModel));
                },
              )
            ]
        ),
        body: FutureBuilder<void>(
            future: loadData(),
            builder: (context, snapshot) {return SearchResult(data: wordModel.key);}
        )
    );
  }
}