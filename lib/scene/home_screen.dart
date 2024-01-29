import 'package:flutter/material.dart';
import 'package:source_dictionary_mobile/component/home/add_data.dart';
import 'package:source_dictionary_mobile/component/home/search_data.dart';
import 'package:source_dictionary_mobile/component/home/list_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.blueGrey,
      title: const Text(
        'Dictionary',
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddData();
              },
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            showSearch(
              context: context,
              delegate: SearchData(),
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.format_list_bulleted,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const ListData();
              },
            );
          },
        ),
        const SizedBox(width: 10),
      ],
    ));
  }
}
