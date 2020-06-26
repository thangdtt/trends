part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
}

class FetchArticles extends ArticleEvent {
  const FetchArticles();

  @override
  List<Object> get props => [];
}

class RefreshArticles extends ArticleEvent {
  const RefreshArticles();

  @override
  List<Object> get props => [];
}

class LoadMoreArticles extends ArticleEvent {
  const LoadMoreArticles();

  @override
  List<Object> get props => [];
}
