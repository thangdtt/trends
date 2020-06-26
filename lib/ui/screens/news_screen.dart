import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trends/blocs/article/article_bloc.dart';
import 'package:trends/ui/widgets/news_tab.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key key}) : super(key: key);
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ArticleBloc articleBloc;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticles());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: NewsTab(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
