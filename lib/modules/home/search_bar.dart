import 'package:flutter/material.dart';
import 'search_type.dart';
import '../../model/word_model.dart';

class  SearchBarCustom extends SearchDelegate {
  final WordModel? data;
  final List<String> _listSearch = [];
  bool _isEng = true;

  void _onClick(bool newValue) {
    _isEng = newValue;
  }

  SearchBarCustom({required this.data});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      SearchType(onClick: _onClick),
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {close(context, null);}
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<int> resultSearch = _listSearch.isEmpty ? []
        : (_isEng ? data!.key[_listSearch[0]]! : data!.mean[_listSearch[0]]!);

    return Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
            itemCount: resultSearch.length,
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
                              _listSearch[0],
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                          ),
                          const Row( children: [
                            IconButton(onPressed: null, icon: Icon(Icons.playlist_add)),
                            IconButton(onPressed: null, icon: Icon(Icons.playlist_add)),
                          ])
                        ]
                    ),
                    Text(
                        '• words: ${data!.data[resultSearch[index]].keys}',
                        style: const TextStyle(fontSize: 20)
                    ),
                    Text(
                        '• means: ${data!.data[resultSearch[index]].means}',
                        style: const TextStyle(fontSize: 20)
                    ),
                    Text(
                        '• note: ${data!.data[resultSearch[index]].note}',
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

  @override
  Widget buildSuggestions(BuildContext context) {
    _listSearch.clear();
    for(String item in (_isEng ? data!.key.keys : data!.mean.keys)) {
      if(item.toLowerCase().contains(query.toLowerCase())){
        _listSearch.add(item);
      }
    }

    return Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
            itemCount: _listSearch.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_listSearch[index], style: const TextStyle(fontSize: 20),),
              );
            }
        )
    );
  }
}