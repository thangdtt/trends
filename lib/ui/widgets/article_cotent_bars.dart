import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trends/blocs/savedArticles/savedarticle_bloc.dart';
import 'package:trends/data/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/utils/pref_utils.dart';

class ArticleContentTopBar extends StatefulWidget {
  final Article article;
  ArticleContentTopBar(this.article);

  @override
  _ArticleContentTopBarState createState() => _ArticleContentTopBarState();
}

class _ArticleContentTopBarState extends State<ArticleContentTopBar> {
  bool isBookMarked = false;
  List<int> savedIds;
  List<String> savedArticles;
  SavedArticleBloc saveBloc;
  @override
  void initState() {
    super.initState();
    saveBloc = BlocProvider.of(context);
    saveBloc.add(GetSavedArticles());
    savedIds = [];
    savedArticles = [];
    //savedArticles = (saveBloc.state as SavedArticleLoaded).articleCache;
    // PrefUtils.getSavedArticlesPref().then((value) {
    //   for (var item in value) {
    //     savedArticles.add(item);
    //   }
    // });

    // for (var item in savedArticles)
    //   savedIds.add(int.tryParse(item.split('~').elementAt(0)));
    // if (savedIds.indexOf(widget.article.id) < 0)
    //   isBookMarked = false;
    // else
    //   isBookMarked = true;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (saveBloc.state is SavedArticleInitial ||
        saveBloc.state is SavedArticleLoading) {
    } else if (saveBloc.state is SavedArticleLoaded) {
      savedArticles = (saveBloc.state as SavedArticleLoaded).articleCache;
      for (var item in savedArticles)
        savedIds.add(int.tryParse(item.split('~').elementAt(0)));
      for (var id in savedIds) {
        if (id == widget.article.id) {
          setState(() {
            isBookMarked = true;
          });
          break;
        }
      }
    } else
      return Center(child: Text("Xảy ra lỗi ở bookmark"));
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
                _bookMarkArticle();
              });
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 0, 4 * screenWidth / 360, 4 * screenHeight / 360),
              child: Icon(
                isBookMarked ? Icons.bookmark : Icons.bookmark_border,
                size: 17 * screenHeight / 360,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _bookMarkArticle() async {
    isBookMarked = !isBookMarked;
    widget.article.isBookMarked = !isBookMarked;

    int existed = -1;
    for (var item in savedIds) {
      if (item == widget.article.id) {
        existed = item;
        break;
      }
    }

    //Unbookmarked
    if (existed >= 0) {
      //savedArticles.removeAt(savedIds.indexOf(existed));
      //savedIds.removeWhere((element) => element == existed);
      saveBloc.add(DeleteSavedArticle(existed));
      //PrefUtils.setSavedArticlesPref(savedArticles);
      return;
    } else {
      //Set Bookmark
      String articleString =
          "${widget.article.id.toString()}~${widget.article.title}~${widget.article.firstImage}~${widget.article.description}~${widget.article.location}~${widget.article.time}";
      savedArticles.add(articleString);
      savedIds.add(widget.article.id);
      PrefUtils.setSavedArticlesPref(savedArticles);
      saveBloc.add(GetSavedArticles());
    }
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
