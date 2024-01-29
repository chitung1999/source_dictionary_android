import 'package:flutter/material.dart';

class  SearchData extends SearchDelegate {
  List<String> allData = ['hello', 'hi', 'goodbye', 'a', 'b', 'c', 'd', 'e',
    'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'x', 'y', 'z'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Xử lý khi nhấn vào từng item
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> listSearch = [];

    for(var item in allData) {
      if(item.toLowerCase().contains(query.toLowerCase())){
        listSearch.add(item);
      }
    }

    return ListView.builder(
      itemCount: listSearch.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(listSearch[index], style: const TextStyle(fontSize: 20),),
        );
      },
    );
  }
}