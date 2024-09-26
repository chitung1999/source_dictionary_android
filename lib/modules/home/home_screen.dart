import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'list_page.dart';
import 'search_result.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.isSearching, required this.onSelect, required this.onChangedLanguage}) : super(key: key);

  final bool isSearching;
  final Function() onSelect;
  final Function() onChangedLanguage;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.isSearching ? ListPage(onSelect: widget.onSelect, onChangedLanguage: widget.onChangedLanguage) : SearchResult();
  }
}