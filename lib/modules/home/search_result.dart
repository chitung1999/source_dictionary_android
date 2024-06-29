import 'package:flutter/material.dart';
import 'package:source_dictionary_mobile/models/word_action.dart';
import 'manage_dialog.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  WordAction _wordAction = WordAction();

  @override
  Widget build(BuildContext context) {
    if(_wordAction.resultSearch.isEmpty) {
      return const Center(child: Text('No results found!', style: TextStyle(fontSize: 20, color: Colors.blueGrey)));
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: _wordAction.resultSearch.length,
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
                        _wordAction.query,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        await showDialog(context: context, builder: (BuildContext context) {
                          _wordAction.isModify = true;
                          _wordAction.indexModify = _wordAction.resultSearch.entries.elementAt(index).key;;
                          return const ManageDialog();
                        });
                        setState(() {});
                      }
                    ),
                  ]
                ),
                Text(
                  '• words: ${_wordAction.resultSearch.entries.elementAt(index).value.keysToString()}',
                  style: const TextStyle(fontSize: 20)
                ),
                Text(
                  '• means: ${_wordAction.resultSearch.entries.elementAt(index).value.meansToString()}',
                  style: const TextStyle(fontSize: 20)
                ),
                Text(
                  '• note: ${_wordAction.resultSearch.entries.elementAt(index).value.note}',
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