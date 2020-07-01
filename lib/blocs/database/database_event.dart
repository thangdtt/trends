part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();
}

class GetAllSaveArticle extends DatabaseEvent {

  @override
  List<Object> get props => [];
}

class AddSaveArticle extends DatabaseEvent {
  final Article article;
  AddSaveArticle(this.article);

  @override
  List<Object> get props => [article];
}

class DeleteSaveArticle extends DatabaseEvent {
  final Article article;
  DeleteSaveArticle(this.article);

  @override
  List<Object> get props => [article];
}
