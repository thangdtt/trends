import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/data/article_repository.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
   ArticleRepository articleRepo;
  ArticleBloc(){
    articleRepo = new ArticleRepository();
  }

  @override
  ArticleState get initialState => ArticleInitial();

  @override
  Stream<ArticleState> mapEventToState(
    ArticleEvent event,
  ) async* {
    yield ArticleLoading();
    if (event is FetchArticles) {
      try {
        final articles = await articleRepo.fetchArticles(event.categoryIndex);
        yield ArticleLoaded(articles);
      } on Error {
        yield ArticleError("Error !!!");
      }
      // } else if (event is FetchArticles) {
      //   try {
      //     final articles = await article_repo.fetchArticles(index);
      //   } on Error {
      //     yield ArticleError("Error !!!");
      //   }
    }
  }
}
