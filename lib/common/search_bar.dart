import 'package:flutter/material.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key, required this.isSearching, required this.onClick, required this.onTyping});

  final bool isSearching;
  final Function() onClick;
  final Function(String) onTyping;

  @override
  _SearchBarAppState createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: 40.0,
      width: widget.isSearching ? MediaQuery.of(context).size.width - 90 : 40,
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _controller,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 20, top: 5),
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              widget.onClick();
              _controller.text = '';
            }
          )
        ),
        textAlignVertical: TextAlignVertical(y: -1),
        onChanged: (String ) {
          widget.onTyping(_controller.text);
        },
      )
    );
  }
}