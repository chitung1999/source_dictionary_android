import 'package:flutter/material.dart';

class TextBoxBtn extends StatefulWidget {
  const TextBoxBtn(
      {super.key,
        required this.title,
        this.width,
        this.height,
        this.radius = 0,
        this.outlineColor = Colors.blueGrey,
        this.bgColor = Colors.blueGrey,
        this.textSize = 15,
        this.textColor = Colors.white,
        required this.onPressed});

  final String title;
  final double? width;
  final double? height;
  final double radius;
  final Color outlineColor;
  final Color bgColor;
  final double textSize;
  final Color textColor;
  final Function() onPressed;

  @override
  _TextBoxBtnState createState() => _TextBoxBtnState();
}

class _TextBoxBtnState extends State<TextBoxBtn> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
          onPressed: () {
            widget.onPressed();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: widget.bgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                side: BorderSide(
                  color: widget.outlineColor, // Màu của outline
                ),
              )),
          child: Text(widget.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: widget.textSize,
                  color: widget.textColor))),
    );
  }
}