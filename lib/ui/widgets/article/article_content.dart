import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/blocs/theme/theme_bloc.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/ui/global/theme/app_theme.dart';
import 'package:trends/ui/widgets/article/article_cotent_bars.dart';
import 'package:trends/ui/widgets/article/sugguest_articles_widget.dart';
import 'package:trends/utils/utils_class.dart';

import 'content_page_theme_adjust.dart';

class ArticleContentWidget extends StatefulWidget {
  static const routeName = '/read-article';

  const ArticleContentWidget({Key key, this.article, this.catEnum})
      : super(key: key);
  final Article article;
  final CategoryEnum catEnum;

  @override
  _ArticleContentWidgetState createState() => _ArticleContentWidgetState();
}

class _ArticleContentWidgetState extends State<ArticleContentWidget> {
  Color backgroundColor;
  Color textColor;
  bool showMessage = false;

  ThemeBloc themeBloc;
  Article article;
  CategoryEnum catEnum;

  @override
  void initState() {
    super.initState();
    themeBloc = BlocProvider.of<ThemeBloc>(context);
    backgroundColor = (themeBloc.state as ThemeLoaded).pageBackgroundColor;
    textColor = (themeBloc.state as ThemeLoaded).textColor;
    article = widget.article;
    catEnum = widget.catEnum;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showMessage = !showMessage;
              });
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: backgroundColor,
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          width: 15 * screenWidth / 360,
                          height: 15 * screenWidth / 360,
                          decoration: new BoxDecoration(
                              border: Border.all(width: 0.3),
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: _chooseNewsPaperImage(article.source),
                              )),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(5, 10, 10, 0),
                            child: Text(
                              article.source,
                              style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.deepPurple)
                                  .copyWith(
                                fontSize: 7 * screenHeight / 360 +
                                    (themeBloc.state as ThemeLoaded)
                                            .pageFontSizeFactor *
                                        3,
                              ),
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                          fit: FlexFit.tight,
                          flex: 3,
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Text(
                              article.category,
                              style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      //fontStyle: FontStyle.italic,
                                      color: setTimeAndCaptionColor())
                                  .copyWith(
                                fontSize: 7 * screenHeight / 360 +
                                    (themeBloc.state as ThemeLoaded)
                                            .pageFontSizeFactor *
                                        3,
                              ),
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: SizedBox(
                          child: Text(
                            article.title,
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      fontSize: 10 * screenHeight / 360 +
                                          (themeBloc.state as ThemeLoaded)
                                                  .pageFontSizeFactor *
                                              7,
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        article.time,
                        style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: setTimeAndCaptionColor())
                            .copyWith(
                          fontSize: 7 * screenHeight / 360 +
                              (themeBloc.state as ThemeLoaded)
                                      .pageFontSizeFactor *
                                  3,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          article.location.isNotEmpty
                              ? article.location + " - " + article.description
                              : article.description,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 8 * screenHeight / 360 +
                                  (themeBloc.state as ThemeLoaded)
                                          .pageFontSizeFactor *
                                      4,
                              color: textColor),
                        ),
                      ),
                    ),
                    buildContentWidget(article.content, context),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        article.author,
                        style: TextStyle(
                          fontSize: 6 * screenHeight / 360 +
                              (themeBloc.state as ThemeLoaded)
                                      .pageFontSizeFactor *
                                  4,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      alignment: Alignment(1.0, 0.0),
                    ),
                    SizedBox(height: 10 * screenHeight / 360),
                    SuggestArticlesWidget(catEnum),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 700),
            top: showMessage
                ? screenHeight - (114 * screenHeight / 360)
                : screenHeight + 50,
            left: 0,
            child: ContentPageThemeAdjuster(
              changeBackColor: changeBackground,
              changeTextColor: changeTextColor,
            ),
          ),
          AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              top: showMessage ? 0 : -50,
              left: 0,
              child: ArticleContentTopBar(article)),
          // AnimatedPositioned(
          //     duration: Duration(milliseconds: 300),
          //     top: showMessage
          //         ? screenHeight - (36 * screenHeight / 360)
          //         : screenHeight + 50,
          //     left: 0,
          //     child: ArticleContentBottomBar()),
        ]),
      ),
    );
  }

  Widget buildContentWidget(
      List<ArticleContent> content, BuildContext context) {
    var list = List<Widget>();
    if (content == null || content.isEmpty) return Container();
    for (var item in content) {
      if (item.type == "text")
        list.add(
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              item.info,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 8 * MediaQuery.of(context).size.height / 360 +
                      (themeBloc.state as ThemeLoaded).pageFontSizeFactor * 4,
                  color: textColor),
            ),
          ),
        );
      else if (item.type == "image")
        list.add(Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Image.network(
            item.info,
            fit: BoxFit.cover,
          ),
        ));
      else
        list.add(
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Text(
              item.info,
              style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: 7 * MediaQuery.of(context).size.height / 360 +
                      (themeBloc.state as ThemeLoaded).pageFontSizeFactor * 4,
                  color: setTimeAndCaptionColor()),
            ),
          ),
        );
    }
    return Column(
      children: list,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  void changeBackground(Color color) {
    setState(() {
      backgroundColor = color;
    });
  }

  void changeTextColor(Color color) {
    setState(() {
      textColor = color;
    });
  }

  Color setTimeAndCaptionColor() {
    if (backgroundColor ==
        contentBackgroundColorData[contentBackgroundColor.Gray])
      return Colors.black87;
    else if (backgroundColor ==
        contentBackgroundColorData[contentBackgroundColor.Black])
      return Colors.white70;
    else if (backgroundColor ==
        contentBackgroundColorData[contentBackgroundColor.Yellow])
      return Colors.black87;
    else
      return Colors.black54;
  }

  NetworkImage _chooseNewsPaperImage(String source) {
    if (source == "VnExpress")
      return NetworkImage(
        "https://is5-ssl.mzstatic.com/image/thumb/Purple123/v4/b0/be/04/b0be046b-1ef0-c33b-a380-a02f26f90e6e/AppIcon-0-0-1x_U007emarketing-0-0-0-7-85-220.png/320x0w.png",
      );
    else if (source == "Tuổi trẻ")
      return NetworkImage(
        "https://image.winudf.com/v2/image/dm4udHVvaXRyZWFwcC5uZXdzX2ljb25fMTUxMjQ1MTUyMl8wNjc/icon.png?w=170&fakeurl=1",
      );
    else
      return NetworkImage(
        "https://scontent.fvca1-1.fna.fbcdn.net/v/t31.0-8/p960x960/26170708_1569204013199886_9008855621358191382_o.jpg?_nc_cat=1&_nc_sid=85a577&_nc_ohc=rLgfEAudOHkAX8sQ2R0&_nc_ht=scontent.fvca1-1.fna&_nc_tp=6&oh=ccce07b088e6410be8087e7b7f585b7e&oe=5F2A0D93",
      );
  }
}
