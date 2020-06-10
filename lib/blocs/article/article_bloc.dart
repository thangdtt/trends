import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/data/article_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
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
      try {
        final listArticles =
            await articleRepo.refreshArticles(event.categoryIndex);
        yield ArticleRefreshed(listArticles);
      } on Error {
        yield ArticleError("Error !!!");
      }
    } else if (event is LoadMoreArticles) {
      try {
        final listArticles =
            await articleRepo.fetchNextArticles(event.categoryIndex);
        yield ArticleLoadMore(listArticles);
      } on Error {
        yield ArticleError("Error !!!");
      }
    } else {
      yield ArticleLoading();
      if (event is FetchArticles) {
        try {
          final listArticles =
              await articleRepo.fetchArticles(event.categoryIndex);
          yield ArticleLoaded(listArticles, event.categoryIndex);
        } on Error {
          yield ArticleError("Error !!!");
        }
      }
    }
  }
}
