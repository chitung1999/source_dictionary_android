import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.onPlayingChanged});
  final Function(bool) onPlayingChanged;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            await Future.delayed(const Duration(milliseconds: 600));
            widget.onPlayingChanged(true);
          }
      ),
    );
  }
}