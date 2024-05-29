import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../models/word_model.dart';

class SearchResult extends StatefulWidget {

  const SearchResult({Key? key}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  @override
  Widget build(BuildContext context) {
    return const Text('KKK');
    // return Container(
    //   padding: const EdgeInsets.all(20.0),
    //   child: ListView.builder(
    //     itemCount: resultSearch.length,
    //     itemBuilder: (context, index) {return Column( children: [
    //       Container(
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(12.0),
    //           border: Border.all(width: 2, color: Colors.blueGrey)
    //         ),
    //         padding: const EdgeInsets.all(10.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Text(
    //                   _listSearch[0],
    //                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
    //                 ),
    //                 const Row( children: [
    //                   IconButton(onPressed: null, icon: Icon(Icons.playlist_add)),
    //                   IconButton(onPressed: null, icon: Icon(Icons.playlist_add)),
    //                 ])
    //               ]
    //             ),
    //             Text(
    //               '• words: ${widget.data!.data[resultSearch[index]].keys}',
    //               style: const TextStyle(fontSize: 20)
    //             ),
    //             Text(
    //               '• means: ${widget.data!.data[resultSearch[index]].means}',
    //               style: const TextStyle(fontSize: 20)
    //             ),
    //             Text(
    //               '• note: ${widgetdata!.data[resultSearch[index]].note}',
    //               style: const TextStyle(fontSize: 20)
    //             ),
    //           ],
    //         ),
    //       ),
    //       const SizedBox(height: 20)
    //     ],);}
    //   )
    // );
  }
}