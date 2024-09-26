import 'package:flutter/material.dart';
import '../../common/text_btn.dart';
import '../../models/database.dart';

class ListPage extends StatefulWidget {
  final Function() onSelect;
  final Function() onChangedLanguage;

  const ListPage({Key? key, required this.onSelect, required this.onChangedLanguage}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool _isEng = true;

  @override
  void initState() {
    _isEng = database.wordModel.query.isEng;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextBtn(
              onPressed: () {
                setState(() {_isEng = !_isEng;});
                database.wordModel.query.isEng = _isEng;
                widget.onChangedLanguage();
              },
              title: _isEng ? 'EN' : 'VN',
            ),
            SizedBox(width: 20),
            SizedBox(
              width: 120,
              child: Text(
                'Count: ${database.wordModel.resultSearch.length}',
                style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic)
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            children: List.generate(
              database.wordModel.resultSearch.length, (index) => Column(
                children: [
                  GestureDetector(
                    child: Container(
                      width: 250,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(width: 2, color: Colors.blueGrey)
                      ),
                      child: Center(child: Text(
                        database.wordModel.resultSearch[index],
                        style: TextStyle(fontSize: 20, color: Colors.deepPurple[800])
                      ))
                    ),
                    onTap: () {
                      database.wordModel.query.set(database.wordModel.resultSearch[index], _isEng);
                      widget.onSelect();
                    },
                  ),
                  SizedBox(height: 5)
                ],
              )
            ),
          ),
        )
      ],
    );
  }
}