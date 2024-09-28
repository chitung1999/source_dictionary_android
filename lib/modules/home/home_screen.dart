import 'package:flutter/material.dart';
import '../../common/change_data.dart';
import '../../common/search_bar.dart';
import '../../models/database.dart';
import 'list_page.dart';
import 'search_result.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dictionary', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
        flexibleSpace: database.configApp.banner,
        actions: [
          if(!_isSelected)
            SearchBarApp(
              onTyping: (String str) {
                database.wordModel.query.textTyping = str;
                database.wordModel.search();
                setState(() {});
              },
            ),
          SizedBox(width: 10),
          if(!_isSelected) Builder(
            builder: (context) {
              return Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.black),
                  onPressed: () async {
                    await showDialog(context: context, builder: (BuildContext context) {
                      return ChangeData(
                        isHome: true,
                        isAddNew: true,
                        onSuccess: () {
                          database.wordModel.search();
                          setState(() {});
                        }
                      );
                    });
                  }
                ),
              );
            }
          ),
          SizedBox(width: 20)
        ]
      ),
      body: Stack(
        children: [
          ListPage(onSelect: () {setState(() {_isSelected = true;});}),
          if(_isSelected) Positioned(child: SearchResult(onBack: () {setState(() {_isSelected = false;});}))
        ],
      ),
    );
  }
}