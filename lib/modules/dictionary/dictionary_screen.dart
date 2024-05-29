import 'package:flutter/material.dart';
import 'search_page.dart';
import 'dictionary_item.dart';
import 'search_result.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  DictionaryItem? _item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Dictionary',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () async {
              final DictionaryItem? item = await showSearch<DictionaryItem?>(
                  context: context,
                  delegate: SearchPage()
              );
              setState(() { _item = item!; });
            },
          )
        ],
      ),
      body: ResultDictionary(item: _item),
    );
  }
}