// import 'dart:convert';
// import 'dart:async';
// import 'dart:io';

// import 'package:http/http.dart' as http;
// import 'package:trends/data/models/article.dart';

// String articleUrl = ('http://server294.azurewebsites.net/article/');

// List<Article> _savedArticles = [];

// class SavedArticleRepository {
//   Future<Article> getSavedArticle(int id) async {
//     String url = articleUrl + "?id=$id";

//     http.Response response;

//     try {
//       response = await http.get(url);
//     } on SocketException catch (_) {
//       return null;
//     }

//     if (response.statusCode == 200) {
//       List<dynamic> decoded = json.decode(response.body);

//       for (int i = 0; i < decoded.length; i++) {
//         _savedArticles.add(Article.fromJson(decoded[i]));
//         print(Article.fromJson(decoded[i]).title);
//       }

//       return _savedArticles.last;
//     } else {
//       throw Exception('Failed to connect to server');
//     }
//   }

//   Future<List<Article>> getAllSavedArticles(List<int> idList) async {
//     for (var id in idList) {
//       Article article = await getSavedArticle(id);
//       if (article != null) _savedArticles.add(article);
//     }

//     if (_savedArticles.isEmpty)
//       return [];
//     else
//       return _savedArticles;
//   }
// }
