import 'package:flutter/material.dart';
import '../../../models/word_search_model.dart';
import '../../../models/word_model.dart';

class  SearchPage extends SearchDelegate<bool?> {
  final WordSearchModel _wordSearch = WordSearchModel();
  final WordModel _word = WordModel();
  final List<String> _listSearch = [];

  @override
  List<Widget> buildActions(BuildContext context) {

    return [
      StatefulBuilder(builder: (thisLowerContext, StateSetter setState) {
        return TextButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          child: Text((_wordSearch.isEng ? 'EN' : 'VN')),
          onPressed: () { setState(() { _wordSearch.isEng = !_wordSearch.isEng; query = ''; }); },
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
    return Container();
  }

  @override
  Widget showResults(BuildContext context) {
    _wordSearch.reset();
    if(_listSearch.isNotEmpty) {
      _wordSearch.query = _listSearch[0];

      List<int>? group = _wordSearch.isEng ? _word.eng[_listSearch[0]] : _word.vn[_listSearch[0]];
      for(int i = 0; i < group!.length; i++) {
        _wordSearch.data.add(_word.data[group[i]]);
      }
    }
    close(context,true);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _listSearch.clear();
    for(String item in (_wordSearch.isEng ? _word.eng.keys : _word.vn.keys)) {
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
                onTap: () {
                  _wordSearch.reset();
                  _wordSearch.query = _listSearch[index];
                  List<int>? group = _wordSearch.isEng ? _word.eng[_listSearch[index]] : _word.vn[_listSearch[index]];
                  for(int i = 0; i < group!.length; i++) {
                  _wordSearch.data.add(_word.data[group[i]]);
                  }
                  close(context,true);
                },
              );
            }
        )
    );
  }
}