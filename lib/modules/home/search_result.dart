import 'package:flutter/material.dart';
import '../../common/change_data.dart';
import '../../models/database.dart';
import '../../models/word_model.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<WordItem> _data = [];
  List<int> _indexData = [];
  Query query = Query();

  void _onModifySuccess() {
    _getData();
    setState(() {});
  }

  void _getData() {
    _data.clear();
    query = database.wordModel.query;
    if(query.textSearch.isNotEmpty) {
      try {
        _indexData =
        query.isEng ? database.wordModel.eng[query.textSearch]! : database
            .wordModel.vn[query.textSearch]!;
        for (int i in _indexData) {
          _data.add(database.wordModel.data[i]);
        }
      } catch(e) {}
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(_data.isEmpty) {
      return Center(child: Text('0 results', style: TextStyle(fontSize: 25, color: Colors.deepPurple[800])));
    }
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: _data.length,
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
                      '${query.textSearch}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple[800])
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        await showDialog(context: context, builder: (BuildContext context) {
                          return ChangeData(isHome: true, isAddNew: false,
                              wordItem: _data[index], index: _indexData[index], onSuccess: _onModifySuccess);
                        });
                        setState(() {});
                      }
                    ),
                  ]
                ),
                Text(
                  '• words: ${_data[index].keysToString()}',
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey[800])
                ),
                Text(
                  '• means: ${_data[index].meansToString()}',
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey[800])
                ),
                Text(
                  '• note: ${_data[index].note}',
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey[800])
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