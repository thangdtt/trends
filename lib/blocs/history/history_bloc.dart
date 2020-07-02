import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/utils/global_repo.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  @override
  HistoryState get initialState => HistoryInitial();

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    if (event is GetHistoryArticles) {
      yield HistoryLoading();
      try {
        List<Article> articles = await historyRepo.getAllHistory();
        yield HistoryLoaded(
            articles: articles.reversed.toList());
      } catch (e) {
        print(e.toString());
        yield HistoryError(e.toString());
      }
    } else if (event is AddToHistory) {
      yield HistoryLoading();
      try {
        await historyRepo.addHistory(event.id.toString());

        List<Article> articles = await historyRepo.getAllHistory();
        yield HistoryLoaded(
            articles: articles.reversed.toList());
      } catch (e) {
        yield HistoryError(e.toString());
      }
    } else if (event is ClearAllHistory) {
      yield HistoryLoading();
      try {
        await historyRepo.clearHistory();

        yield HistoryLoaded(articles: []);
      } catch (e) {
        yield HistoryError(e);
      }
    }
  }
}
