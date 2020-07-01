import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/utils/pref_utils.dart';

class ArticleContentTopBar extends StatefulWidget {
  final Article article;
  ArticleContentTopBar(this.article);

  @override
  _ArticleContentTopBarState createState() => _ArticleContentTopBarState();
}

class _ArticleContentTopBarState extends State<ArticleContentTopBar> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        // gradient: LinearGradient(
        //     begin: Alignment.bottomCenter,
        //     end: Alignment.topCenter,
        //     colors: [
        //       Theme.of(context).bottomAppBarColor,
        //       Colors.lightBlueAccent,
        //     ]),
        color: Theme.of(context).backgroundColor,
        //border: Border.(width: 0, color: Theme.of(context).textTheme.bodyText2.color),
        border: Border(
          bottom: BorderSide(
              width: 0, color: Theme.of(context).textTheme.bodyText2.color),
        ),
      ),
      height: 22 * screenHeight / 360,
      width: screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 4 * screenHeight / 360),
                  child: Icon(
                    CupertinoIcons.back,
                    size: 17 * screenHeight / 360,
                  ))),
          Expanded(child: Container()),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.article.isBookMarked = !widget.article.isBookMarked;
                _bookMarkArticle(widget.article);
              });
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 0, 4 * screenWidth / 360, 4 * screenHeight / 360),
              child: Icon(
                widget.article.isBookMarked
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                size: 17 * screenHeight / 360,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _bookMarkArticle(Article article) async {
    List<String> currentSaveArticlePref =
        await PrefUtils.getSavedArticlesPref();
    for (var item in currentSaveArticlePref)
      if (int.tryParse(item.split('~').elementAt(0)) == article.id) return;
    String articleString =
        "${article.id.toString()}~${article.title}~${article.firstImage}~${article.description}~${article.location}~${article.time}";
    currentSaveArticlePref.add(articleString);
    PrefUtils.setSavedArticlesPref(currentSaveArticlePref);
  }
}

// class ArticleContentBottomBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Container(
//       height: 20 * screenHeight / 360,
//       width: screenWidth,
//       color: Colors.grey,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Expanded(
//             child: GestureDetector(
//               onTap: () {},
//               child: Icon(Icons.text_fields),
//             ),
//           ),
//           Expanded(
//             child: GestureDetector(
//               onTap: () {},
//               child: Icon(Icons.text_fields),
//             ),
//           ),
//           Expanded(
//             child: GestureDetector(
//               onTap: () {},
//               child: Icon(Icons.text_fields),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
