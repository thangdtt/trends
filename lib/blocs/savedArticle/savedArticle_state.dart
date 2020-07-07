part of 'savedArticle_bloc.dart';

abstract class SavedArticleState extends Equatable {
  const SavedArticleState();
}

class SavedArticleInitial extends SavedArticleState {
  @override
  List<Object> get props => [];
}

class SavedArticleLoading extends SavedArticleState {
  @override
  List<Object> get props => [];
}

class SavedArticleLoaded extends SavedArticleState {
  final List<Article> savedArticles;

  SavedArticleLoaded(this.savedArticles);

  @override
  List<Object> get props => [];
}

class SavedArticleError extends SavedArticleState {
  final String message;

  SavedArticleError(this.message);
  @override
  List<Object> get props => [message];
}
