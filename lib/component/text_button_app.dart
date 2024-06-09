import 'package:flutter/material.dart';

class TextButtonApp extends StatefulWidget {
  const TextButtonApp({Key? key, required this.backgroundColor, required this.label, required this.onPressed}) : super(key: key);
  final Color backgroundColor;
  final String label;
  final Function() onPressed;

  @override
  _TextButtonAppState createState() => _TextButtonAppState();
}

class _TextButtonAppState extends State<TextButtonApp> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {widget.onPressed();},
        child: Text(widget.label, style: TextStyle(color: Colors.black)),
        style: ElevatedButton.styleFrom(backgroundColor: widget.backgroundColor)
      ),
    );
  }
}