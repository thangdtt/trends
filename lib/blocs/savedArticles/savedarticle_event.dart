part of 'savedarticle_bloc.dart';

abstract class SavedArticleEvent extends Equatable {
  const SavedArticleEvent();
}

class GetSavedArticles extends SavedArticleEvent {
  GetSavedArticles();

  @override
  List<Object> get props => [];
}

class DeleteSavedArticle extends SavedArticleEvent {
  final int id;
  DeleteSavedArticle(this.id);

  @override
  List<Object> get props => [id];
}

