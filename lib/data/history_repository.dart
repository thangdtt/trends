import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trends/data/models/article.dart';
import 'package:trends/utils/pref_utils.dart';

class HistoryRepository {
  String _articleUrl = ('http://server294.azurewebsites.net/article/');
  List<Article> historyArticle = [];
  //List<DateTime> timeList = [];
  Future<Article> getHistory(int id) async {
    String url = _articleUrl + "?id=$id";

    http.Response response;

    try {
      response = await http.get(url);
    } on SocketException catch (_) {
      return null;
    }

    if (response.statusCode == 200) {
      dynamic decoded = json.decode(response.body);
      return Article.fromJson(decoded);
    } else {
      throw Exception('Failed to connect to server');
    }
  }

  Future<List<Article>> getAllHistory() async {
    historyArticle = [];
    //timeList = [];
    List<String> historyList = await PrefUtils.getHistoryPref();
    List<int> idList = [];

    for (int i = 0; i < historyList.length; i++) {
      List<String> splitted = historyList[i].split('~');
      idList.add(int.parse(splitted[0]));

      Article article = await getHistory(idList[i]);
      if (article != null) {
        historyArticle.add(article);
        //timeList.add(DateTime.parse(splitted[1]));
      }
    }
    return historyArticle;
  }

  Future<bool> addHistory(String id) async {
    List<String> historyList = await PrefUtils.getHistoryPref();
    //List<int> idList = [];
    //List<DateTime> currentTimeList = [];

    for (int i = 0; i < historyList.length; i++) {
      //final splitted = historyList[i].split('~');
      //if (id == splitted[0]) return false;
      //idList.add(int.parse(splitted[0]));
      //currentTimeList[i] = DateTime.parse(splitted[1]);
      if (id == historyList[i]) return false;
    }

    //Max history is 30
    if (historyList.length >= 15) historyList.removeAt(0);

    //historyList.add("$id~${DateTime.now()}");
    historyList.add(id);

    await PrefUtils.setHistoryPref(historyList);

    return true;
  }

  Future clearHistory() async {
    historyArticle = [];
    //timeList = [];
    PrefUtils.setHistoryPref([]);
  }
}
