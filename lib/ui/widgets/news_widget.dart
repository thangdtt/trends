import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/blocs/savedArticle/savedArticle_bloc.dart';
import 'package:trends/blocs/theme/theme_bloc.dart';

import 'package:trends/data/models/article.dart';
import 'package:trends/ui/widgets/custom_popup_menu_item.dart';

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
      onLongPressStart: (LongPressStartDetails details) async {
        final _pos = details.globalPosition;
        final int value = await showCustomMenu(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            items: <CustomPopupMenuEntry<int>>[
              CustomPopupMenuItem(
                value: 0,
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
              CustomPopupMenuItem(
                value: 1,
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
            ],
            context: context,
            //position: buttonMenuPosition(context),
            position: RelativeRect.fromLTRB(
                _pos.dx - 150, _pos.dy - 50, _pos.dy, _pos.dx),
            elevation: 5);

        if (value == 0) {
          callback();
        } else {
          _bookmarkArticle(article, context);
        }
      },
      onTap: callback,
      child: Container(
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            //side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
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
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                              )
                            : BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://gstwar.com/theme/img/no-image.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
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
                                      color: Colors.teal),
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
                            Container(
                              width: 15 * screenWidth / 360,
                              height: 15 * screenWidth / 360,
                              decoration: new BoxDecoration(
                                border: Border.all(width: 0.3),
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: _chooseNewsPaperImage(),
                                ),
                              ),
                            ),
                            SizedBox(width: 3),
                            Expanded(
                              flex: 7,
                              child: Container(
                                width: 140 * screenWidth / 360,
                                child: Text(
                                  article.source,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                    fontSize: 12 * screenWidth / 360,
                                    color: Colors.green,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 16,
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  article.time.toString(),
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontSize: 11 * screenWidth / 360,
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
    BlocProvider.of<SavedArticleBloc>(context).add(AddSaveArticle(item));
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

  NetworkImage _chooseNewsPaperImage() {
    if (article.link.contains("vnexpress.net"))
      return NetworkImage(
        "https://is5-ssl.mzstatic.com/image/thumb/Purple123/v4/b0/be/04/b0be046b-1ef0-c33b-a380-a02f26f90e6e/AppIcon-0-0-1x_U007emarketing-0-0-0-7-85-220.png/320x0w.png",
      );
    else if (article.link.contains("tuoitre.vn"))
      return NetworkImage(
        "https://image.winudf.com/v2/image/dm4udHVvaXRyZWFwcC5uZXdzX2ljb25fMTUxMjQ1MTUyMl8wNjc/icon.png?w=170&fakeurl=1",
      );
    else
      return NetworkImage(
        "https://scontent.fvca1-1.fna.fbcdn.net/v/t31.0-8/p960x960/26170708_1569204013199886_9008855621358191382_o.jpg?_nc_cat=1&_nc_sid=85a577&_nc_ohc=rLgfEAudOHkAX8sQ2R0&_nc_ht=scontent.fvca1-1.fna&_nc_tp=6&oh=ccce07b088e6410be8087e7b7f585b7e&oe=5F2A0D93",
      );
  }
}
