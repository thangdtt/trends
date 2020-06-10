import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sprintf/sprintf.dart';
import 'package:trends/api/Constants.dart';
import 'package:trends/data/models/article.dart';

class NewsApi {
  static Future<List<Article>> getTrendArticles(
      List<String> ids, String category) async {
    //combine all id to parameter
    String formatIDs = "";
    for (int i = 0; i < ids.length; i++) {
      formatIDs += "id=" + ids[i] + "&";
    }
    //print(formatIDs);

    //remove last "&"
    formatIDs = formatIDs.substring(0, formatIDs.length - 1);

    String url =
        sprintf(Constants.TRENDING_SUMMARY_URL, ["vi-VN", category, formatIDs]);
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String result = response.body.substring(4, response.body.length);
      Map<String, dynamic> decoded = json.decode(result);
      List<Article> articles = [];
      for (int i = 0; i < decoded['trendingStories'].length; i++) {
        articles.add(Article.fromJson(decoded['trendingStories'][i]));
      }
      return articles;
    } else {
      throw Exception('Failed to connect to server');
    }
  }

  static Future<List<String>> getArticlesId(String category) async {
    String url = sprintf(Constants.GOOGLE_TREND_URL, ["vi-VN", category, "VN"]);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String result = response.body.substring(4, response.body.length);
      Map<String, dynamic> decoded = json.decode(result);
      List<String> ids = [];
      for (int i = 0; i < decoded['trendingStoryIds'].length; i++) {
        ids.add(decoded['trendingStoryIds'][i]);
      }
      return ids;
    } else {
      throw Exception('Failed to connect to server');
    }
  }
}
