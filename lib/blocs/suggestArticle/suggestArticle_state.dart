part of 'suggestArticle_bloc.dart';

abstract class SuggestArticleState extends Equatable {
  const SuggestArticleState();
}

class SuggestArticleInitial extends SuggestArticleState {
  @override
  List<Object> get props => [];
}

class SuggestArticleLoading extends SuggestArticleState {
  const SuggestArticleLoading();
  @override
  List<Object> get props => [];
}

class SuggestArticleLoaded extends SuggestArticleState {
  final List<Article> articles;
  const SuggestArticleLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}

class SuggestArticleError extends SuggestArticleState {
  final String message;
  const SuggestArticleError(this.message);
  @override
  List<Object> get props => [message];
}