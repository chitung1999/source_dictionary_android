import 'package:flutter/material.dart';
import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:source_dictionary_mobile/models/word_action.dart';
import '../../models/word_model.dart';
import '../../models/config_app.dart';
import '../../models/enum_app.dart';

class ListPage extends StatefulWidget {
  final Function() onClick;

  const ListPage({Key? key, required this.onClick}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final WordAction _wordAction = WordAction();
  final WordModel _wordModel = WordModel();
  final ConfigApp _config = ConfigApp();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0, horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Count: ${_wordModel.eng.length}',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 10),
          Expanded(child: AlphabetScrollView(
            list: _wordModel.eng.keys.map((e) => AlphaModel(e)).toList(),
            itemExtent: 50,
            itemBuilder: (_, k, id) {
              return Column(children: [
                GestureDetector(
                  child: Container(
                    width: 230,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(width: 2, color: Colors.blueGrey)
                    ),
                    child: Center(child: Text(
                      '$id',
                      style: const TextStyle(fontSize: 20)
                    ))
                  ),
                  onTap: () {
                    _wordAction.query = id;
                    _wordAction.resultSearch.clear();

                    for(int num in _wordAction.isEng ? _wordModel.eng[_wordAction.query]! : _wordModel.vn[_wordAction.query]!) {
                      _wordAction.resultSearch[num] = _wordModel.data[num];
                    }
                    widget.onClick();
                  },
                )
              ]);
            },
            selectedTextStyle: TextStyle(color: Colors.deepPurple),
            unselectedTextStyle: TextStyle(color: Colors.deepPurple.withOpacity(0.3)),
          ))
        ],
      )
    );
  }
}