import 'package:flutter/material.dart';
import '../../../models/word_action.dart';
import '../../../models/word_model.dart';

class  SearchPage extends SearchDelegate<bool?> {
  final WordAction _wordAction = WordAction();
  final WordModel _wordModel = WordModel();
  final List<String> _listSearch = [];

  @override
  List<Widget> buildActions(BuildContext context) {

    return [
      StatefulBuilder(builder: (thisLowerContext, StateSetter setState) {
        return TextButton(
          child: Text((_wordAction.isEng ? 'EN' : 'VN')),
          onPressed: () { setState(() { _wordAction.isEng = !_wordAction.isEng; query = ''; }); },
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
    _wordAction.resultSearch.clear();

    if(_listSearch.isNotEmpty) {
      _wordAction.query = _listSearch[0];
      for(int num in _wordAction.isEng ? _wordModel.eng[_wordAction.query]! : _wordModel.vn[_wordAction.query]!) {
        _wordAction.resultSearch[num] = _wordModel.data[num];
      }
    }
    close(context,true);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _listSearch.clear();
    for(String item in (_wordAction.isEng ? _wordModel.eng.keys : _wordModel.vn.keys)) {
      if(item.toLowerCase().startsWith(query.toLowerCase())){
        _listSearch.add(item);
      }
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: _listSearch.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 10),
                Text(_listSearch[index], style: const TextStyle(fontSize: 20),),
              ],
            ),
            onTap: () {
              _wordAction.query = _listSearch[index];
              _wordAction.resultSearch.clear();

              for(int num in _wordAction.isEng ? _wordModel.eng[_wordAction.query]! : _wordModel.vn[_wordAction.query]!) {
                _wordAction.resultSearch[num] = _wordModel.data[num];
              }
              close(context,true);
            },
          );
        }
      )
    );
  }
}