import 'package:equatable/equatable.dart';

class Article extends Equatable {

  final String imagePath;
  final String url;
  final DateTime date;
  final String id;
  final String title;
  final String snippet;
  final String source;

  Article(
      {this.imagePath,
      this.url,
      this.date,
      this.id,
      this.title,
      this.snippet,
      this.source});

  factory Article.fromJson(json) {
    return Article(
        imagePath: json['image'],
        url: json['url'],
        date: json['date'],
        id: json['id'],
        title: json['title'],
        snippet: json['snippet'],
        source: json['source']);
  }

  @override
  List<Object> get props => [
        imagePath,
        url,
        date,
        id,
        title,
        snippet,
        source,
      ];
}
