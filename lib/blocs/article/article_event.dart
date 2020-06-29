part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
}

class FetchArticles extends ArticleEvent {
  final categoryEnum catEnum;
  FetchArticles(this.catEnum);

  @override
  List<Object> get props => [];
}

class RefreshArticles extends ArticleEvent {
  final categoryEnum catEnum;
  const RefreshArticles(this.catEnum);

  @override
  List<Object> get props => [];
}

class LoadMoreArticles extends ArticleEvent {
  final categoryEnum catEnum;
  const LoadMoreArticles(this.catEnum);

  @override
  List<Object> get props => [];
}
