import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/blocs/database/database_bloc.dart';
import 'package:trends/blocs/theme/theme_bloc.dart';

import 'package:trends/data/models/article.dart';

class NewsWidget extends StatelessWidget {
  final GestureTapCallback callback;
  final Article article;
  final String tag;
  final double width;

  const NewsWidget(
      {Key key, this.callback, this.article, this.tag = '', this.width = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);

    return GestureDetector(
      onLongPressStart: (LongPressStartDetails details) {
        final _pos = details.globalPosition;
        showMenu(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            items: <PopupMenuEntry>[
              PopupMenuItem(
                child: GestureDetector(
                  onTap: callback,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.open_in_new),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Mở"),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                child: GestureDetector(
                  onTap: () {
                    _bookmarkArticle(article, context);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.bookmark_border),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Lưu"),
                    ],
                  ),
                ),
              ),
            ],
            context: context,
            //position: buttonMenuPosition(context),
            position: RelativeRect.fromLTRB(
                _pos.dx - 150, _pos.dy - 50, _pos.dy, _pos.dx),
            elevation: 5);
      },
      onTap: callback,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 7 * screenWidth / 360,
              vertical: 3 * screenWidth / 360),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              //border: Border.all(color: Colors.black54, width: 0.5),
            ),
            width: width == 0 ? screenWidth : width,
            height: 130 * screenHeight / 780,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                if (themeBloc.state is ThemeLoaded &&
                    (themeBloc.state as ThemeLoaded).isFastReadMode == false)
                  Expanded(
                    flex: 11,
                    child: Hero(
                      flightShuttleBuilder: (
                        BuildContext flightContext,
                        Animation<double> animation,
                        HeroFlightDirection flightDirection,
                        BuildContext fromHeroContext,
                        BuildContext toHeroContext,
                      ) {
                        final Hero toHero = toHeroContext.widget;
                        return RotationTransition(
                          turns: animation,
                          child: toHero.child,
                        );
                      },
                      child: Container(
                        width: 125 * screenWidth / 360,
                        height: 130 * screenHeight / 780,
                        decoration: article.firstImage.isNotEmpty
                            ? BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(article.firstImage),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                ),
                              )
                            : BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://gstwar.com/theme/img/no-image.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                ),
                              ),
                      ),
                      //+ DateTime.now to make all tag different from each others
                      tag: tag == ''
                          ? article.id.toString() + DateTime.now().toString()
                          : tag,
                    ),
                  ),
                Expanded(
                    flex: 1, child: SizedBox(width: 5 * screenWidth / 360)),
                Expanded(
                  flex: 25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(flex: 2, child: SizedBox(height: 5)),
                      Expanded(
                        flex: 33,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          height: 100 * screenHeight / 780,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  article.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 15 * screenWidth / 360,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                      color: Colors.deepOrange),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  article.description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 13 * screenWidth / 360,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Container(
                                width: 140 * screenWidth / 360,
                                child: Text(
                                  article.category,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                    fontSize: 11 * screenWidth / 360,
                                    color: Colors.green,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 0,
                                ),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  article.time.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 10 * screenWidth / 360,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _bookmarkArticle(Article item, BuildContext context) {
    BlocProvider.of<DatabaseBloc>(context).add(AddSaveArticle(item));
  }

  RelativeRect buttonMenuPosition(BuildContext c) {
    final RenderBox bar = c.findRenderObject();
    final RenderBox overlay = Overlay.of(c).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        bar.localToGlobal(bar.size.bottomRight(Offset.zero), ancestor: overlay),
        bar.localToGlobal(bar.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    return position;
  }
}
