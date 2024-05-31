import 'package:flutter/material.dart';
import '../../../models/word_search_model.dart';
import '../../../models/word_model.dart';

class SearchResult extends StatefulWidget {

  const SearchResult({Key? key}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final WordSearchModel _wordSearch = WordSearchModel();
  final WordModel _word = WordModel();

  @override
  Widget build(BuildContext context) {
    if(_wordSearch.query.isEmpty) {
      return const Center(child: Text('No results found!', style: TextStyle(fontSize: 20, color: Colors.blueGrey)));
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: _wordSearch.data.length,
        itemBuilder: (context, index) {return Column( children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(width: 2, color: Colors.blueGrey)
            ),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        _wordSearch.query,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                    ),
                    const Row( children: [
                      IconButton(onPressed: null, icon: Icon(Icons.playlist_add)),
                      IconButton(onPressed: null, icon: Icon(Icons.playlist_add)),
                    ])
                  ]
                ),
                Text(
                  '• words: ${_wordSearch.data[index].keys}',
                  style: const TextStyle(fontSize: 20)
                ),
                Text(
                  '• means: ${_wordSearch.data[index].means}',
                  style: const TextStyle(fontSize: 20)
                ),
                Text(
                  '• note: ${_wordSearch.data[index].note}',
                  style: const TextStyle(fontSize: 20)
                ),
              ],
            ),
          ),
          const SizedBox(height: 20)
        ],);}
      )
    );
  }
}