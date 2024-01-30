import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:source_dictionary_mobile/component/dictionary/dictionary_item.dart';

class ResultDictionary extends StatefulWidget {
  final DictionaryItem? item;

  const ResultDictionary({Key? key, this.item}) : super(key: key);

  @override
  _ResultDictionaryState createState() => _ResultDictionaryState();
}

class _ResultDictionaryState extends State<ResultDictionary> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        height: 1000,
        width: 400,
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 20),
                Text('${widget.item?.word}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                Text('${widget.item?.phonetic}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  onPressed: () { _audioPlayer.play(UrlSource('${widget.item?.audio}'));},
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Item ${index + 1}'),
                  );
                },
              ),
            ),
          ],
        )
    );
  }
}