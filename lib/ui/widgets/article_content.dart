import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trends/data/models/article.dart';
import 'package:trends/ui/global/theme/app_theme.dart';
import 'package:trends/ui/widgets/article_cotent_bars.dart';
import 'package:trends/blocs/theme/theme_bloc.dart';

import 'content_page_theme_adjust.dart';

class ArticleContentWidget extends StatefulWidget {
  static const routeName = '/article-content';

  @override
  _ArticleContentWidgetState createState() => _ArticleContentWidgetState();
}

class _ArticleContentWidgetState extends State<ArticleContentWidget> {
  Color backgroundColor;
  Color textColor;
  bool showMessage = false;

  ThemeBloc themeBloc;

  @override
  void initState() {
    super.initState();
    themeBloc = BlocProvider.of<ThemeBloc>(context);
    backgroundColor = (themeBloc.state as ThemeLoaded).pageBackgroundColor;
    textColor = (themeBloc.state as ThemeLoaded).textColor;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final Article article = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
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
                            horizontal: 0, vertical: 5),
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
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5),
                        child: Text(
                          article.description,
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
                    )
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
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
    for (var item in content) {
      if (item.type == "text")
        list.add(
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
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
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: Image.network(
            item.info,
            fit: BoxFit.cover,
          ),
        ));
      else
        list.add(
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
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
}
