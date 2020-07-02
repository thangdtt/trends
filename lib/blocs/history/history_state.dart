part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoading extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoaded extends HistoryState {
  final List<Article> articles;
  final List<DateTime> times;
  HistoryLoaded({this.articles, this.times});
  @override
  List<Object> get props => [];
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);
  @override
  List<Object> get props => [];
}
