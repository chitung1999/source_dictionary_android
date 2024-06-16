import 'dart:math';
import 'package:flutter/material.dart';
import 'package:source_dictionary_mobile/models/word_model.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key, required this.onPlayingChanged});
  final Function(bool) onPlayingChanged;

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  WordModel _wordModel = WordModel();
  late Icon _iconStatus;
  late String _question;
  late List<String> _option;
  late List<Color> _colorBorder;
  late List<IconData> _iconData;
  late int _answer;
  late int _correct;
  late int _incorrect;
  late bool _isAnswered;

  void _onAnswered(int index) {
    setState(() {
      _isAnswered = true;
      if(_answer == index) {
        _iconStatus = Icon(Icons.check_circle, size: 80, color: Colors.green);
        _correct += 1;
        _colorBorder[index] = Colors.green;
      } else {
        _iconStatus = Icon(Icons.highlight_off, size: 80, color: Colors.redAccent);
        _incorrect += 1;
        _colorBorder[index] = Colors.redAccent;
        _colorBorder[_answer] = Colors.green;
      }
    });
  }

  void _reset() {
    _iconStatus = Icon(Icons.hourglass_bottom, size: 80, color: Colors.blueGrey);
    _question = '';
    _colorBorder = [Colors.blueGrey, Colors.blueGrey, Colors.blueGrey, Colors.blueGrey];
    _option = [];
    _isAnswered = false;

    int randomNumber = Random().nextInt(_wordModel.data.length);
    List<String> keys = _wordModel.data[randomNumber].keys;
    List<String> means = _wordModel.data[randomNumber].means;
    randomNumber = Random().nextInt(keys.length);
    for (int i = 0; i < means.length; i++) {
      _question += means[i];
      _question += (i == means.length - 1) ? ': ' : ', ';
    }
    for (int i = 0; i < keys.length; i++) {
      if(i != randomNumber) {
        _question += '${keys[i]}, ';
      }
    }
    _question += '...';

    _option.add(keys[randomNumber]);
    _answer = randomNumber;
    while(_option.length < 4) {
      randomNumber = Random().nextInt(_wordModel.data.length);
      List<String> keyOption = _wordModel.data[randomNumber].keys;
      randomNumber = Random().nextInt(keyOption.length);
      if(!keys.contains(keyOption[randomNumber])) {
        _option.add(keyOption[randomNumber]);
      }
    }
    _option.shuffle();
    _answer = _option.indexOf(keys[_answer]);
  }

  @override
  void initState() {
    _correct = 0;
    _incorrect = 0;
    _iconData = [Symbols.counter_1, Symbols.counter_2, Symbols.counter_3, Symbols.counter_4];
    _reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 70,
                child: Center(child: Text('$_correct', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green)))
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: _correct + _incorrect == 0 ? 1 : _correct / (_correct + _incorrect),
                  backgroundColor: Colors.redAccent,
                  color: Colors.green,
                ),
              ),
              Container(
                width: 70,
                child: Center(child: Text('$_incorrect', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.redAccent)))
              ),
            ],
          ),
          _iconStatus,
          Container(
            width: double.infinity,
            height: 140,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(width: 2, color: Colors.grey)
            ),
            child: Center(child: Text(
              _question,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepPurple))),
          ),
          Column(
            children: [
              for(int i = 0; i < 4; i++)...[
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    side: BorderSide(width: 3, color: _colorBorder[i])
                  ),
                  onPressed: () {
                    if (!_isAnswered) {
                      _onAnswered(i);
                    }
                  },
                  child: Row(
                    children: [
                      Icon(_iconData[i], color: Colors.blueGrey, size: 30),
                      Expanded(child: Center(child: Text(_option[i], style: const TextStyle(fontSize: 20))))
                    ],
                  ),
                  //child: Text(_option[i], style: const TextStyle(fontSize: 20))
                ),
                SizedBox(height: 10)
              ]
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    side: const BorderSide(color: Colors.blueGrey)
                  ),
                  onPressed: () {widget.onPlayingChanged(false);},
                  child: const Text('End Game', style: TextStyle(fontSize: 20, color: Colors.grey))
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    side: const BorderSide(color: Colors.blueGrey),
                  ),
                  onPressed: () {
                    if (_isAnswered) {
                      setState(() {_reset();});
                    }
                  },
                  child: Text('Next', style: TextStyle(fontSize: 20, color: _isAnswered ? Colors.deepPurple : Colors.grey))
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}