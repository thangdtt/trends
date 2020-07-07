import 'dart:io';

import 'package:moor_ffi/moor_ffi.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'moor_database.g.dart';

@DataClassName("SavedArticleData")
class ArticleToSaveTable extends Table {
  @override
  String get tableName => 'articleToSave';

  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get category => text()();
  TextColumn get time => text()();
  TextColumn get location => text().nullable()();
  TextColumn get description => text()();
  TextColumn get author => text().nullable()();
  TextColumn get firstImage => text()();
  TextColumn get link => text().nullable()();
  TextColumn get source => text().nullable()();
  DateTimeColumn get addTime => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName("SavedMusicData")
class MusicToSaveTable extends Table {
  @override
  String get tableName => 'musicToSave';

  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get singer => text()();
  TextColumn get country => text().nullable()();
  TextColumn get link => text()();
  TextColumn get image => text().nullable()();
  TextColumn get composer => text().nullable()();
  TextColumn get album => text().nullable()();
  TextColumn get releaseYear => text().nullable()();
  DateTimeColumn get addTime => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [ArticleToSaveTable, MusicToSaveTable])
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  AppDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

  Future<List<SavedArticleData>> getAllSaveArticles() =>
      (select(articleToSaveTable)
            ..orderBy([(article) => OrderingTerm(expression: article.addTime)]))
          .get();

  Future<SavedArticleData> getOneSaveArticle(int id) =>
      (select(articleToSaveTable)..where((t) => t._id.equals(id))).getSingle();

  Future inserSaveArticle(SavedArticleData data) =>
      into(articleToSaveTable).insertOnConflictUpdate(data);

  Future updateSaveArticle(SavedArticleData data) =>
      update(articleToSaveTable).replace(data);

  Future deleteSaveArticle(SavedArticleData data) =>
      delete(articleToSaveTable).delete(data);

  //MUSIC
  Future<List<SavedMusicData>> getAllSaveMusic() => (select(musicToSaveTable)
        ..orderBy([(music) => OrderingTerm(expression: music.addTime)]))
      .get();

  Future<SavedMusicData> getOneSaveMusic(int id) =>
      (select(musicToSaveTable)..where((t) => t._id.equals(id))).getSingle();

  Future insertSaveMusic(SavedMusicData data) =>
      into(musicToSaveTable).insertOnConflictUpdate(data);

  Future updateSaveMusic(SavedMusicData data) =>
      update(musicToSaveTable).replace(data);

  Future deleteSaveMusic(SavedMusicData data) =>
      delete(musicToSaveTable).delete(data);
}
