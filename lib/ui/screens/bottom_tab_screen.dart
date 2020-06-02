import 'package:flutter/material.dart';
import 'package:trends/ui/screens/music_screen.dart';
import 'package:trends/ui/screens/news_screen.dart';

import 'package:trends/ui/widgets/main_drawer.dart';

import 'package:trends/ui/utils/custom_icons.dart';

class BottomTabScreen extends StatefulWidget {
  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> {
  List<Widget> _pages;

  int tabPageIndex = 0;

  @override
  void initState() {
    _pages = [
      NewsScreen(),
      MusicScreen(),
    ];
    super.initState();
  }

  void selectTab(int index) {
    setState(() {
      tabPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trends"),
      ),
      drawer: MainDrawer(),
      body: _pages[tabPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: selectTab,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.black87,
          currentIndex: tabPageIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.newspaper),
                title: Text(
                  "Trends",
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.star),
                title: Text(
                  "Favorite",
                )),
          ]),
    );
  }
}
