import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:trends/data/models/article.dart';
import 'package:trends/utils/utils_class.dart';

String articleUrl = ('http://server294.azurewebsites.net/articles/'); //Azure

class ArticleRepository {
  Map<CategoryEnum, List<Article>> _articles = {
    CategoryEnum.TinNong: [],
    CategoryEnum.TinMoi: [],
    CategoryEnum.ThoiSu: [],
    CategoryEnum.TheGioi: [],
    CategoryEnum.KinhDoanh: [],
    CategoryEnum.GiaiTri: [],
    CategoryEnum.TheThao: [],
    CategoryEnum.PhapLuat: [],
    CategoryEnum.NhipSongTre: [],
    CategoryEnum.VanHoa: [],
    CategoryEnum.GiaoDuc: [],
    CategoryEnum.SucKhoe: [],
    CategoryEnum.DoiSong: [],
    CategoryEnum.DuLich: [],
    CategoryEnum.KhoaHoc: [],
    CategoryEnum.SoHoa: [],
    CategoryEnum.Xe: [],
    CategoryEnum.GiaThat: [],
  };

  Map<CategoryEnum, int> mapOffset = {
    CategoryEnum.TinNong: 0,
    CategoryEnum.TinMoi: 0,
    CategoryEnum.ThoiSu: 0,
    CategoryEnum.TheGioi: 0,
    CategoryEnum.KinhDoanh: 0,
    CategoryEnum.GiaiTri: 0,
    CategoryEnum.TheThao: 0,
    CategoryEnum.PhapLuat: 0,
    CategoryEnum.NhipSongTre: 0,
    CategoryEnum.VanHoa: 0,
    CategoryEnum.GiaoDuc: 0,
    CategoryEnum.SucKhoe: 0,
    CategoryEnum.DoiSong: 0,
    CategoryEnum.DuLich: 0,
    CategoryEnum.KhoaHoc: 0,
    CategoryEnum.SoHoa: 0,
    CategoryEnum.Xe: 0,
    CategoryEnum.GiaThat: 0,
  };

  Map<CategoryEnum, String> enumToString = {
    CategoryEnum.TinNong: "",
    CategoryEnum.TinMoi: "",
    CategoryEnum.ThoiSu: "thoi_su",
    CategoryEnum.TheGioi: "the_gioi",
    CategoryEnum.KinhDoanh: "kinh_doanh",
    CategoryEnum.GiaiTri: "giai_tri",
    CategoryEnum.TheThao: "the_thao",
    CategoryEnum.PhapLuat: "phap_luat",
    CategoryEnum.NhipSongTre: "nhip_song_tre",
    CategoryEnum.VanHoa: "van_hoa",
    CategoryEnum.GiaoDuc: "giao_duc",
    CategoryEnum.SucKhoe: "suc_khoe",
    CategoryEnum.DoiSong: "oi_song",
    CategoryEnum.DuLich: "du_lich",
    CategoryEnum.KhoaHoc: "khoa_hoc",
    CategoryEnum.SoHoa: "so_hoa",
    CategoryEnum.Xe: "xe",
    CategoryEnum.GiaThat: "gia - that",
  };

  List<Article> _searchArticles = [];

  Map<CategoryEnum, List<Article>> get mapArticles => _articles;

  Future<Map<CategoryEnum, List<Article>>> getNewArticles(
      CategoryEnum category) async {
    String url;
    if (category == CategoryEnum.TinNong)
      url = articleUrl + "hot/?offset=0";
    else if (category == CategoryEnum.TinMoi)
      url = articleUrl + "new/?offset=0";
    else {
      String categoryString = enumToString[category];
      url = articleUrl + "?cat=$categoryString&offset=0";
    }

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

  Future<Map<CategoryEnum, List<Article>>> loadMoreArticles(
      CategoryEnum category, int offset) async {
    String url;
    if (category == CategoryEnum.TinNong)
      url = articleUrl + "hot/?offset=$offset";
    else if (category == CategoryEnum.TinMoi)
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

  void clearArticles(CategoryEnum category) {
    _articles[category] = [];
    mapOffset[category] = 0;
  }
}
