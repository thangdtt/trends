import 'package:flutter/material.dart';

enum AppTheme {
  Light,
  Dark,
}

enum contentBackgroundColor {
  White,
  Black,
  Yellow,
  Gray,
}

enum contentTextColor {
  Black,
  White,
  Amber,
  Green,
}

final contentBackgroundColorData = {
  contentBackgroundColor.White: Color.fromRGBO(255, 255, 255, 1),
  contentBackgroundColor.Black: Color.fromRGBO(45, 45, 45, 1),
  contentBackgroundColor.Yellow: Color.fromRGBO(255, 227, 128, 1),
  contentBackgroundColor.Gray: Color.fromRGBO(150, 150, 150, 1),
};

final contentTextColorData = {
  contentTextColor.Black: Colors.black,
  contentTextColor.White: Color.fromRGBO(250, 250, 250, 1),
  contentTextColor.Amber: Colors.amber,
  contentTextColor.Green: Colors.green,
};

final appThemeData = {
  AppTheme.Light: ThemeData(
    bottomAppBarColor: Color.fromRGBO(128, 128, 128, 1),
    backgroundColor: Color.fromRGBO(250, 250, 250, 1),
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    canvasColor: Color.fromRGBO(240, 240, 240, 1),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontStyle: FontStyle.italic),
      headline6: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(fontSize: 19, fontFamily: 'Hind'),
    ),
  ),
  AppTheme.Dark: ThemeData(
    iconTheme: IconThemeData(color: Colors.amber),
    accentColor: Colors.amberAccent,
    bottomAppBarColor: Color.fromRGBO(10, 10, 10, 1),
    backgroundColor: Color.fromRGBO(30, 30, 30, 1),
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    //canvasColor: Color.fromRGBO(255, 254, 229, 1),
    canvasColor: Color.fromRGBO(20, 20, 20, 1),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontStyle: FontStyle.italic),
      headline6: TextStyle(
          fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.amber),
      bodyText2:
          TextStyle(fontSize: 19, fontFamily: 'Hind', color: Colors.amber[300]),
    ),
  ),
};
