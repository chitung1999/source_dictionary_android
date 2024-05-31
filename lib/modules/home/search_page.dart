import 'package:flutter/material.dart';
import '../../../models/word_search_model.dart';
import '../../../models/word_model.dart';

class  SearchPage extends SearchDelegate {
  final WordSearchModel _wordSearch = WordSearchModel();
  final WordModel _word = WordModel();
  bool _isEng = true;
  final List<String> _listSearch = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      StatefulBuilder(builder: (thisLowerContext, StateSetter setState) {
        return TextButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          child: Text((_isEng ? 'EN' : 'VN')),
          onPressed: () { setState(() { _isEng = !_isEng; }); },
        );
      }),
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () { query = ''; },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _wordSearch.reset();
    if(_listSearch.isNotEmpty) {
      _wordSearch.query = _listSearch[0];

      List<int>? group = _isEng ? _word.key[_listSearch[0]] : _word.mean[_listSearch[0]];
      for(int i = 0; i < group!.length; i++) {
        _wordSearch.data.add(_word.data[i]);
      }
    }

    close(context, null);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _listSearch.clear();
    for(String item in (_isEng ? _word.key.keys : _word.mean.keys)) {
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