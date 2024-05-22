import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dictionary_item.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Column( children: [
          Row( children: [
            Text('${widget.item?.word}', style: const TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold, color: Colors.blueGrey)),
            const Spacer(),
            Text('${widget.item?.phonetic}', style: const TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold, color: Colors.blueGrey)),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.volume_up, color: Colors.blueGrey,),
              onPressed: () { _audioPlayer.play(UrlSource('${widget.item?.audio}'));},
            ),
          ]),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 20.0),
              itemCount: widget.item?.mean.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(width: 2, color: Colors.blueGrey)
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(),
                          Text('${widget.item?.mean[index].partSpeech}:',
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          Text('• synonyms: ${widget.item?.mean[index].synonyms}',
                              style: const TextStyle(fontSize: 15)),
                          Text('• antonyms: ${widget.item?.mean[index].antonyms}',
                              style: const TextStyle(fontSize: 15)),
                          const Text('• mean:', style: TextStyle(fontSize: 15)),
                          for(DefinitionItem value in widget.item?.mean[index].definitions ?? [])
                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text('  ➪${value.definition}', style: const TextStyle(fontSize: 15)),
                              Text('  ex: ${value.example}', style: const TextStyle(fontSize: 15)),
                            ]),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],)
    );
  }
}