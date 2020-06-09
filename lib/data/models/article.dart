import 'package:equatable/equatable.dart';
import 'package:html_unescape/html_unescape.dart';

class Article extends Equatable {
  final String id;
  final String title;
  final String url;
  final String source;
  final String time;
  final String snippet;
  final String image;

  Article(this.id, this.title, this.url, this.source, this.time, this.snippet,
      this.image);

  factory Article.fromJson(json, {int type = 1}) {
    switch (type) {
      case 2:
        String title = json['title'];
        var unescape = new HtmlUnescape();
        title = unescape.convert(title);
        String url = json['url'];
        String source = json['source'];
        String time = json['time'];
        String snippet = json['title'];
        String image = json['imageUrl'];

        if (image != null) {
          image = 'http:' + image;
        } else {
          print(image);
        }
        return Article(json['id'], title, url, source, time, snippet, image);
      case 3:
        String title = json['title'];
        var unescape = new HtmlUnescape();
        title = unescape.convert(title);
        String url = json['url'];
        String source = json['source'];
        String time = json['timeAgo'];
        String snippet = json['title'];
        String image;
        try {
          if (json['image'] != null) {
            image = json['image']['imageUrl'];
          }
        } on Exception {
          image = null;
        }

        return Article(json['id'], title, url, source, time, snippet, image);
      case 1:
      default:
        String title = json['articles'][0]['articleTitle'];
        var unescape = new HtmlUnescape();
        title = unescape.convert(title);
        String url = json['articles'][0]['url'];
        String source = json['articles'][0]['source'];
        String time = json['articles'][0]['time'];
        String snippet = json['articles'][0]['snippet'];
        snippet = unescape.convert(snippet);

        String image = '';
        try {
          image = json['image']['imgUrl'];

          if (image != null) {
            image = 'http:' + image;
          } else {
            print(image);
          }
        } on Exception {
          image = null;
        }
        return Article(json['id'], title, url, source, time, snippet, image);
    }
  }

  @override
  List<Object> get props => [
        id,
        title,
        url,
        source,
        time,
        snippet,
        image,
      ];
}
