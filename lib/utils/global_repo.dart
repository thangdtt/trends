import 'package:trends/data/article_repository.dart';
import 'package:trends/data/moor_database.dart';
import 'package:trends/data/searchArticle_repository.dart';
import 'package:trends/data/history_repository.dart';


ArticleRepository articleRepo = new ArticleRepository();
AppDatabase databaseRepo = new AppDatabase();
SearchArticleRepository searchRepo = new SearchArticleRepository();
HistoryRepository historyRepo = new HistoryRepository();