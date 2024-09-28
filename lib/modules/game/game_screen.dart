import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../models/database.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dictionary', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
        flexibleSpace: database.configApp.banner,
        actions: [
          if(_isPlaying) Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: const Icon(Icons.clear, color: Colors.black),
              onPressed: () {setState(() {_isPlaying = false;});}
            ),
          ),
          SizedBox(width: 20)
        ],
      ),
      body: _isPlaying ? PlayPage() : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('data/game_ani_start_thumb.json'),
            GestureDetector(
              onTap: () async {
                setState(() {_isPlaying = true;});
              },
              child: Lottie.asset('data/game_ani_start_btn.json'),
            )
          ]
        ),
      )
    );
  }
}