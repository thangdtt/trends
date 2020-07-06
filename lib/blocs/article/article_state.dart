part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();
}

class ArticleInitial extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleLoading extends ArticleState {
  const ArticleLoading();
  @override
  List<Object> get props => [];
}

class ArticleLoaded extends ArticleState {
  final Map<CategoryEnum, List<Article>> articles;
  const ArticleLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}

class ArticleError extends ArticleState {
  final String message;
  const ArticleError(this.message);
  @override
  List<Object> get props => [message];
}

class ArticleRefreshing extends ArticleState {
  const ArticleRefreshing();

  @override
  List<Object> get props => [];
}

class ArticleRefreshed extends ArticleState {
  final Map<CategoryEnum, List<Article>> articles;
  const ArticleRefreshed(this.articles);

  @override
  List<Object> get props => [articles];
}

class ArticleLoadingMore extends ArticleState {
  const ArticleLoadingMore();

  @override
  List<Object> get props => [];
}

class ArticleLoadMore extends ArticleState {
  final Map<CategoryEnum, List<Article>> articles;
  const ArticleLoadMore(this.articles);

  @override
  List<Object> get props => [articles];
}