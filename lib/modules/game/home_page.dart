import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import '../../models/word_model.dart';
import '../../component/notify_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.onPlayingChanged});
  final Function(bool) onPlayingChanged;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedButton(
          text: 'START',
          width: 200,
          height: 100,
          borderColor: Colors.blueGrey,
          borderWidth: 2.0,
          borderRadius: 10,
          isSelected: false,
          selectedTextColor: Colors.white,
          selectedBackgroundColor: Colors.blueGrey,
          transitionType: TransitionType.TOP_CENTER_ROUNDER,
          animationDuration: const Duration(milliseconds: 500),
          textStyle: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 5,
            color: Colors.blueGrey,
          ),
          onPress: () async {
            if(!_isSelected) {
              setState(() {_isSelected = true;});
              WordModel wordModel = WordModel();
              if (wordModel.data.length < 4) {
                showDialog(
                    context: context, builder: (BuildContext context) {
                  return NotifyDialog(isSuccess: false,
                      message: 'You need at least 4 groups of words to play the game!');
                }
                );
              }
              else {
                await Future.delayed(const Duration(milliseconds: 600));
                widget.onPlayingChanged(true);
              }
              setState(() {_isSelected = false;});
            }
          }
      ),
    );
  }
}