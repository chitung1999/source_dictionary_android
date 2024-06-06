import 'package:flutter/material.dart';
import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import '../../models/word_model.dart';
import '../../models/word_search_model.dart';

class ListPage extends StatefulWidget {
  final Function() onClick;

  const ListPage({Key? key, required this.onClick}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final WordSearchModel _wordSearch = WordSearchModel();
  final WordModel _word = WordModel();

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
                const SizedBox(height: 10),
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
                    _wordSearch.query = _word.eng.keys.elementAt(k);
                    List<int>? group = _word.eng[_word.eng.keys.elementAt(k)];
                    for(int i = 0; i < group!.length; i++) {
                      _wordSearch.data.add(_word.data[group[i]]);
                    }
                    widget.onClick();
                  },
                )
              ]);
            },
            selectedTextStyle: TextStyle(color: Colors.black87),
            unselectedTextStyle: TextStyle(color: Colors.black38),
          ))
        ],
      )
    );
  }
}