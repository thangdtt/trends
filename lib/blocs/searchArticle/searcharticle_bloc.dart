import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/utils/global_repo.dart';

part 'searcharticle_event.dart';
part 'searcharticle_state.dart';

class SearcharticleBloc extends Bloc<SearchArticleEvent, SearchArticleState> {

  @override
  SearchArticleState get initialState => SearcharticleInitial();

  @override
  Stream<SearchArticleState> mapEventToState(
    SearchArticleEvent event,
  ) async* {
    if (event is StartToSearchArticle) {
      yield SearchArticleLoading();
      try {
        List<Article> list = await searchRepo.searchArticle(event.query);
        if (list == null && list.isEmpty) list = [];
        yield SearchArticleLoaded(list);
      } on Error {
        yield SearchArticleError("Search error");
      }
    }
  }
}
