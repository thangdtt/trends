import 'package:equatable/equatable.dart';

class Music extends Equatable {
  final int id;
  final String name;
  final String country;
  final String link;
  final String image;
  final String singer;
  final String composer;
  final String album;
  final String releaseYear;

  Music({
    this.id,
    this.name,
    this.album,
    this.country,
    this.link,
    this.image,
    this.singer,
    this.composer,
    this.releaseYear,
  });

  factory Music.fromJson(json) {
    return Music(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      link: json['link'],
      image: json['image'],
      singer: json['singer'],
      composer: json['composer'],
      album: json['album'],
      releaseYear: json['release_year'],
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        album,
        country,
        link,
        singer,
        composer,
        releaseYear,
      ];
}
