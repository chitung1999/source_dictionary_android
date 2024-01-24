import 'package:flutter/material.dart';
import 'scene/taskbar.dart';

void main() {
  runApp(const DictionaryApp());
}

class DictionaryApp extends StatelessWidget {
  const DictionaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Taskbar(),
      debugShowCheckedModeBanner: false,
    );
  }
}