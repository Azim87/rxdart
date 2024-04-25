import 'dart:convert';

import 'package:flutter_rxdart/posts.dart';
import 'package:http/http.dart' as http;

class PostsService {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Posts>> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((posts) => Posts.fromJson(posts)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
