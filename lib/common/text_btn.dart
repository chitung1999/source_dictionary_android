import 'package:flutter/material.dart';

class TextBtn extends StatefulWidget {
  const TextBtn(
      {super.key,
        required this.title,
        this.size = 15,
        this.color = Colors.deepPurple,
        this.isItalic = false,
        required this.onPressed});

  final String title;
  final double size;
  final Color color;
  final bool isItalic;
  final Function() onPressed;

  @override
  _TextBtnState createState() => _TextBtnState();
}

class _TextBtnState extends State<TextBtn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      child: Text(
        widget.title,
        style: TextStyle(
          fontStyle: widget.isItalic ? FontStyle.italic : FontStyle.normal,
          fontWeight: FontWeight.bold,
          fontSize: widget.size,
          color: widget.color
        )
      ),
    );
  }
}