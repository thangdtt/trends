import 'package:flutter/material.dart';

enum AppTheme {
  Light,
  Dark,
}

final appThemeData = {
  AppTheme.Light: ThemeData(
    bottomAppBarColor: Color.fromRGBO(200, 200, 200, 1),
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
    bottomAppBarColor: Color.fromRGBO(10, 10, 10, 1),
    backgroundColor: Color.fromRGBO(30, 30, 30, 1),
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    //canvasColor: Color.fromRGBO(255, 254, 229, 1),
    canvasColor: Color.fromRGBO(20, 20, 20, 1),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontStyle: FontStyle.italic),
      headline6: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.amber),
      bodyText2: TextStyle(fontSize: 19, fontFamily: 'Hind',color: Colors.amber[300]),
    ),
  ),
};
