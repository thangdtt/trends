import 'package:flutter/material.dart';

import 'package:trends/data/models/article.dart';

class ArticleContentWidget extends StatelessWidget {
  static const routeName = '/article-content';

  @override
  Widget build(BuildContext context) {
    final Article article = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        child: Text(
                          article.location,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.purple),
                        ),
                        alignment: Alignment.bottomLeft,
                      ),
                      fit: FlexFit.tight,
                      flex: 3,
                    ),
                    Flexible(
                      child: Container(
                        child: Text(
                          article.time,
                          style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey),
                        ),
                        alignment: Alignment.bottomRight,
                      ),
                      flex: 7,
                      fit: FlexFit.tight,
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    child: SizedBox(
                      child: Text(
                        article.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    child: Text(
                        article.description,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                  ),
                ),
                buildContentWidget(article.content, context),
                Container(
                  child: Text(
                    article.author,
                    style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment(1.0, 0.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContentWidget(
      List<ArticleContent> content, BuildContext context) {
    var list = List<Widget>();
    for (var item in content) {
      if (item.type == "text")
        list.add(Container(
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: SelectableText(
            item.info,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ));
      else if (item.type == "image")
        list.add(Container(
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: Image.network(
            item.info,
            fit: BoxFit.cover,
          ),
        ));
      else
        list.add(Container(
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
          child: SelectableText(
            item.info,
            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 14),
          ),
        ));
    }
    return Column(
      children: list,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
