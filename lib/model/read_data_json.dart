import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JsonListView extends StatefulWidget {
  const JsonListView({super.key});

  @override
  _JsonListViewState createState() => _JsonListViewState();
}

class _JsonListViewState extends State<JsonListView> {
  List items = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final String response = await rootBundle.loadString('data/data.json');
    final data = await json.decode(response);
    setState(() {
      items = data["words"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Index: ${items[index]["index"]}'),
        );
      },
    );
  }
}