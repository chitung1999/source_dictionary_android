import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:source_dictionary_mobile/common/text_box_btn.dart';
import 'package:source_dictionary_mobile/models/database.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});
  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final TextEditingController _controller = TextEditingController();
  late String _pathLottie;
  late List<String> _option;
  late List<Color?> _bgColor;
  late int _answer;
  late int _correct;
  late int _incorrect;
  late bool _isAnswered;

  void _onAnswered(int index) {
    setState(() {
      _isAnswered = true;
      if(_answer == index) {
        _pathLottie = 'data/game_ani_correct.json';
        _correct += 1;
        _bgColor[index] = Colors.green[400]!;
      } else {
        _pathLottie = 'data/game_ani_incorrect.json';
        _incorrect += 1;
        _bgColor[index] = Colors.red[400]!;
        _bgColor[_answer] = Colors.green[400]!;
      }
    });
  }

  void _reset() {
    _controller.text = '';
    _pathLottie = 'data/game_ani_loading.json';
    _bgColor = [null, null, null, null];
    _option = [];
    _isAnswered = false;

    int randomNumber = Random().nextInt(database.wordModel.data.length);
    List<String> keys = database.wordModel.data[randomNumber].keys;
    List<String> means = database.wordModel.data[randomNumber].means;
    randomNumber = Random().nextInt(keys.length);
    for (int i = 0; i < means.length; i++) {
      _controller.text += means[i];
      _controller.text += (i == means.length - 1) ? ': ' : ', ';
    }
    for (int i = 0; i < keys.length; i++) {
      if(i != randomNumber) {
        _controller.text += '${keys[i]}, ';
      }
    }
    _controller.text += '...';

    _option.add(keys[randomNumber]);
    _answer = randomNumber;
    while(_option.length < 4) {
      randomNumber = Random().nextInt(database.wordModel.data.length);
      List<String> keyOption = database.wordModel.data[randomNumber].keys;
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
    _reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: height/6,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              'Incorrect',
                              style: const TextStyle(fontSize: 14, fontFamily: 'SpicyRice', color: Colors.redAccent)
                          ),
                          Text(
                              '$_incorrect',
                              style: TextStyle(fontSize: _incorrect < 100 ? 55 : 35, fontFamily: 'SpicyRice', fontWeight: FontWeight.bold, color: Colors.redAccent)
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: Stack(
                      children: [
                        Positioned(
                          top: height/70,
                          child: Lottie.asset(_pathLottie, width: (width-40)/3, height: (width-20)/3)
                        )
                      ],
                    )),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              '$_correct',
                              style: TextStyle(fontSize: _correct < 100 ? 55 : 35, fontFamily: 'SpicyRice', fontWeight: FontWeight.bold, color: Colors.green)
                          ),
                          Text(
                              'Correct',
                              style: TextStyle(fontSize: 14, fontFamily: 'SpicyRice', color: Colors.green)
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(height: height / 8, child: Center(
              //     child: Lottie.asset(_pathLottie)
              // )),
              TextField(
                controller: _controller,
                minLines: 3,
                maxLines: 3,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.deepPurple[900]),
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple[800]!, width: 2)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple[800]!, width: 2))
                ),
              ),
              Column(
                  children: [
                    for(int i = 0; i < 4; i++)...[
                      TextBoxBtn(
                        title: _option[i],
                        width: width,
                        height: height / 14,
                        radius: 10,
                        bgColor: _bgColor[i],
                        textSize: 20,
                        textColor: Colors.deepPurple,
                        onPressed: () {
                          if (!_isAnswered) {
                            _onAnswered(i);
                          }
                        },
                      ),
                      SizedBox(height: height/100)
                    ]
                  ]
              ),
              SizedBox(
                width: width / 2,
                height: height/15,
                child: _isAnswered ? ElevatedButton(
                    onPressed: () {
                      if (_isAnswered) {
                        setState(() {_reset();});
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.deepPurple),
                        )
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Next', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.deepPurple)),
                          SizedBox(width: 20),
                          Lottie.asset('data/game_ani_next.json')
                        ]
                    )
                ) : null,
              ),
            ]
        )
    );
  }
}