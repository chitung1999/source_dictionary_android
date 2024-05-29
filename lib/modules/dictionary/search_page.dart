import 'package:flutter/material.dart';
import 'api_service.dart';
import 'dictionary_item.dart';

class SearchPage extends SearchDelegate<DictionaryItem?> {
  DictionaryItem? _item;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () { query = ''; }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () { close(context, null); }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          close(context, _item);
          return Container();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Future<void> _getData() async {
    APIService dictionaryAPI = APIService();

    if (query.isNotEmpty) {
      final List<dynamic> data = await dictionaryAPI.requestAPI(query);
      if (data.isNotEmpty) {
        _item = DictionaryItem.fromJson(data[0]);
        query = '';
      }
    }
  }
}