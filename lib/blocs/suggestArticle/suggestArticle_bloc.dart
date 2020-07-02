import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:trends/data/models/article.dart';
import 'package:trends/utils/global_repo.dart';
import 'package:trends/utils/utils_class.dart';

part 'suggestArticle_event.dart';
part 'suggestArticle_state.dart';

class SuggestArticleBloc
    extends Bloc<SuggestArticleEvent, SuggestArticleState> {
  @override
  SuggestArticleState get initialState => SuggestArticleInitial();

  @override
  Stream<SuggestArticleState> mapEventToState(
    SuggestArticleEvent event,
  ) async* {
    yield SuggestArticleLoading();
    if (event is FetchSuggestArticles) {
      try {
        Random rnd = new Random();
        randomListItem(List lst) => lst[rnd.nextInt(lst.length)];
        List<Article> articles =
            new List<Article>.from(articleRepo.mapArticles[event.category]);
        if (articles.isEmpty) {
          await articleRepo.getNewArticles(event.category);
          articles =
              new List<Article>.from(articleRepo.mapArticles[event.category]);
        }
        articles.shuffle(rnd);
        int max = articles.length;
        List<Article> result = [];
        result.add(randomListItem(articles.sublist(0, (max / 3).round())));
        result.add(randomListItem(
            articles.sublist((max / 3).round(), (2 * max / 3).round())));
        result
            .add(randomListItem(articles.sublist((2 * max / 3).round(), max)));

        yield SuggestArticleLoaded(result);
      } on Error {
        yield SuggestArticleError("Error !!!");
      }
    }
  }
}
