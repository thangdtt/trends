import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/data/article_repository.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository article_repo;
  ArticleBloc(this.article_repo);

  @override
  ArticleState get initialState => ArticleInitial();

  @override
  Stream<ArticleState> mapEventToState(
    ArticleEvent event,
  ) async* {
    yield ArticleLoading();
    if (event is GetRealTimeArticle) {
      try {
        final articles = await article_repo.fetchRealtimeArticle(event.categoryId);
        yield ArticleLoaded(articles);
      } on Error {
        yield ArticleError("Error !!!");
      }
    } else if (event is GetDailyArticle) {
      try {
        final articles = await article_repo.fetchDailyArticle();
      } on Error {
        yield ArticleError("Error !!!");
      }
    }
  }
}
