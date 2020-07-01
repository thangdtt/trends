// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class SavedArticleData extends DataClass
    implements Insertable<SavedArticleData> {
  final int id;
  final String title;
  final String category;
  final String time;
  final String location;
  final String description;
  final String author;
  final String firstImage;
  SavedArticleData(
      {@required this.id,
      @required this.title,
      @required this.category,
      @required this.time,
      this.location,
      @required this.description,
      this.author,
      @required this.firstImage});
  factory SavedArticleData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return SavedArticleData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      category: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      time: stringType.mapFromDatabaseResponse(data['${effectivePrefix}time']),
      location: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}location']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      author:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}author']),
      firstImage: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}first_image']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<String>(time);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || firstImage != null) {
      map['first_image'] = Variable<String>(firstImage);
    }
    return map;
  }

  ArticleToSaveTableCompanion toCompanion(bool nullToAbsent) {
    return ArticleToSaveTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      firstImage: firstImage == null && nullToAbsent
          ? const Value.absent()
          : Value(firstImage),
    );
  }

  factory SavedArticleData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SavedArticleData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      time: serializer.fromJson<String>(json['time']),
      location: serializer.fromJson<String>(json['location']),
      description: serializer.fromJson<String>(json['description']),
      author: serializer.fromJson<String>(json['author']),
      firstImage: serializer.fromJson<String>(json['firstImage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'time': serializer.toJson<String>(time),
      'location': serializer.toJson<String>(location),
      'description': serializer.toJson<String>(description),
      'author': serializer.toJson<String>(author),
      'firstImage': serializer.toJson<String>(firstImage),
    };
  }

  SavedArticleData copyWith(
          {int id,
          String title,
          String category,
          String time,
          String location,
          String description,
          String author,
          String firstImage}) =>
      SavedArticleData(
        id: id ?? this.id,
        title: title ?? this.title,
        category: category ?? this.category,
        time: time ?? this.time,
        location: location ?? this.location,
        description: description ?? this.description,
        author: author ?? this.author,
        firstImage: firstImage ?? this.firstImage,
      );
  @override
  String toString() {
    return (StringBuffer('SavedArticleData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('time: $time, ')
          ..write('location: $location, ')
          ..write('description: $description, ')
          ..write('author: $author, ')
          ..write('firstImage: $firstImage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              category.hashCode,
              $mrjc(
                  time.hashCode,
                  $mrjc(
                      location.hashCode,
                      $mrjc(description.hashCode,
                          $mrjc(author.hashCode, firstImage.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SavedArticleData &&
          other.id == this.id &&
          other.title == this.title &&
          other.category == this.category &&
          other.time == this.time &&
          other.location == this.location &&
          other.description == this.description &&
          other.author == this.author &&
          other.firstImage == this.firstImage);
}

class ArticleToSaveTableCompanion extends UpdateCompanion<SavedArticleData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> category;
  final Value<String> time;
  final Value<String> location;
  final Value<String> description;
  final Value<String> author;
  final Value<String> firstImage;
  const ArticleToSaveTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.time = const Value.absent(),
    this.location = const Value.absent(),
    this.description = const Value.absent(),
    this.author = const Value.absent(),
    this.firstImage = const Value.absent(),
  });
  ArticleToSaveTableCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    @required String category,
    @required String time,
    this.location = const Value.absent(),
    @required String description,
    this.author = const Value.absent(),
    @required String firstImage,
  })  : title = Value(title),
        category = Value(category),
        time = Value(time),
        description = Value(description),
        firstImage = Value(firstImage);
  static Insertable<SavedArticleData> custom({
    Expression<int> id,
    Expression<String> title,
    Expression<String> category,
    Expression<String> time,
    Expression<String> location,
    Expression<String> description,
    Expression<String> author,
    Expression<String> firstImage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (time != null) 'time': time,
      if (location != null) 'location': location,
      if (description != null) 'description': description,
      if (author != null) 'author': author,
      if (firstImage != null) 'first_image': firstImage,
    });
  }

  ArticleToSaveTableCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<String> category,
      Value<String> time,
      Value<String> location,
      Value<String> description,
      Value<String> author,
      Value<String> firstImage}) {
    return ArticleToSaveTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      time: time ?? this.time,
      location: location ?? this.location,
      description: description ?? this.description,
      author: author ?? this.author,
      firstImage: firstImage ?? this.firstImage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (firstImage.present) {
      map['first_image'] = Variable<String>(firstImage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticleToSaveTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('time: $time, ')
          ..write('location: $location, ')
          ..write('description: $description, ')
          ..write('author: $author, ')
          ..write('firstImage: $firstImage')
          ..write(')'))
        .toString();
  }
}

class $ArticleToSaveTableTable extends ArticleToSaveTable
    with TableInfo<$ArticleToSaveTableTable, SavedArticleData> {
  final GeneratedDatabase _db;
  final String _alias;
  $ArticleToSaveTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  GeneratedTextColumn _category;
  @override
  GeneratedTextColumn get category => _category ??= _constructCategory();
  GeneratedTextColumn _constructCategory() {
    return GeneratedTextColumn(
      'category',
      $tableName,
      false,
    );
  }

  final VerificationMeta _timeMeta = const VerificationMeta('time');
  GeneratedTextColumn _time;
  @override
  GeneratedTextColumn get time => _time ??= _constructTime();
  GeneratedTextColumn _constructTime() {
    return GeneratedTextColumn(
      'time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _locationMeta = const VerificationMeta('location');
  GeneratedTextColumn _location;
  @override
  GeneratedTextColumn get location => _location ??= _constructLocation();
  GeneratedTextColumn _constructLocation() {
    return GeneratedTextColumn(
      'location',
      $tableName,
      true,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _authorMeta = const VerificationMeta('author');
  GeneratedTextColumn _author;
  @override
  GeneratedTextColumn get author => _author ??= _constructAuthor();
  GeneratedTextColumn _constructAuthor() {
    return GeneratedTextColumn(
      'author',
      $tableName,
      true,
    );
  }

  final VerificationMeta _firstImageMeta = const VerificationMeta('firstImage');
  GeneratedTextColumn _firstImage;
  @override
  GeneratedTextColumn get firstImage => _firstImage ??= _constructFirstImage();
  GeneratedTextColumn _constructFirstImage() {
    return GeneratedTextColumn(
      'first_image',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, category, time, location, description, author, firstImage];
  @override
  $ArticleToSaveTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'articleToSave';
  @override
  final String actualTableName = 'articleToSave';
  @override
  VerificationContext validateIntegrity(Insertable<SavedArticleData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category'], _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time'], _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location'], _locationMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author'], _authorMeta));
    }
    if (data.containsKey('first_image')) {
      context.handle(
          _firstImageMeta,
          firstImage.isAcceptableOrUnknown(
              data['first_image'], _firstImageMeta));
    } else if (isInserting) {
      context.missing(_firstImageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedArticleData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SavedArticleData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ArticleToSaveTableTable createAlias(String alias) {
    return $ArticleToSaveTableTable(_db, alias);
  }
}

class SavedMusicData extends DataClass implements Insertable<SavedMusicData> {
  final int id;
  final String name;
  final String country;
  final String link;
  final String image;
  final String composer;
  final String album;
  final String releaseYear;
  SavedMusicData(
      {@required this.id,
      @required this.name,
      this.country,
      @required this.link,
      this.image,
      this.composer,
      this.album,
      this.releaseYear});
  factory SavedMusicData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return SavedMusicData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      country:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}country']),
      link: stringType.mapFromDatabaseResponse(data['${effectivePrefix}link']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
      composer: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}composer']),
      album:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}album']),
      releaseYear: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}release_year']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || composer != null) {
      map['composer'] = Variable<String>(composer);
    }
    if (!nullToAbsent || album != null) {
      map['album'] = Variable<String>(album);
    }
    if (!nullToAbsent || releaseYear != null) {
      map['release_year'] = Variable<String>(releaseYear);
    }
    return map;
  }

  MusicToSaveTableCompanion toCompanion(bool nullToAbsent) {
    return MusicToSaveTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      composer: composer == null && nullToAbsent
          ? const Value.absent()
          : Value(composer),
      album:
          album == null && nullToAbsent ? const Value.absent() : Value(album),
      releaseYear: releaseYear == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseYear),
    );
  }

  factory SavedMusicData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SavedMusicData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      country: serializer.fromJson<String>(json['country']),
      link: serializer.fromJson<String>(json['link']),
      image: serializer.fromJson<String>(json['image']),
      composer: serializer.fromJson<String>(json['composer']),
      album: serializer.fromJson<String>(json['album']),
      releaseYear: serializer.fromJson<String>(json['releaseYear']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'country': serializer.toJson<String>(country),
      'link': serializer.toJson<String>(link),
      'image': serializer.toJson<String>(image),
      'composer': serializer.toJson<String>(composer),
      'album': serializer.toJson<String>(album),
      'releaseYear': serializer.toJson<String>(releaseYear),
    };
  }

  SavedMusicData copyWith(
          {int id,
          String name,
          String country,
          String link,
          String image,
          String composer,
          String album,
          String releaseYear}) =>
      SavedMusicData(
        id: id ?? this.id,
        name: name ?? this.name,
        country: country ?? this.country,
        link: link ?? this.link,
        image: image ?? this.image,
        composer: composer ?? this.composer,
        album: album ?? this.album,
        releaseYear: releaseYear ?? this.releaseYear,
      );
  @override
  String toString() {
    return (StringBuffer('SavedMusicData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('country: $country, ')
          ..write('link: $link, ')
          ..write('image: $image, ')
          ..write('composer: $composer, ')
          ..write('album: $album, ')
          ..write('releaseYear: $releaseYear')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              country.hashCode,
              $mrjc(
                  link.hashCode,
                  $mrjc(
                      image.hashCode,
                      $mrjc(composer.hashCode,
                          $mrjc(album.hashCode, releaseYear.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SavedMusicData &&
          other.id == this.id &&
          other.name == this.name &&
          other.country == this.country &&
          other.link == this.link &&
          other.image == this.image &&
          other.composer == this.composer &&
          other.album == this.album &&
          other.releaseYear == this.releaseYear);
}

class MusicToSaveTableCompanion extends UpdateCompanion<SavedMusicData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> country;
  final Value<String> link;
  final Value<String> image;
  final Value<String> composer;
  final Value<String> album;
  final Value<String> releaseYear;
  const MusicToSaveTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.country = const Value.absent(),
    this.link = const Value.absent(),
    this.image = const Value.absent(),
    this.composer = const Value.absent(),
    this.album = const Value.absent(),
    this.releaseYear = const Value.absent(),
  });
  MusicToSaveTableCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.country = const Value.absent(),
    @required String link,
    this.image = const Value.absent(),
    this.composer = const Value.absent(),
    this.album = const Value.absent(),
    this.releaseYear = const Value.absent(),
  })  : name = Value(name),
        link = Value(link);
  static Insertable<SavedMusicData> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> country,
    Expression<String> link,
    Expression<String> image,
    Expression<String> composer,
    Expression<String> album,
    Expression<String> releaseYear,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (country != null) 'country': country,
      if (link != null) 'link': link,
      if (image != null) 'image': image,
      if (composer != null) 'composer': composer,
      if (album != null) 'album': album,
      if (releaseYear != null) 'release_year': releaseYear,
    });
  }

  MusicToSaveTableCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> country,
      Value<String> link,
      Value<String> image,
      Value<String> composer,
      Value<String> album,
      Value<String> releaseYear}) {
    return MusicToSaveTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      link: link ?? this.link,
      image: image ?? this.image,
      composer: composer ?? this.composer,
      album: album ?? this.album,
      releaseYear: releaseYear ?? this.releaseYear,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (composer.present) {
      map['composer'] = Variable<String>(composer.value);
    }
    if (album.present) {
      map['album'] = Variable<String>(album.value);
    }
    if (releaseYear.present) {
      map['release_year'] = Variable<String>(releaseYear.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MusicToSaveTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('country: $country, ')
          ..write('link: $link, ')
          ..write('image: $image, ')
          ..write('composer: $composer, ')
          ..write('album: $album, ')
          ..write('releaseYear: $releaseYear')
          ..write(')'))
        .toString();
  }
}

class $MusicToSaveTableTable extends MusicToSaveTable
    with TableInfo<$MusicToSaveTableTable, SavedMusicData> {
  final GeneratedDatabase _db;
  final String _alias;
  $MusicToSaveTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _countryMeta = const VerificationMeta('country');
  GeneratedTextColumn _country;
  @override
  GeneratedTextColumn get country => _country ??= _constructCountry();
  GeneratedTextColumn _constructCountry() {
    return GeneratedTextColumn(
      'country',
      $tableName,
      true,
    );
  }

  final VerificationMeta _linkMeta = const VerificationMeta('link');
  GeneratedTextColumn _link;
  @override
  GeneratedTextColumn get link => _link ??= _constructLink();
  GeneratedTextColumn _constructLink() {
    return GeneratedTextColumn(
      'link',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      true,
    );
  }

  final VerificationMeta _composerMeta = const VerificationMeta('composer');
  GeneratedTextColumn _composer;
  @override
  GeneratedTextColumn get composer => _composer ??= _constructComposer();
  GeneratedTextColumn _constructComposer() {
    return GeneratedTextColumn(
      'composer',
      $tableName,
      true,
    );
  }

  final VerificationMeta _albumMeta = const VerificationMeta('album');
  GeneratedTextColumn _album;
  @override
  GeneratedTextColumn get album => _album ??= _constructAlbum();
  GeneratedTextColumn _constructAlbum() {
    return GeneratedTextColumn(
      'album',
      $tableName,
      true,
    );
  }

  final VerificationMeta _releaseYearMeta =
      const VerificationMeta('releaseYear');
  GeneratedTextColumn _releaseYear;
  @override
  GeneratedTextColumn get releaseYear =>
      _releaseYear ??= _constructReleaseYear();
  GeneratedTextColumn _constructReleaseYear() {
    return GeneratedTextColumn(
      'release_year',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, country, link, image, composer, album, releaseYear];
  @override
  $MusicToSaveTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'musicToSave';
  @override
  final String actualTableName = 'musicToSave';
  @override
  VerificationContext validateIntegrity(Insertable<SavedMusicData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country'], _countryMeta));
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link'], _linkMeta));
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image'], _imageMeta));
    }
    if (data.containsKey('composer')) {
      context.handle(_composerMeta,
          composer.isAcceptableOrUnknown(data['composer'], _composerMeta));
    }
    if (data.containsKey('album')) {
      context.handle(
          _albumMeta, album.isAcceptableOrUnknown(data['album'], _albumMeta));
    }
    if (data.containsKey('release_year')) {
      context.handle(
          _releaseYearMeta,
          releaseYear.isAcceptableOrUnknown(
              data['release_year'], _releaseYearMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedMusicData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SavedMusicData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MusicToSaveTableTable createAlias(String alias) {
    return $MusicToSaveTableTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ArticleToSaveTableTable _articleToSaveTable;
  $ArticleToSaveTableTable get articleToSaveTable =>
      _articleToSaveTable ??= $ArticleToSaveTableTable(this);
  $MusicToSaveTableTable _musicToSaveTable;
  $MusicToSaveTableTable get musicToSaveTable =>
      _musicToSaveTable ??= $MusicToSaveTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [articleToSaveTable, musicToSaveTable];
}
