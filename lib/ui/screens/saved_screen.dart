import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/blocs/savedArticles/savedarticle_bloc.dart';
import 'package:trends/ui/widgets/saved_article_tab.dart';
import 'package:trends/ui/widgets/love_music_tab.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen>
    with SingleTickerProviderStateMixin {
  SavedArticleBloc articleBloc;
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
    articleBloc = BlocProvider.of<SavedArticleBloc>(context);
    //articleBloc.add(GetSavedArticles());
  }

  void _handleTabSelection() {
    if (_tabController.index == 1) articleBloc.add(GetSavedArticles());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          bottom: TabBar(
            labelColor: Theme.of(context).textSelectionColor,
            controller: _tabController,
            isScrollable: true,
            tabs: [
              Tab(
                child: Text(
                  "Tin đã lưu",
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 8 * screenHeight / 360,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  "Nhạc yêu thích",
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 8 * screenHeight / 360,
                      fontWeight: FontWeight.bold),
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
          LovedMusicTab(),
        ],
        controller: _tabController,
      ),
    );
  }
}
