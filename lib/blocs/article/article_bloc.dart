import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:trends/data/models/article.dart';
import 'package:trends/data/article_repository.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  bool loading = false;
  ArticleRepository articleRepo;
  ArticleBloc() {
    articleRepo = new ArticleRepository();
  }

  @override
  ArticleState get initialState => ArticleInitial();

  @override
  Stream<Transition<ArticleEvent, ArticleState>> transformEvents(
    Stream<ArticleEvent> events,
    TransitionFunction<ArticleEvent, ArticleState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ArticleState> mapEventToState(
    ArticleEvent event,
  ) async* {
    if (event is RefreshArticles) {
      yield ArticleRefreshing();
      try {
        final listArticles = await articleRepo.getNewArticles();
        yield ArticleRefreshed(listArticles);
      } on Error {
        //yield ArticleError("Error !!!");
        yield state;
      }
    } else if (event is LoadMoreArticles) {
      yield ArticleLoadingMore();
      try {
        final listArticles = await articleRepo.loadMoreArticles();
        yield ArticleLoadMore(listArticles);
      } on Error {
        //yield ArticleError("Error !!!");
        yield state;
      }
    } else {
      yield ArticleLoading();
      if (event is FetchArticles) {
        try {
          final listArticles = await articleRepo.getNewArticles();
          yield ArticleLoaded(listArticles);
        } on Error {
          yield ArticleError("Error !!!");
        }
      }
    }
  }
}
