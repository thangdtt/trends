
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trends/data/models/music.dart';

class MusicWidget extends StatelessWidget {
  final GestureTapCallback callback;
  final Music music;
  final String tag;
  final double width;
  final String time;

  const MusicWidget(
      {Key key,
      this.callback,
      this.music,
      this.tag = '',
      this.width = 0,
      this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: callback,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 2 * screenWidth / 360, vertical: 1),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
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
                        decoration: music.image.isNotEmpty
                            ? BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(music.image),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(3),
                                    bottomLeft: Radius.circular(3)),
                              )
                            : BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://gstwar.com/theme/img/no-image.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(3),
                                    bottomLeft: Radius.circular(3)),
                              )),
                    //+ DateTime.now to make all tag different from each others
                    tag: tag == ''
                        ? music.id.toString() + DateTime.now().toString()
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
                                  music.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 15 * screenWidth / 360,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  music.singer,
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
                              flex: 3,
                              child: Container(
                                width: 140 * screenWidth / 360,
                                child: Text(
                                  time??'',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11 * screenWidth / 360,
                                    color: Colors.teal,
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
}
