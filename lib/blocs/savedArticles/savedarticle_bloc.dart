import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/data/saveArticle_repository.dart';
import 'package:trends/utils/pref_utils.dart';

part 'savedarticle_event.dart';
part 'savedarticle_state.dart';

class SavedArticleBloc extends Bloc<SavedArticleEvent, SavedArticleState> {
  SavedArticleRepository savedRepo;
  SavedArticleBloc() {
    savedRepo = new SavedArticleRepository();
  }

  @override
  SavedArticleState get initialState => SavedArticleInitial();

  @override
  Stream<SavedArticleState> mapEventToState(
    SavedArticleEvent event,
  ) async* {
    if (event is GetSavedArticles) {
      yield SavedArticleLoading();

      try {
        List<String> savedArticles = await PrefUtils.getSavedArticlesPref();
        List<int> idList = new List();
        for (var item in savedArticles)
          idList.add(int.tryParse(item.split('~').elementAt(0)));

        List<Article> _saveArticleList =
            await savedRepo.getAllSavedArticles(idList.reversed.toList());

        yield SavedArticleLoaded(_saveArticleList, savedArticles);
      } catch (e) {
        yield SavedArticleError("get saved article error");
      }
    } else if (event is DeleteSavedArticle) {
      try {
        List<String> savedArticles = await PrefUtils.getSavedArticlesPref();
        List<int> idList = new List();
        for (var item in savedArticles)
          idList.add(int.tryParse(item.split('~').elementAt(0)));
        for (int i = 0; i < idList.length; i++) {
          if (idList[i] == event.id) {
            savedArticles.removeAt(i);
            idList.removeAt(i);
            break;
          }
        }
        PrefUtils.setSavedArticlesPref(savedArticles);

        List<Article> _saveArticleList =
            await savedRepo.getAllSavedArticles(idList.reversed.toList());

        yield SavedArticleLoaded(_saveArticleList, savedArticles);
      } catch (e) {
        yield SavedArticleError("delete saved article error");
      }
    }
  }
}
