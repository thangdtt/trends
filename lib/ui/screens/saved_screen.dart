import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/blocs/savedArticle/savedArticle_bloc.dart';
import 'package:trends/blocs/theme/theme_bloc.dart';
import 'package:trends/ui/widgets/saved_article_tab.dart';
import 'package:trends/ui/widgets/favorite_music_tab.dart';
import 'package:trends/utils/custom_icons.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  SavedArticleBloc _savedArticleBloc;
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _savedArticleBloc = BlocProvider.of<SavedArticleBloc>(context);
    //articleBloc.add(GetSavedArticles());
  }

  void _handleTabSelection() {
    //if (_tabController.index == 1) _savedArticleBloc.add(GetAllSaveArticle());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return IconTheme(
      data: new IconThemeData(
          color: (BlocProvider.of<ThemeBloc>(context).state as ThemeLoaded)
                  .isDarkMode
              ? Colors.amber
              : Colors.black),
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            bottom: TabBar(
              labelColor: Theme.of(context).textSelectionColor,
              controller: _tabController,
              isScrollable: false,
              tabs: [
                Tab(
                  child: Container(
                    width: screenWidth / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(
                            CustomIcons.bookmark,
                            size: 17 * screenWidth / 360,
                          ),
                        ),
                        Text(
                          "Tin đã lưu",
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 17 * screenWidth / 360,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: screenWidth / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(
                            CupertinoIcons.heart_solid,
                            size: 17 * screenWidth / 360,
                          ),
                        ),
                        Text(
                          "Nhạc yêu thích",
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 17 * screenWidth / 360,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(50.0),
        ),
        body: TabBarView(
          children: [
            SavedArticleTab(),
            FavoriteMusicTab(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive =>true;
}
