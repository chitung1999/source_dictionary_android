import 'package:flutter/material.dart';

class ResultItem extends StatefulWidget {
  final Function() onModify;
  final Function() onDelete;
  final String eng;
  final String vn;
  final String note;

  const ResultItem({Key? key, required this.onModify, required this.onDelete, required this.eng, required this.vn, required this.note}) : super(key: key);

  @override
  State<ResultItem> createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {
  bool _isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(_isEdit) Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              child: Icon(Icons.edit, color: Colors.blueGrey[300]),
                onTap: () {
                setState(() {_isEdit = false;});
                widget.onModify();
              }
            ),
            SizedBox(width: 15),
            GestureDetector(child: Icon(Icons.delete_outline,
              color: Colors.red[300]),
              onTap: () {
                setState(() {_isEdit = false;});
                widget.onDelete();
              }
            ),
            SizedBox(width: 15),
          ],
        ),
        GestureDetector(
          onLongPress: () {setState(() {_isEdit = true;});},
          onTap: () {setState(() {_isEdit = false;});},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(width: 2, color: Colors.blueGrey)
            ),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '• words: ${widget.eng}',
                    style: TextStyle(fontSize: 20)
                ),
                Text(
                    '• means: ${widget.vn}',
                    style: TextStyle(fontSize: 20)
                ),
                if(widget.note.isNotEmpty) Text(
                    '• note: ${widget.note}',
                    style: TextStyle(fontSize: 20)
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20)
      ]
    );
  }
}