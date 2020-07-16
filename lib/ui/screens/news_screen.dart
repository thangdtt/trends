import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trends/blocs/article/article_bloc.dart';
import 'package:trends/blocs/searchArticle/searcharticle_bloc.dart';
import 'package:trends/ui/screens/search_result_screen.dart';
import 'package:trends/ui/widgets/news_tab.dart';
import 'package:trends/utils/utils_class.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key key, this.tabFilter}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
  final Map<CategoryEnum, bool> tabFilter;
}

class _NewsScreenState extends State<NewsScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ArticleBloc articleBloc;
  TabController _tabController;
  int numberOfCategory;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    numberOfCategory = 0;
    for (var item in widget.tabFilter.values) {
      if (item) numberOfCategory++;
    }
    _tabController = new TabController(length: numberOfCategory, vsync: this);
    _tabController.addListener(_handleTabSelection);
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticles(
        mapIndexToCategory(_tabController.index, widget.tabFilter)));
  }

  void _handleTabSelection() {
    articleBloc.add(FetchArticles(
        mapIndexToCategory(_tabController.index, widget.tabFilter)));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          actions: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: screenWidth * 35 / 40,
                  child: TabBar(
                    labelColor: Theme.of(context).textSelectionColor,
                    controller: _tabController,
                    isScrollable: true,
                    tabs: _buildTabs(),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: Colors.grey,width: 0.2))),
                  width: screenWidth * 5 / 40,
                  child: IconButton(
                    icon: Icon(
                      Platform.isIOS ? CupertinoIcons.search : Icons.search,
                      color: Theme.of(context).textTheme.bodyText2.color,
                    ),
                    onPressed: () {
                      showSearch(context: context, delegate: DataSearch());
                    },
                  ),
                )
              ],
            )
          ],
        ),
        preferredSize: Size.fromHeight(50.0),
      ),
      body: TabBarView(
        children: _buildTabContent(numberOfCategory),
        controller: _tabController,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  List<Widget> _buildTabs() {
    List<Widget> list = new List();
    for (var key in widget.tabFilter.keys) {
      if (widget.tabFilter[key] == true)
        list.add(Tab(
          child: Text(
            mapCategoryNames[key],
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: 8 * MediaQuery.of(context).size.height / 360,
                fontWeight: FontWeight.bold),
          ),
        ));
    }

    return list;
  }

  List<Widget> _buildTabContent(int max) {
    List<Widget> list = new List();
    for (var key in widget.tabFilter.keys) {
      if (widget.tabFilter[key] == true)
        list.add(NewsTab(
          catEnum: key,
        ));
    }
    return list;
  }
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
