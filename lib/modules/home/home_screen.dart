import 'package:flutter/material.dart';
import 'add_dialog.dart';
import 'search_page.dart';
import 'list_page.dart';
import 'search_result.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isShowList = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: const Text('Dictionary', style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
            actions: [
              IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    showDialog(context: context, builder: (BuildContext context) {
                      return const AddDialog();
                    });
                  }
              ),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () async {
                  await showSearch (
                    context: context,
                    delegate: SearchPage()
                  );
                  setState(() {_isShowList = false;});
                }
              ),
              IconButton(
                icon: const Icon(Icons.list, color: Colors.white),
                onPressed: () {
                  setState(() { _isShowList = true; });
                },
              )
            ]
        ),
        body: _isShowList ? ListPage() : SearchResult(),
        //body: _isShowList ? ListPage() : SearchResult()
    );
  }
}