import 'package:flutter/material.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key, required this.onTyping});

  final Function(String) onTyping;

  @override
  _SearchBarAppState createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  TextEditingController _controller = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: 40.0,
      width: _isSearching ? MediaQuery.of(context).size.width - 90 : 40,
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focus,
        style: TextStyle(fontSize: 18, color: Colors.black),
        cursorColor: Colors.black87,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 20, top: 2),
          suffixIcon: IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              setState(() {_isSearching = !_isSearching;});
              _controller.text = '';
              _isSearching ?  _focus.requestFocus() : _focus.unfocus();
            }
          )
        ),
        textAlignVertical: TextAlignVertical(y: -1),
        onChanged: (String ) {
          widget.onTyping(_controller.text);
        },
        onSubmitted: (String) {
          setState(() {_isSearching = !_isSearching;});
          _controller.text = '';
          _isSearching ?  _focus.requestFocus() : _focus.unfocus();
        },
      )
    );
  }
}