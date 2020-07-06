import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trends/blocs/article/article_bloc.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            bottom: TabBar(
              labelColor: Theme.of(context).textSelectionColor,
              controller: _tabController,
              isScrollable: true,
              tabs: _buildTabs(),
            ),
          ),
          preferredSize: Size.fromHeight(50.0),
        ),
        body: TabBarView(
          children: _buildTabContent(numberOfCategory),
          controller: _tabController,
        ),
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
