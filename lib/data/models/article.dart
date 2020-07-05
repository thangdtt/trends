import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final int id;
  final String title;
  final String category;
  final String time;
  final String location;
  final String description;
  final String author;
  final String link;
  final String source;
  bool isBookMarked;
  String firstImage;
  final List<ArticleContent> content;
  //String image;

  Article({
    this.id,
    this.title,
    this.category,
    this.time,
    this.location,
    this.description,
    this.author,
    this.content,
    this.link,
    this.source,
    this.isBookMarked = false,
    this.firstImage = "",
  }) {
    if (content != null) {
      for (var item in content) {
        if (item.type == "image") firstImage = item.info;
      }
    }
  }

  factory Article.fromJson(json) {
    var list = json['content'] as List;
    List<ArticleContent> content =
        list.map((i) => ArticleContent.fromJson(i)).toList();

    String link = json['link'].toString();
    String source = "";
    if (link.contains("vnexpress.net"))
      source = "VnExpress";
    else if (link.contains("tuoitre.vn")) source = "Tuổi trẻ";

    return Article(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      time: json['time'],
      location: json['location'],
      description: json['description'],
      author: json['author'],
      link: json['link'].toString(),
      source: source,
      content: content,
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        category,
        time,
        location,
        description,
        author,
        link,
        source,
        content,
        isBookMarked,
      ];

  // String get firstImage {
  //   if(content == null) return "";
  //   for (var item in content) {
  //     if (item.type == "image") return item.info;
  //   }
  //   return "";
  // }
}

class ArticleContent extends Equatable {
  final String info;
  final String type;

  ArticleContent({this.info, this.type});

  factory ArticleContent.fromJson(Map<String, dynamic> json) {
    return ArticleContent(info: json['info'], type: json['type']);
  }

  @override
  List<Object> get props => [
        info,
        type,
      ];
}
