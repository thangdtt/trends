import 'package:equatable/equatable.dart';

class Music extends Equatable {
  final int id;
  final String name;
  final String country;
  String link;
  final String image;
  final String singer;
  final String composer;
  final String album;
  final String releaseYear;
  final List<String> qualities;
  final List<String> qualityLink;

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
    this.qualities,
    this.qualityLink,
  });

  factory Music.fromJson(json) {
    List<String> qualities = List();
    List<String> qualityLink = List();

    try {
      if (json['qualities'] != null) {
        (json['qualities'] as List<dynamic>).forEach((element) {
          qualities.add(element['quality']);
          qualityLink.add(element['link']);
        });
      }
    } catch (e) {
      print(e);
    }

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
      qualities: qualities,
      qualityLink: qualityLink,
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
        qualities,
        qualityLink,
      ];
}
