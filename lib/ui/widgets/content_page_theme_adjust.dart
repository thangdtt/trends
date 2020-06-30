import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trends/blocs/theme/theme_bloc.dart';
import 'package:trends/ui/global/theme/app_theme.dart';
import 'package:trends/utils/pref_utils.dart';

class ContentPageThemeAdjuster extends StatefulWidget {
  final Function(Color color) changeBackColor;
  final Function(Color color) changeTextColor;
  ContentPageThemeAdjuster(
      {@required this.changeBackColor, @required this.changeTextColor});
  @override
  _ContentPageThemeAdjusterState createState() =>
      _ContentPageThemeAdjusterState();
}

class _ContentPageThemeAdjusterState extends State<ContentPageThemeAdjuster> {
  double pageFontSizeFactor;
  ThemeBloc _themeBloc;
  @override
  void initState() {
    super.initState();
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    pageFontSizeFactor = (_themeBloc.state as ThemeLoaded).pageFontSizeFactor;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final borderColor = (_themeBloc.state as ThemeLoaded).isDarkMode
        ? Colors.amber
        : Colors.black87;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        // gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       Theme.of(context).bottomAppBarColor,
        //       Colors.lightBlueAccent,
        //     ]),
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        border: Border.all(width: 0, color: borderColor),
      ),
      height: 100 * screenHeight / 360,
      width: screenWidth,
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        "Kích thước chữ:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                Expanded(
                  flex: 6,
                  child: Slider(
                    value: pageFontSizeFactor ?? 1,
                    activeColor: Theme.of(context).indicatorColor,
                    inactiveColor: Colors.white,
                    onChanged: (double s) {
                      setState(() {
                        pageFontSizeFactor = s;
                        PrefUtils.setPageFontSizeFactorPref(s);
                        _themeBloc.add(ThemeChanged(pageFontSizeFactor: s));
                      });
                    },
                    divisions: 8,
                    min: 0.3,
                    max: 2.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        "Màu nền:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    //margin: EdgeInsets.symmetric(horizontal: 25* screenWidth/360,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Color color = contentBackgroundColorData[
                                  contentBackgroundColor.White];
                              widget.changeBackColor(color);
                              PrefUtils.setPageBackgroundColorPref(
                                  contentBackgroundColor.White.index);
                              _themeBloc.add(
                                ThemeChanged(pageBackgroundColor: color),
                              );
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: contentBackgroundColorData[
                                  contentBackgroundColor.White],
                              border: Border.all(width: 1, color: borderColor),
                            ),
                            width: 40 * screenWidth / 360,
                            height: 40 * screenWidth / 360,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Color color = contentBackgroundColorData[
                                  contentBackgroundColor.Black];
                              widget.changeBackColor(color);
                              PrefUtils.setPageBackgroundColorPref(
                                  contentBackgroundColor.Black.index);
                              _themeBloc.add(
                                  ThemeChanged(pageBackgroundColor: color));
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: contentBackgroundColorData[
                                  contentBackgroundColor.Black],
                              border: Border.all(width: 1, color: borderColor),
                            ),
                            width: 40 * screenWidth / 360,
                            height: 40 * screenWidth / 360,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Color color = contentBackgroundColorData[
                                  contentBackgroundColor.Yellow];
                              widget.changeBackColor(color);
                              PrefUtils.setPageBackgroundColorPref(
                                  contentBackgroundColor.Yellow.index);
                              _themeBloc.add(
                                  ThemeChanged(pageBackgroundColor: color));
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: contentBackgroundColorData[
                                  contentBackgroundColor.Yellow],
                              border: Border.all(width: 1, color: borderColor),
                            ),
                            width: 40 * screenWidth / 360,
                            height: 40 * screenWidth / 360,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Color color = contentBackgroundColorData[
                                  contentBackgroundColor.Gray];
                              widget.changeBackColor(color);
                              PrefUtils.setPageBackgroundColorPref(
                                  contentBackgroundColor.Gray.index);
                              _themeBloc.add(
                                  ThemeChanged(pageBackgroundColor: color));
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: contentBackgroundColorData[
                                  contentBackgroundColor.Gray],
                              border: Border.all(width: 1, color: borderColor),
                            ),
                            width: 40 * screenWidth / 360,
                            height: 40 * screenWidth / 360,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        "Màu chữ:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    //margin: EdgeInsets.symmetric(horizontal: 25* screenWidth/360,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Color color =
                                  contentTextColorData[contentTextColor.Black];
                              widget.changeTextColor(color);
                              PrefUtils.setTextColorPref(
                                  contentTextColor.Black.index);
                              _themeBloc.add(ThemeChanged(textColor: color));
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  contentTextColorData[contentTextColor.Black],
                              border: Border.all(width: 1, color: borderColor),
                            ),
                            width: 40 * screenWidth / 360,
                            height: 40 * screenWidth / 360,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Color color =
                                  contentTextColorData[contentTextColor.White];
                              widget.changeTextColor(color);
                              PrefUtils.setTextColorPref(
                                  contentTextColor.White.index);
                              _themeBloc.add(ThemeChanged(textColor: color));
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  contentTextColorData[contentTextColor.White],
                              border: Border.all(width: 1, color: borderColor),
                            ),
                            width: 40 * screenWidth / 360,
                            height: 40 * screenWidth / 360,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Color color =
                                  contentTextColorData[contentTextColor.Amber];
                              widget.changeTextColor(color);
                              PrefUtils.setTextColorPref(
                                  contentTextColor.Amber.index);
                              _themeBloc.add(ThemeChanged(textColor: color));
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  contentTextColorData[contentTextColor.Amber],
                              border: Border.all(width: 1, color: borderColor),
                            ),
                            width: 40 * screenWidth / 360,
                            height: 40 * screenWidth / 360,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Color color =
                                  contentTextColorData[contentTextColor.Green];
                              widget.changeTextColor(color);
                              PrefUtils.setTextColorPref(
                                  contentTextColor.Green.index);
                              _themeBloc.add(ThemeChanged(textColor: color));
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  contentTextColorData[contentTextColor.Green],
                              border: Border.all(width: 1, color: borderColor),
                            ),
                            width: 40 * screenWidth / 360,
                            height: 40 * screenWidth / 360,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                Color textColor = contentTextColorData[contentTextColor.Black];
                PrefUtils.setTextColorPref(contentTextColor.Black.index);
                Color backColor =
                    contentBackgroundColorData[contentBackgroundColor.White];
                PrefUtils.setPageBackgroundColorPref(
                    contentBackgroundColor.White.index);
                widget.changeBackColor(backColor);
                widget.changeTextColor(textColor);
                pageFontSizeFactor = 0.8;
                PrefUtils.setPageFontSizeFactorPref(0.8);
                _themeBloc.add(
                  ThemeChanged(
                      pageBackgroundColor: backColor, textColor: textColor),
                );
              });
            },
            child: Text(
              "Phục hồi mặc định",
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 9 * screenHeight / 360),
            ),
          ),
        ],
      ),
    );
  }
}
