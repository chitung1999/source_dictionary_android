import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../models/dictionary_model.dart';

class ResultDictionary extends StatefulWidget {
  const ResultDictionary({Key? key}) : super(key: key);

  @override
  _ResultDictionaryState createState() => _ResultDictionaryState();
}

class _ResultDictionaryState extends State<ResultDictionary> {
  DictionaryModel dictionary = DictionaryModel();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    if(dictionary.word.isEmpty) {
      return const Center(child: Text('No results found!', style: TextStyle(fontSize: 20, color: Colors.blueGrey)));
    }

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Column( children: [
          Row( children: [
            Text(dictionary.word, style: const TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold, color: Colors.blueGrey)),
            const Spacer(),
            Text(dictionary.phonetic, style: const TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold, color: Colors.blueGrey)),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.volume_up, color: Colors.blueGrey,),
              onPressed: () { _audioPlayer.play(UrlSource(dictionary.audio));},
            ),
          ]),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 20.0),
              itemCount: dictionary.mean.length,
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
                          Text('${dictionary.mean[index].partSpeech}:',
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          Text('• synonyms: ${dictionary.mean[index].synonyms}',
                              style: const TextStyle(fontSize: 15)),
                          Text('• antonyms: ${dictionary.mean[index].antonyms}',
                              style: const TextStyle(fontSize: 15)),
                          const Text('• mean:', style: TextStyle(fontSize: 15)),
                          for(Definition value in dictionary.mean[index].definitions)
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