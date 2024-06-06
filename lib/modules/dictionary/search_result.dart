import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'api_service.dart';
import '../../models/dictionary_model.dart';

class ResultDictionary extends StatefulWidget {
  const ResultDictionary({Key? key, required this.query}) : super(key: key);
  final String query;

  @override
  _ResultDictionaryState createState() => _ResultDictionaryState();
}

class _ResultDictionaryState extends State<ResultDictionary> {
  DictionaryModel dictionary = DictionaryModel();
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<bool> _getData() async {
    DictionaryModel dictionary = DictionaryModel();
    APIService dictionaryAPI = APIService();
    dictionary.resetData();
    final List<dynamic> data = await dictionaryAPI.requestAPI(widget.query);
    if (data.isNotEmpty) {
      dictionary.loadData(data[0]);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: CircularProgressIndicator());
        else {
          if (dictionary.word.isEmpty) {
            return const Center(child: Text('No results found!',
                style: TextStyle(fontSize: 20, color: Colors.blueGrey)));
          }
          return Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 20.0, horizontal: 30.0),
              child: Column(children: [
                Row(children: [
                  Text(dictionary.word, style: const TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                  const Spacer(),
                  Text(dictionary.phonetic, style: const TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.volume_up, color: Colors.blueGrey,),
                    onPressed: () {
                      _audioPlayer.play(UrlSource(dictionary.audio));
                    },
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
                                border: Border.all(
                                    width: 2, color: Colors.blueGrey)
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(),
                                Text('${dictionary.mean[index].partSpeech}:',
                                    style: const TextStyle(fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                Text('• synonyms: ${dictionary.mean[index]
                                    .synonyms}',
                                    style: const TextStyle(fontSize: 15)),
                                Text('• antonyms: ${dictionary.mean[index]
                                    .antonyms}',
                                    style: const TextStyle(fontSize: 15)),
                                const Text(
                                    '• mean:', style: TextStyle(fontSize: 15)),
                                for(Definition value in dictionary.mean[index]
                                    .definitions)
                                  Column(crossAxisAlignment: CrossAxisAlignment
                                      .start, children: [
                                    Text('  ➪${value.definition}',
                                        style: const TextStyle(fontSize: 15)),
                                    Text('  ex: ${value.example}',
                                        style: const TextStyle(fontSize: 15)),
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
    );
  }
}