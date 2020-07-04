import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trends/data/models/article.dart';

//String articleUrl = ('http://127.0.0.1:5000/article/');
//int idDifference = 1;
//int idDifference = 10;

class SearchArticleRepository {
  String articleUrl = ('http://server294.azurewebsites.net/articles/');
  List<Article> _searchArticles = [];
  Future<List<Article>> searchArticle(String query) async {
    String url = articleUrl + "search/?info=$query";

    http.Response response;

    try {
      response = await http.get(url);
    } on SocketException catch (_) {
      return [];
    }

    _searchArticles = [];

    if (response.statusCode == 200) {
      List<dynamic> decoded = json.decode(response.body);

      for (int i = 0; i < decoded.length; i++) {
        _searchArticles.add(Article.fromJson(decoded[i]));
        print(Article.fromJson(decoded[i]).title);
      }

      return _searchArticles;
    } else {
      throw Exception('Failed to connect to server');
    }
  }
}
