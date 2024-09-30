import 'package:flutter/material.dart';
import 'package:source_dictionary_mobile/common/enum.dart';
import '../../common/action_app.dart';
import 'search_result_item.dart';
import '../../common/change_data.dart';
import '../../models/database.dart';
import '../../models/word_model.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key, required this.onBack}) : super(key: key);
  final Function() onBack;

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
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 40,
                child: GestureDetector(
                  child: Icon(Icons.arrow_back, color: Colors.blueGrey.withOpacity(0.5), size: 25),
                  onTap: (){widget.onBack();},
                ),
              ),
              Text(
                  _data.isEmpty ? 'Back' : '${query.textSearch}',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.deepPurple)
              ),
              SizedBox(width: 40)
            ],
          ),
          SizedBox(height: 20),
          _data.isEmpty ? Expanded(child: Center(child: Text('0 results', style: TextStyle(fontSize: 25)))) :
          Expanded(
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return ResultItem(
                  onModify: () async {
                    await showDialog(context: context, builder: (BuildContext context) {
                      return ChangeData(isHome: true, isAddNew: false,
                        wordItem: _data[index], index: _indexData[index], onSuccess: _onModifySuccess);
                    });
                    setState(() {});
                  },
                  onDelete: () async {
                    StatusApp ret = await database.removeGroup(_indexData[index]);
                    if(ret == StatusApp.REMOVE_WORD_SUCCESS) {
                      ActionApp.showNotify(context, MessageType.SUCCESS, ret);
                      _onModifySuccess();
                    } else {
                      ActionApp.showNotify(context, MessageType.ERROR, ret);
                    }
                  },
                  eng: _data[index].keysToString(),
                  vn: _data[index].meansToString(),
                  note: _data[index].note
                );
              }
            ),
          ),
        ],
      )
    );
  }
}