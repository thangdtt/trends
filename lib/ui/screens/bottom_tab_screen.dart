import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trends/blocs/database/database_bloc.dart';
import 'package:trends/blocs/searchArticle/searcharticle_bloc.dart';
import 'package:trends/blocs/theme/theme_bloc.dart';

import 'package:trends/ui/screens/music_screen.dart';
import 'package:trends/ui/screens/news_screen.dart';
import 'package:trends/ui/screens/saved_screen.dart';
import 'package:trends/ui/screens/search_result_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/ui/widgets/main_drawer.dart';
import 'package:trends/utils/custom_icons.dart';
import 'package:trends/utils/utils_class.dart';

class BottomTabScreen extends StatefulWidget {
  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen>
    with AutomaticKeepAliveClientMixin<BottomTabScreen> {
  final List<IconData> icons = <IconData>[
    CustomIcons.newspaper,
    Icons.music_note,
    Icons.star_border,
  ];
  final List<String> tabDescriptions = ["Bản tin", "Nhạc", "Đã lưu"];
  List<BottomNavigationBarItem> bottomBarItems;
  PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DatabaseBloc>(context).add(GetAllSaveArticle());
    bottomBarItems = _buildBottomBarItem(icons, tabDescriptions);
    _pageController = PageController();
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
          preferredSize: Size.fromHeight(23 * screenHeight / 360),
          child: AppBar(
            iconTheme: Theme.of(context).iconTheme,
            title: Text(
              "Trends",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Pacifico-Regular',
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).textTheme.bodyText2.color,
                ),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                },
              ),
            ],
          ),
        ),
        drawer: Container(
          width: screenWidth*4/5,
          child: MainDrawer(),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              _currentIndex = page;
            });
          },
          children: <Widget>[
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (BuildContext context, ThemeState state) {
                if (state is ThemeLoaded) {
                  return NewsScreen(
                    key: GlobalKey(),
                    tabFilter: state.tabFilter,
                  );
                } else {
                  return Container();
                }
              },
            ),
            MusicScreen(),
            SavedScreen(),
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
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).textTheme.bodyText2.color,
          unselectedItemColor: Colors.white54,
          items: bottomBarItems,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DataSearch extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => '';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<SearcharticleBloc>(context)
        .add(StartToSearchArticle(query));
    return SearchResultScreen();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
