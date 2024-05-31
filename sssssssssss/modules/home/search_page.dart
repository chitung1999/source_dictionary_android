import 'package:flutter/material.dart';
import '../../../models/word_model.dart';

class SearchConfig {
  bool isSearch = false;
  String word = '';
  List<int> group = [];

  void reset() {
    isSearch = false;
    word = '';
    group = [];
  }
}

class  SearchPage extends SearchDelegate<SearchConfig?> {
  final WordModel? data;
  final List<String> _listSearch = [];
  final SearchConfig _config = SearchConfig();
  bool _isEng = true;

  SearchPage({required this.data});

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
          _config.reset();
          close(context, _config);
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _config.reset();
    _config.isSearch = true;

    if(_listSearch.isNotEmpty) {
      _config.group = _listSearch.isEmpty ? []
          : (_isEng ? data!.key[_listSearch[0]]! : data!.mean[_listSearch[0]]!);
      _config.word = _listSearch[0];
    }

    close(context, _config);
    return Container();
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
            onTap: () {
              _config.reset();
              _config.isSearch = true;
              _config.group = _isEng ? data!.key[_listSearch[index]]! : data!.mean[_listSearch[index]]!;
              _config.word = _listSearch[index];
              close(context, _config);
            },
          );
        }
      )
    );
  }
}