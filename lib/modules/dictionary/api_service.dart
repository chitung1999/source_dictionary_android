import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static const String apiUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en/';

  Future<List> requestAPI(String word) async {
    final response = await http.get(Uri.parse('$apiUrl$word'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data. Status Code: ${response.statusCode}');
    }
  }
}