import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:trends/ui/screens/music_screen.dart';
import 'package:trends/ui/screens/news_screen.dart';
import 'package:trends/ui/widgets/main_drawer.dart';
import 'package:trends/utils/custom_icons.dart';

class BottomTabScreen extends StatefulWidget {
  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen>
    with AutomaticKeepAliveClientMixin<BottomTabScreen> {
  final List<IconData> icons = <IconData>[
    CustomIcons.newspaper,
    Icons.music_note
  ];
  final List<String> tabDescriptions = ["News", "Music"];
  List<BottomNavigationBarItem> bottomBarItems;

  PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    bottomBarItems = _buildBottomBarItem(icons, tabDescriptions);
    _pageController = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<BottomNavigationBarItem> _buildBottomBarItem(
      List<IconData> icons, List<String> descriptions) {
    List<BottomNavigationBarItem> listWidget = new List();
    for (var i = 0; i < icons.length; i++) {
      listWidget.add(BottomNavigationBarItem(
        icon: Icon(icons[i]),
        title: Text(descriptions[i]),
      ));
    }
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(20 * screenHeight/360),
          child: AppBar(
            title: Text(
              "Trends",
              style: TextStyle(),
            ),
            backgroundColor: Theme.of(context).bottomAppBarColor,
          ),
        ),
        drawer: MainDrawer(),
        body: PageView(
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              _currentIndex = page;
            });
          },
          children: <Widget>[
            NewsScreen(),
            MusicScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.white54,
          items: bottomBarItems,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
