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
  final List<List<Article>> articles;
  final int tabIndex;
  const ArticleLoaded(this.articles, this.tabIndex);

  @override
  List<Object> get props => [articles, tabIndex];
}

class ArticleError extends ArticleState {
  final String message;
  const ArticleError(this.message);
  @override
  List<Object> get props => [message];
}

class ArticleRefreshed extends ArticleState {
  final List<List<Article>> articles;
  const ArticleRefreshed(this.articles);

  @override
  List<Object> get props => [articles];
}

class ArticleLoadMore extends ArticleState {
  final List<List<Article>> articles;
  const ArticleLoadMore(this.articles);

  @override
  List<Object> get props => [articles];
}
