import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/data/moor_database.dart';
import 'package:trends/utils/global_repo.dart';

part 'savedArticle_event.dart';
part 'savedArticle_state.dart';

class SavedArticleBloc extends Bloc<SavedArticleEvent, SavedArticleState> {
  @override
  SavedArticleState get initialState => SavedArticleInitial();
  List<Article> saveArticles = [];

  @override
  Stream<SavedArticleState> mapEventToState(
    SavedArticleEvent event,
  ) async* {
    if (event is GetAllSaveArticle) {
      yield SavedArticleLoading();
      try {
        List<SavedArticleData> _list = await databaseRepo.getAllSaveArticles();

        if (_list != null) {
          saveArticles = [];
          for (var item in _list) {
            saveArticles.add(new Article(
                link: item.link,
                source: item.source,
                id: item.id,
                title: item.title,
                description: item.description,
                category: item.category,
                author: item.author,
                location: item.location,
                time: item.time,
                firstImage: item.firstImage));
          }
        }

        yield SavedArticleLoaded(saveArticles.reversed.toList());
      } catch (e) {
        print(e);
        yield SavedArticleError("get saved article error");
      }
    } else if (event is AddSaveArticle) {
      yield SavedArticleLoading();
      try {
        SavedArticleData saveArticle;
        saveArticle = new SavedArticleData(
            source: event.article.source,
            link: event.article.link,
            id: event.article.id,
            title: event.article.title,
            category: event.article.category,
            description: event.article.description,
            time: event.article.time,
            author: event.article.author,
            location: event.article.location,
            firstImage: event.article.firstImage,
            addTime: DateTime.now());

        try {
          await databaseRepo.inserSaveArticle(saveArticle);

          List<SavedArticleData> _list =
              await databaseRepo.getAllSaveArticles();

          if (_list != null) {
            saveArticles = [];
            for (var item in _list) {
              saveArticles.add(new Article(
                  source: item.source,
                  link: item.link,
                  id: item.id,
                  title: item.title,
                  description: item.description,
                  category: item.category,
                  author: item.author,
                  location: item.location,
                  time: item.time,
                  firstImage: item.firstImage));
            }
          }
        } catch (e) {
          print(e);
          yield SavedArticleLoaded(saveArticles.reversed.toList());
        }

        yield SavedArticleLoaded(saveArticles.reversed.toList());
      } catch (e) {
        print(e);
        yield SavedArticleError("add saved article error");
      }
    } else if (event is DeleteSaveArticle) {
      yield SavedArticleLoading();
      try {
        SavedArticleData saveArticle;
        saveArticle = new SavedArticleData(
            source: event.article.source,
            link: event.article.link,
            id: event.article.id,
            title: event.article.title,
            category: event.article.category,
            description: event.article.description,
            time: event.article.time,
            author: event.article.author,
            location: event.article.location,
            firstImage: event.article.firstImage,
            addTime: DateTime.now());

        if (await databaseRepo.deleteSaveArticle(saveArticle) != null) {
          saveArticles.removeWhere((element) => element.id == event.article.id);
        }

        yield SavedArticleLoaded(saveArticles.reversed.toList());
      } catch (e) {
        print(e);
        yield SavedArticleError("delete saved article error");
      }
    }
  }
}
