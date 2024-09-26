import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'play_page.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _isPlaying = false;

  Future<void> loadScreen() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    if (_isPlaying)
      return PlayPage();
    else
      return Center(child: SizedBox(
        width: 250,
        height: 250,
        child: GestureDetector(
          onTap: () async {
            setState(() {_isPlaying = true;});
          },
          child: Lottie.asset('data/game_ani_start.json'),
        ),
      ));
  }
}