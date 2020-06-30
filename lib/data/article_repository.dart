import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trends/data/models/article.dart';
import 'package:trends/utils/utils_class.dart';

// int idDifference = 10;
// String articleUrl = ('http://127.0.0.1:5000/articles/');
String articleUrl = ('http://server294.azurewebsites.net/articles/'); //Azure

class ArticleRepository {
  Map<categoryEnum, List<Article>> _articles = {
    categoryEnum.TinNong: [],
    categoryEnum.TinMoi: [],
    categoryEnum.ThoiSu: [],
    categoryEnum.TheGioi: [],
    categoryEnum.KinhDoanh: [],
    categoryEnum.GiaiTri: [],
    categoryEnum.TheThao: [],
    categoryEnum.PhapLuat: [],
    categoryEnum.GiaoDuc: [],
    categoryEnum.SucKhoe: [],
    categoryEnum.DoiSong: [],
    categoryEnum.DuLich: [],
    categoryEnum.KhoaHoc: [],
    categoryEnum.SoHoa: [],
    categoryEnum.Xe: [],
  };

  Map<categoryEnum, int> mapOffset = {
    categoryEnum.TinNong: 0,
    categoryEnum.TinMoi: 0,
    categoryEnum.ThoiSu: 0,
    categoryEnum.TheGioi: 0,
    categoryEnum.KinhDoanh: 0,
    categoryEnum.GiaiTri: 0,
    categoryEnum.TheThao: 0,
    categoryEnum.PhapLuat: 0,
    categoryEnum.GiaoDuc: 0,
    categoryEnum.SucKhoe: 0,
    categoryEnum.DoiSong: 0,
    categoryEnum.DuLich: 0,
    categoryEnum.KhoaHoc: 0,
    categoryEnum.SoHoa: 0,
    categoryEnum.Xe: 0,
  };

  Map<categoryEnum, String> enumToString = {
    categoryEnum.TinNong: "",
    categoryEnum.TinMoi: "",
    categoryEnum.ThoiSu: "thoi_su",
    categoryEnum.TheGioi: "the_gioi",
    categoryEnum.KinhDoanh: "kinh_doanh",
    categoryEnum.GiaiTri: "giai_tri",
    categoryEnum.TheThao: "the_thao",
    categoryEnum.PhapLuat: "phap_luat",
    categoryEnum.GiaoDuc: "giao_duc",
    categoryEnum.SucKhoe: "suc_khoe",
    categoryEnum.DoiSong: "oi_song",
    categoryEnum.DuLich: "du_lich",
    categoryEnum.KhoaHoc: "khoa_hoc",
    categoryEnum.SoHoa: "so_hoa",
    categoryEnum.Xe: "xe",
  };

  List<Article> _searchArticles = [];

  Map<categoryEnum, List<Article>> get mapArticles => _articles;

  Future<Map<categoryEnum, List<Article>>> getNewArticles(
      categoryEnum category) async {
    String url;
    if (category == categoryEnum.TinNong)
      url = articleUrl + "hot/?offset=0";
    else if (category == categoryEnum.TinMoi)
      url = articleUrl + "new/?offset=0";
    else {
      String categoryString = enumToString[category];
      url = articleUrl + "?cat=$categoryString&offset=0";
    }
    print(url);

    http.Response response;
    try {
      response = await http.get(url);
    } on SocketException catch (_) {
      clearArticles(category);
      return _articles;
    }

    clearArticles(category);

    if (response.statusCode == 200) {
      List<dynamic> decoded = json.decode(response.body);

      for (int i = 0; i < decoded.length; i++) {
        _articles[category].add(Article.fromJson(decoded[i]));
      }

      mapOffset[category]++;
      return _articles;
    } else {
      throw Exception('Failed to connect to server');
    }
  }

  Future<Map<categoryEnum, List<Article>>> loadMoreArticles(
      categoryEnum category, int offset) async {
    String url;
    if (category == categoryEnum.TinNong)
      url = articleUrl + "hot/?offset=$offset";
    else if (category == categoryEnum.TinMoi)
      url = articleUrl + "new/?offset=$offset";
    else {
      String categoryString = enumToString[category];
      url = articleUrl + "?cat=$categoryString&offset=$offset";
    }

    http.Response response;

    try {
      response = await http.get(url);
    } on SocketException catch (_) {
      return _articles;
    }

    if (response.statusCode == 200) {
      List<dynamic> decoded = json.decode(response.body);

      for (int i = 0; i < decoded.length; i++) {
        _articles[category].add(Article.fromJson(decoded[i]));
        print(Article.fromJson(decoded[i]).title);
      }

      mapOffset[category]++;
      return _articles;
    } else {
      throw Exception('Failed to connect to server');
    }
  }

  Future<List<Article>> searchArticle(String query) async {
    String url = articleUrl + "search/info=$query";

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

  void clearArticles(categoryEnum category) {
    _articles[category] = [];
    mapOffset[category] = 0;
  }
}
