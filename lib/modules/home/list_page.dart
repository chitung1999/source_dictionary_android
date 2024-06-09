import 'package:flutter/material.dart';
import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import '../../models/word_model.dart';
import '../../models/word_search_model.dart';
import '../../models/config_app.dart';

class ListPage extends StatefulWidget {
  final Function() onClick;

  const ListPage({Key? key, required this.onClick}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final WordSearchModel _wordSearch = WordSearchModel();
  final WordModel _word = WordModel();
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
            'Count: ${_word.eng.length}',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 10),
          Expanded(child: AlphabetScrollView(
            list: _word.eng.keys.map((e) => AlphaModel(e)).toList(),
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
                    _wordSearch.reset();
                    _wordSearch.query = id;
                    List<int>? group = _word.eng[id];
                    for(int i = 0; i < group!.length; i++) {
                      _wordSearch.data.add(_word.data[group[i]]);
                    }
                    widget.onClick();
                  },
                )
              ]);
            },
            selectedTextStyle: TextStyle(color: _config.theme == ThemeApp.light ? Colors.black87 : Colors.white),
            unselectedTextStyle: TextStyle(color: _config.theme == ThemeApp.light ? Colors.black38 :Colors.white38),
          ))
        ],
      )
    );
  }
}