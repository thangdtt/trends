import 'package:flutter/material.dart';
import 'package:trends/blocs/article/article_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/data/article_repository.dart';
import 'package:trends/ui/widgets/news_tab.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key key}) : super(key: key);
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with SingleTickerProviderStateMixin {
  final List<Tab> newsTabs = <Tab>[
    Tab(
      child: Text("Business"),
    ),
    Tab(
      child: Text("Entertainment"),
    ),
    Tab(
      child: Text("Heath"),
    ),
    Tab(
      child: Text("Sci/Tech"),
    ),
    Tab(
      child: Text("Sports"),
    ),
    Tab(
      child: Text("Top stories"),
    ),
  ];

  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: newsTabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ArticleBloc(ArticleRepository()),
        ),
      ],
      child: DefaultTabController(
        length: 6,
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              child: AppBar(
                bottom: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: newsTabs,
                ),
              ),
              preferredSize: Size.fromHeight(50.0),
            ),
            body: TabBarView(
              children: [
                NewsTab(0),
                NewsTab(1),
                NewsTab(2),
                NewsTab(3),
                NewsTab(4),
                NewsTab(5),
              ],
              controller: _tabController,
            ),
          ),
        ),
      ),
    );
  }
}
