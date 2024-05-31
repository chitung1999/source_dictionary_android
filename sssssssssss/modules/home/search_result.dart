import 'package:flutter/material.dart';
import 'search_page.dart';
import '../../../models/word_model.dart';

class SearchResult extends StatefulWidget {
  final WordModel? data;
  final SearchConfig? config;
  const SearchResult({Key? key, required this.data, required this.config}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  @override
  Widget build(BuildContext context) {
    if(widget.config!.group.isEmpty) {
      return const Center(
        child: Text(
            'No words found!',
            style: TextStyle(fontSize: 20)
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: widget.config!.group.length,
        itemBuilder: (context, index) {return Column( children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(width: 2, color: Colors.blueGrey)
            ),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        widget.config!.word,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                    ),
                    const Row( children: [
                      IconButton(onPressed: null, icon: Icon(Icons.playlist_add)),
                      IconButton(onPressed: null, icon: Icon(Icons.playlist_add)),
                    ])
                  ]
                ),
                Text(
                  '• words: ${widget.data!.data[widget.config!.group[index]].keys}',
                  style: const TextStyle(fontSize: 20)
                ),
                Text(
                  '• means: ${widget.data!.data[widget.config!.group[index]].means}',
                  style: const TextStyle(fontSize: 20)
                ),
                Text(
                  '• note: ${widget.data!.data[widget.config!.group[index]].note}',
                  style: const TextStyle(fontSize: 20)
                ),
              ],
            ),
          ),
          const SizedBox(height: 20)
        ],);}
      )
    );
  }
}