import 'package:trends/api/api.dart';
import 'package:trends/data/models/article.dart';
import 'package:rxdart/rxdart.dart';

class ArticleRepository {
  Map<String, List<String>> _mapArticleIdType;

  Map<String, List<Article>> _mapArticleInfoType;

  Map<String, int> _mapCurrentArticlesIndex;

  static List<String> tabNames;

  static final int numberFetch = 15;

  ArticleRepository() {
    tabNames = List<String>();
    tabNames.add('b');
    tabNames.add('e');
    tabNames.add('m');
    tabNames.add('t');
    tabNames.add('s');
    tabNames.add('h');

    _mapArticleIdType = Map<String, List<String>>();
    _mapArticleInfoType = Map<String, List<Article>>();
    _mapCurrentArticlesIndex = Map<String, int>();

    for (int i = 0; i < tabNames.length; i++) {
      _mapArticleInfoType.putIfAbsent(tabNames[i], () => List());
      _mapArticleIdType.putIfAbsent(tabNames[i], () => List());
      _mapCurrentArticlesIndex.putIfAbsent(tabNames[i], () => 0);
    }
  }

  Future<List<Article>> fetchNextArticles(int indexCategory) async {
    String category = tabNames[indexCategory];
    int startIndex = _mapCurrentArticlesIndex[category];
    int endIndex = _mapCurrentArticlesIndex[category] + numberFetch;
    if (startIndex >= _mapArticleIdType[category].length - 1) {
      return  _mapArticleInfoType[category];
    }

    startIndex += 1;

    if (endIndex > _mapArticleIdType[category].length - 1) {
      endIndex = _mapArticleIdType[category].length - 1;
    }

    if (startIndex == endIndex) {
      return  _mapArticleInfoType[category];
    }

    List<Article> articles = await NewsApi.getTrendArticles(
        _mapArticleIdType[category].sublist(startIndex, endIndex), category);

    _mapArticleInfoType[category].addAll(articles);

    _mapCurrentArticlesIndex[category] = endIndex;
    return _mapArticleInfoType[category];
  }

  Future<List<Article>> fetchArticles(int indexCategory) async {
    String category = tabNames[indexCategory];

    if (_mapArticleIdType[category].length == 0) {
      _mapArticleIdType[category] = await NewsApi.getArticlesId(category);
      int endIndex = _mapCurrentArticlesIndex[category] + numberFetch;
      int startIndex = 0;

      if (endIndex > _mapArticleIdType[category].length - 1) {
        endIndex = _mapArticleIdType[category].length - 1;
      }
      if (startIndex == endIndex) {
        return [];
      }
      _mapArticleInfoType[category] = await NewsApi.getTrendArticles(
          _mapArticleIdType[category].sublist(startIndex, endIndex), category);

      _mapCurrentArticlesIndex[category] = endIndex;

      return _mapArticleInfoType[category];
    }
    return _mapArticleInfoType[category];
  }
}
