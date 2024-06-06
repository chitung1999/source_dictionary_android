import 'package:flutter/material.dart';
import 'search_result.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final TextEditingController _queryController = TextEditingController();
  String _query = '';

  void _onSearch(String value) {
    _queryController.clear();
    setState(() {_query = value;});
  }

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
          Container(
            width: 230,
            height: 35,
            child: TextField(
              controller: _queryController,
              onSubmitted: _onSearch,
              decoration: const InputDecoration(
                hintText: 'Search',
                filled: true,
                fillColor: Colors.white70,
                contentPadding: EdgeInsets.only(top: 15, left: 15),
                suffixIcon: Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide.none,
                ),
              )
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: ResultDictionary(query: _query),
    );
  }
}