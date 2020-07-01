import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/data/moor_database.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  AppDatabase database;
  DatabaseBloc() {
    database = new AppDatabase();
  }
  @override
  DatabaseState get initialState => DatabaseInitial();

  @override
  Stream<DatabaseState> mapEventToState(
    DatabaseEvent event,
  ) async* {
    if (event is GetAllSaveArticle) {
      yield DatabaseLoading();
      try {
        List<SavedArticleData> _list = await database.getAllSaveArticles();

        List<Article> _saveArticles = [];
        for (var item in _list) {
          _saveArticles.add(new Article(
              id: item.id,
              title: item.title,
              description: item.description,
              category: item.category,
              author: item.author,
              location: item.location,
              time: item.time,
              firstImage: item.firstImage));
        }
        yield DatabaseLoaded(_saveArticles);
      } catch (e) {
        print(e);
        yield DatabaseError("get saved article error");
      }
    } else if (event is AddSaveArticle) {
      yield DatabaseLoading();
      try {
        SavedArticleData saveArticle;
        saveArticle = new SavedArticleData(
            id: event.article.id,
            title: event.article.title,
            category: event.article.category,
            description: event.article.description,
            time: event.article.time,
            author: event.article.author,
            location: event.article.location,
            firstImage: event.article.firstImage);

        database.inserSaveArticle(saveArticle);

        List<SavedArticleData> _list = await database.getAllSaveArticles();
        List<Article> _saveArticles = [];
        for (var item in _list) {
          _saveArticles.add(new Article(
              id: item.id,
              title: item.title,
              description: item.description,
              category: item.category,
              author: item.author,
              location: item.location,
              time: item.time,
              firstImage: item.firstImage));
        }

        yield DatabaseLoaded(_saveArticles);
      } catch (e) {
        print(e);
        yield DatabaseError("add saved article error");
      }
    } else if (event is DeleteSaveArticle) {
      yield DatabaseLoading();
      try {
        SavedArticleData saveArticle;
        saveArticle = new SavedArticleData(
            id: event.article.id,
            title: event.article.title,
            category: event.article.category,
            description: event.article.description,
            time: event.article.time,
            author: event.article.author,
            location: event.article.location,
            firstImage: event.article.firstImage);
        database.deleteSaveArticle(saveArticle);

        List<SavedArticleData> _list = await database.getAllSaveArticles();
        List<Article> _saveArticles = [];
        for (var item in _list) {
          _saveArticles.add(new Article(
              id: item.id,
              title: item.title,
              description: item.description,
              category: item.category,
              author: item.author,
              location: item.location,
              time: item.time,
              firstImage: item.firstImage));
        }

        yield DatabaseLoaded(_saveArticles);
      } catch (e) {
        print(e);
        yield DatabaseError("delete saved article error");
      }
    }
  }
}
