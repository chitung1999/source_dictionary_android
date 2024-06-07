import 'package:flutter/material.dart';
import 'manage_dialog.dart';
import '../../../models/word_search_model.dart';
import '../../../models/word_modify_model.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final WordSearchModel wordSearch = WordSearchModel();

  @override
  Widget build(BuildContext context) {
    if(wordSearch.query.isEmpty) {
      return const Center(child: Text('No results found!', style: TextStyle(fontSize: 20, color: Colors.blueGrey)));
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: wordSearch.data.length,
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
                      wordSearch.query,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        await showDialog(context: context, builder: (BuildContext context) {
                          WordModifyModel wordModify = WordModifyModel();
                          wordModify.modify(wordSearch.data[index].keys, wordSearch.data[index].means,
                              wordSearch.data[index].note, wordSearch.query, wordSearch.isEng, index);
                          return const ManageDialog();
                        });
                        setState(() {});
                      }
                    ),
                  ]
                ),
                Text(
                  '• words: ${wordSearch.data[index].keys}',
                  style: const TextStyle(fontSize: 20)
                ),
                Text(
                  '• means: ${wordSearch.data[index].means}',
                  style: const TextStyle(fontSize: 20)
                ),
                Text(
                  '• note: ${wordSearch.data[index].note}',
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