import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 2 * screenWidth / 360, vertical: 1),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(3)),
            border: Border.all(color: Colors.black54, width: 0.5),
          ),
          width: width == 0 ? screenWidth : width,
          height: 130 * screenHeight / 780,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
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
                    decoration: article.image != null
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(article.image),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3),
                                bottomLeft: Radius.circular(3)),
                          )
                        : BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3),
                                bottomLeft: Radius.circular(3)),
                          ),
                  ),
                  tag: tag == '' ? article.id : tag,
                ),
              ),
              Expanded(flex: 1, child: SizedBox(width: 5 * screenWidth / 360)),
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
                        //height: 100 * screenHeight / 780,
                        child: Text(
                          article.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          style: TextStyle(
                            fontSize: 14 * screenWidth / 360,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
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
                                article.source,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11 * screenWidth / 360,
                                  color: Colors.teal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              article.time.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10 * screenWidth / 360,
                                color: Colors.black54,
                                decoration: TextDecoration.none,
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
    );
  }
}
