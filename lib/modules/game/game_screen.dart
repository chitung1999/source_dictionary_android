import 'package:flutter/material.dart';
import 'home_page.dart';
import 'play_page.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _isPlaying = false;

  void _onPlayingChanged(bool isPlaying) {
    setState(() {_isPlaying = isPlaying;});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Dictionary',
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
      body: _isPlaying ? PlayPage(onPlayingChanged: _onPlayingChanged) : HomePage(onPlayingChanged: _onPlayingChanged)
    );
  }
}