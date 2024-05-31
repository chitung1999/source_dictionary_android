import 'package:flutter/material.dart';
import '../../models/word_model.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final WordModel _word = WordModel();

  @override

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Count: ${_word.key.length}',
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded( child: ListView.builder(
                itemCount: _word.key.length,
                itemBuilder: (context, index) { return Column(children: [
                  const SizedBox(height: 10),
                  Container(
                      width: 230,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(width: 2, color: Colors.blueGrey)
                      ),
                      child: Center( child: Text(
                          _word.key.keys.elementAt(index),
                          style: const TextStyle(fontSize: 20)
                      ))
                  )
                ]);}
            ))
          ],
        )
    );
  }
}