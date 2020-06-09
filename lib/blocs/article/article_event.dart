part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
}

class FetchArticles extends ArticleEvent {
  final int categoryIndex;
  const FetchArticles(this.categoryIndex);

  @override
  List<Object> get props => [categoryIndex];
}

class GetRealTimeArticle extends ArticleEvent {
  final String categoryId;
  const GetRealTimeArticle(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
