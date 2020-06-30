part of 'searcharticle_bloc.dart';

abstract class SearchArticleState extends Equatable {
  const SearchArticleState();
}

class SearcharticleInitial extends SearchArticleState {
  @override
  List<Object> get props => [];
}

class SearchArticleLoading extends SearchArticleState {
  const SearchArticleLoading();
  @override
  List<Object> get props => [];
}

class SearchArticleLoaded extends SearchArticleState {
  final List<Article> articles;
  const SearchArticleLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}

class SearchArticleError extends SearchArticleState {
  final String message;
  const SearchArticleError(this.message);
  @override
  List<Object> get props => [message];
}