part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
}

class AddToHistory extends HistoryEvent {
  final int id;
  AddToHistory(this.id);

  @override
  List<Object> get props => [id];
}

class GetHistoryArticles extends HistoryEvent {
  @override
  List<Object> get props => [];
}

class ClearAllHistory extends HistoryEvent {
  @override
  List<Object> get props => [];
}
