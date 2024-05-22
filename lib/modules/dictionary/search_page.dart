import 'package:flutter/material.dart';
import 'api_service.dart';
import 'dictionary_item.dart';
import 'search_result.dart';

class SearchPage extends SearchDelegate {
  final APIService _dictionaryAPI = APIService();
  DictionaryItem? _item;

  Future<void> _getData() async {
    if (query.isNotEmpty) {
      final List<dynamic> data = await _dictionaryAPI.requestAPI(query);
      if (data.isNotEmpty) {
        _item = DictionaryItem.fromJson(data[0]);
        query = '';
      }
    }
  }

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
    return FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ResultDictionary(item: _item);
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}