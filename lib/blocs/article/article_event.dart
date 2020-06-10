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

class RefreshArticles extends ArticleEvent {
  final int categoryIndex;
  const RefreshArticles(this.categoryIndex);

  @override
  List<Object> get props => [categoryIndex];
}

class LoadMoreArticles extends ArticleEvent {
  final int categoryIndex;
  const LoadMoreArticles(this.categoryIndex);

  @override
  List<Object> get props => [categoryIndex];
}
