import 'package:flutter/material.dart';

class GrammarScreen extends StatefulWidget {
  const GrammarScreen({Key? key}) : super(key: key);

  @override
  _GrammarScreenState createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {
  final TextEditingController _query = TextEditingController();

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
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _query,
              decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Bo tròn viền
                ),
              ),
            ),
          ],
          )
      ),
    );
  }
}