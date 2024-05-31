import 'package:flutter/material.dart';
import 'api_service.dart';
import '../../models/dictionary_model.dart';

class SearchPage extends SearchDelegate {
  DictionaryModel dictionary = DictionaryModel();

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
    return FutureBuilder<bool>(
      future: _getData(context),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Future<bool> _getData(BuildContext context) async {
    APIService dictionaryAPI = APIService();

    if (query.isNotEmpty) {
      final List<dynamic> data = await dictionaryAPI.requestAPI(query);
      if (data.isNotEmpty) {
        dictionary.loadData(data[0]);
      }
      else {
        dictionary.resetData();
      }
    }
    close(context, null);
    return true;
  }
}