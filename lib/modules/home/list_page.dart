import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:flutter/material.dart';
import '../../common/text_btn.dart';
import '../../models/database.dart';

class ListPage extends StatefulWidget {
  final Function() onSelect;

  const ListPage({Key? key, required this.onSelect}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool _isEng = true;

  @override
  void initState() {
    _isEng = database.wordModel.query.isEng;
    database.wordModel.search();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: database.wordModel.eng.length != database.wordModel.resultSearch.length ? GestureDetector(
                child: Icon(Icons.filter_alt_off, color: Colors.deepPurple, size: 20),
                onTap: () {
                  database.wordModel.query.textTyping = '';
                  database.wordModel.search();
                  setState(() {});
                },
              ) : SizedBox()
            ),
            Expanded(child: Center(child: TextBtn(
              title: _isEng ? 'EN' : 'VN',
              onPressed: () {
                setState(() {_isEng = !_isEng;});
                database.wordModel.query.isEng = _isEng;
                database.wordModel.search();
              }
            ))),
            Expanded(child: Text(
              'Result: ${database.wordModel.resultSearch.length}',
              style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: Colors.deepPurple)
            )),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(child: AlphabetScrollView(
          list: database.wordModel.resultSearch.map((e) => AlphaModel(e)).toList(),
          itemExtent: 50,
          itemBuilder: (_, k, id) {
            return Column(children: [
              GestureDetector(
                child: Container(
                  width: 250,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(width: 2, color: Colors.blueGrey)
                  ),
                  child: Center(child: Text(id, style: const TextStyle(fontSize: 20)
                  ))
                ),
                onTap: () {
                  database.wordModel.query.set(database.wordModel.resultSearch[k], _isEng);
                  widget.onSelect();
                },
              )
            ]);
          },
          selectedTextStyle: TextStyle(color: Colors.deepPurple),
          unselectedTextStyle: TextStyle(color: Colors.deepPurple.withOpacity(0.3)),
        ))
      ],
    );
  }
}