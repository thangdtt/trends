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

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName("SavedMusicData")
class MusicToSaveTable extends Table {
  @override
  String get tableName => 'musicToSave';

  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get country => text().nullable()();
  TextColumn get link => text()();
  TextColumn get image => text().nullable()();
  TextColumn get composer => text().nullable()();
  TextColumn get album => text().nullable()();
  TextColumn get releaseYear => text().nullable()();

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
      select(articleToSaveTable).get();

  Stream<List<SavedArticleData>> watchAllSaveArticles() =>
      select(articleToSaveTable).watch();

  Future<SavedArticleData> getOneSaveArticle(int id) =>
      (select(articleToSaveTable)..where((t) => t._id.equals(id))).getSingle();

  Future inserSaveArticle(SavedArticleData data) =>
      into(articleToSaveTable).insert(data);

  Future updateSaveArticle(SavedArticleData data) =>
      update(articleToSaveTable).replace(data);

  Future deleteSaveArticle(SavedArticleData data) =>
      delete(articleToSaveTable).delete(data);
}

// @UseMoor(tables: [ArticleToSaveTable, MusicToSaveTable])
// class AppDatabase extends _$AppDatabase {
//   AppDatabase()
//       : super(FlutterQueryExecutor.inDatabaseFolder(
//             path: 'db.sqlite', logStatements: true));

//   @override
//   int get schemaVersion => 1;

//   Future<List<ArticleToSaveTableData>> getAllSaveArticles() => select(savedArticleTable).get();

//   Stream<List<ArticleToSaveTableData>> watchAllSaveArticles() => select(savedArticleTable).watch();

//   Future inserSaveArticle(ArticleToSaveTableData data) => into(savedArticleTable).insert(data);

//   Future updateSaveArticle(ArticleToSaveTableData data) => update(savedArticleTable).replace(data);

//   Future deleteSaveArticle(ArticleToSaveTableData data) => delete(savedArticleTable).delete(data);
// }
