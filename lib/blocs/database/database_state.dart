part of 'database_bloc.dart';

abstract class DatabaseState extends Equatable {
  const DatabaseState();
}

class DatabaseInitial extends DatabaseState {
  @override
  List<Object> get props => [];
}

class DatabaseLoading extends DatabaseState {
  @override
  List<Object> get props => [];
}

class DatabaseLoaded extends DatabaseState {
  final List<Article> savedArticles;

  DatabaseLoaded(this.savedArticles);

  @override
  List<Object> get props => [];
}

class DatabaseError extends DatabaseState {
  final String message;

  DatabaseError(this.message);
  @override
  List<Object> get props => [message];
}
