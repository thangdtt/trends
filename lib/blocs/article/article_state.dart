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
  final List<Article> articles;
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
