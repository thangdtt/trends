part of 'savedArticle_bloc.dart';

abstract class SavedArticleEvent extends Equatable {
  const SavedArticleEvent();
}

class GetAllSaveArticle extends SavedArticleEvent {

  @override
  List<Object> get props => [];
}

class AddSaveArticle extends SavedArticleEvent {
  final Article article;
  AddSaveArticle(this.article);

  @override
  List<Object> get props => [article];
}

class DeleteSaveArticle extends SavedArticleEvent {
  final Article article;
  DeleteSaveArticle(this.article);

  @override
  List<Object> get props => [article];
}
