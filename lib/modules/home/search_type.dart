import 'package:flutter/material.dart';

class SearchType extends StatefulWidget {
  final Function(bool) onClick;

  const SearchType({Key? key, required this.onClick}) : super(key: key);

  @override
  State<SearchType> createState() => _SearchTypeState();
}

class _SearchTypeState extends State<SearchType> {
  bool _isEng = true;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        onPressed: () {
          setState(() {_isEng = !_isEng;});
          widget.onClick(_isEng);
        },
        child: Text((_isEng ? 'EN' : 'VN'))
    );
  }
}