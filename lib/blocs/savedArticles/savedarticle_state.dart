part of 'savedarticle_bloc.dart';

abstract class SavedArticleState extends Equatable {
  const SavedArticleState();
}

class SavedArticleInitial extends SavedArticleState {
  @override
  List<Object> get props => [];
}

class SavedArticleLoading extends SavedArticleState {
  const SavedArticleLoading();
  @override
  List<Object> get props => [];
}

class SavedArticleLoaded extends SavedArticleState {
  final List<Article> articles;
  const SavedArticleLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}

class SavedArticleError extends SavedArticleState {
  final String message;
  const SavedArticleError(this.message);
  @override
  List<Object> get props => [message];
}
