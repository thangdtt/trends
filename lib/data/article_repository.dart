import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trends/data/models/article.dart';

//String articleUrl = ('http://127.0.0.1:5000/article/');
String articleUrl = ('https://server294.herokuapp.com/article/');

class ArticleRepository {
  List<Article> _articles = [];

  List<Article> get articles => _articles;

  Future<List<Article>> getNewArticles() async {
    String url = articleUrl + "0";

    http.Response response;
    try {
      response = await http.get(url);
    } on SocketException catch (_) {
      return [];
    }

    _articles.clear();

    if (response.statusCode == 200) {
      List<dynamic> decoded = json.decode(response.body);

      for (int i = 0; i < decoded.length; i++) {
        _articles.add(Article.fromJson(decoded[i]));
      }

      return _articles;
    } else {
      throw Exception('Failed to connect to server');
    }
  }

  Future<List<Article>> loadMoreArticles() async {
    String url = articleUrl +
        (_articles.last.id - 10).toString(); //cleardb -10 to get next id

    http.Response response;

    try {
      response = await http.get(url);
    } on SocketException catch (_) {
      return _articles;
    }

    if (response.statusCode == 200) {
      List<dynamic> decoded = json.decode(response.body);

      for (int i = 0; i < decoded.length; i++) {
        _articles.add(Article.fromJson(decoded[i]));
        print(Article.fromJson(decoded[i]).title);
      }

      return _articles;
    } else {
      throw Exception('Failed to connect to server');
    }
  }
}
