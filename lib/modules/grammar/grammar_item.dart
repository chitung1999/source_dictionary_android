import 'package:flutter/material.dart';

class GrammarItem extends StatefulWidget {
  final Function() onModify;
  final Function() onDelete;
  final String form;
  final String structure;

  const GrammarItem({Key? key, required this.onModify, required this.onDelete, required this.form, required this.structure}) : super(key: key);

  @override
  State<GrammarItem> createState() => _GrammarItemState();
}

class _GrammarItemState extends State<GrammarItem> {
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
            GestureDetector(
              child: Icon(Icons.delete_outline, color: Colors.red[300]),
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
            width: double.infinity,
            padding: const EdgeInsets.only(left: 15, right: 10, top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.form,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                      ),
                      Text(
                        widget.structure,
                        style: TextStyle(fontSize: 17)
                      ),
                    ],
                  ),
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