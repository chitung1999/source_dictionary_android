import 'package:flutter/material.dart';
import 'search_page.dart';
import 'search_result.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Dictionary',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () async {
              await showSearch (context: context, delegate: SearchPage());
              setState(() {});
            },
          )
        ],
      ),
      body: ResultDictionary(),
    );
  }
}