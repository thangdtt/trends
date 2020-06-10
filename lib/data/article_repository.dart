import 'package:trends/api/api.dart';
import 'package:trends/data/models/article.dart';

class ArticleRepository {
  List<List<Article>> _listArticles;

  Map<String, List<String>> _mapArticleId;

  Map<String, List<Article>> _mapArticleInfo;

  Map<String, int> _mapCurrentArticlesIndex;

  List<String> tabNames;

  final int numberFetch = 15;

  ArticleRepository() {
    tabNames = List<String>();
    tabNames.add('b');
    tabNames.add('e');
    tabNames.add('m');
    tabNames.add('t');
    tabNames.add('s');
    tabNames.add('h');

    _mapArticleId = Map<String, List<String>>();
    _mapArticleInfo = Map<String, List<Article>>();
    _mapCurrentArticlesIndex = Map<String, int>();
    _listArticles = new List<List<Article>>();

    for (int i = 0; i < tabNames.length; i++) {
      _mapArticleInfo.putIfAbsent(tabNames[i], () => List());
      _mapArticleId.putIfAbsent(tabNames[i], () => List());
      _mapCurrentArticlesIndex.putIfAbsent(tabNames[i], () => 0);
      _listArticles.add(new List());
    }
  }

  Future<List<List<Article>>> fetchArticles(int indexCategory) async {
    String category = tabNames[indexCategory];

    if (_mapArticleId[category].length == 0) {
      _mapArticleId[category] = await NewsApi.getArticlesId(category);
      int endIndex = _mapCurrentArticlesIndex[category] + numberFetch;
      int startIndex = 0;

      if (endIndex > _mapArticleId[category].length - 1) {
        endIndex = _mapArticleId[category].length - 1;
      }
      if (startIndex == endIndex) {
        return [[]];
      }
      _mapArticleInfo[category] = await NewsApi.getTrendArticles(
          _mapArticleId[category].sublist(startIndex, endIndex), category);

      _mapCurrentArticlesIndex[category] = endIndex;

      _listArticles[indexCategory] = _mapArticleInfo[category];
    }
    return _listArticles;
  }

  Future<List<List<Article>>> refreshArticles(int indexCategory) {
    String category = tabNames[indexCategory];
    _mapArticleId[category].clear();
    _mapCurrentArticlesIndex[category] = 0;
    return fetchArticles(indexCategory);
  }

   Future<List<List<Article>>> fetchNextArticles(int indexCategory) async {
    String category = tabNames[indexCategory];
    int startIndex = _mapCurrentArticlesIndex[category];
    int endIndex = _mapCurrentArticlesIndex[category] + numberFetch;
    if (startIndex >= _mapArticleId[category].length - 1) {
      return _listArticles;
    }

    startIndex += 1;

    //fix endIdex when end of articles list
    if (endIndex > _mapArticleId[category].length - 1) {
      endIndex = _mapArticleId[category].length - 1;
    }

    if (startIndex == endIndex) {
      return _listArticles;
    }

    List<Article> articles = await NewsApi.getTrendArticles(
        _mapArticleId[category].sublist(startIndex, endIndex), category);

    _mapArticleInfo[category].addAll(articles);
    _listArticles[indexCategory].addAll(articles);

    _mapCurrentArticlesIndex[category] = endIndex;
    
    return _listArticles;
  }
}
