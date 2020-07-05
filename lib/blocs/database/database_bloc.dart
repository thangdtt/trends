import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/data/moor_database.dart';
import 'package:trends/utils/global_repo.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  @override
  DatabaseState get initialState => DatabaseInitial();
  List<Article> saveArticles = [];

  @override
  Stream<DatabaseState> mapEventToState(
    DatabaseEvent event,
  ) async* {
    if (event is GetAllSaveArticle) {
      yield DatabaseLoading();
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

        yield DatabaseLoaded(saveArticles.reversed.toList());
      } catch (e) {
        print(e);
        yield DatabaseError("get saved article error");
      }
    } else if (event is AddSaveArticle) {
      yield DatabaseLoading();
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
          yield DatabaseLoaded(saveArticles.reversed.toList());
        }

        yield DatabaseLoaded(saveArticles.reversed.toList());
      } catch (e) {
        print(e);
        yield DatabaseError("add saved article error");
      }
    } else if (event is DeleteSaveArticle) {
      yield DatabaseLoading();
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

        yield DatabaseLoaded(saveArticles.reversed.toList());
      } catch (e) {
        print(e);
        yield DatabaseError("delete saved article error");
      }
    }
  }
}
