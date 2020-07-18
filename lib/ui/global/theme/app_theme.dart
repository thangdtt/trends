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
    fontFamily: 'Pacifico-Regular',
    bottomAppBarColor: Color.fromRGBO(128, 128, 128, 1),
    backgroundColor: Color.fromRGBO(255, 255, 255, 1),
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    primaryColor: Color.fromRGBO(240, 240, 240, 1),
    canvasColor: Color.fromRGBO(230, 230, 230, 1),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontStyle: FontStyle.italic),
      headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
      bodyText2: TextStyle(fontSize: 19, fontFamily: 'Hind'),
    ),
    errorColor: Colors.teal,
  ),
  AppTheme.Dark: ThemeData(
    fontFamily: 'Pacifico-Regular',
    errorColor: Colors.amber,
    iconTheme: IconThemeData(color: Colors.amber),
    accentColor: Colors.amberAccent,
    bottomAppBarColor: Color.fromRGBO(10, 10, 10, 1),
    backgroundColor: Color.fromRGBO(45, 45, 45, 1),
    brightness: Brightness.dark,
    primarySwatch: Colors.amber,
    //canvasColor: Color.fromRGBO(255, 254, 229, 1),
    canvasColor: Color.fromRGBO(20, 20, 20, 1),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontStyle: FontStyle.italic),
      headline6: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.amber),
      bodyText2:
          TextStyle(fontSize: 19, fontFamily: 'Hind', color: Colors.amber[300]),
    ),
  ),
};
