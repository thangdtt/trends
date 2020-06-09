import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trends/blocs/article/article_bloc.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/ui/screens/article_content_screen.dart';
import 'package:trends/ui/widgets/news_widget.dart';

class NewsTab extends StatefulWidget {
  final int tabIndex;
  NewsTab(this.tabIndex);

  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  ArticleBloc articleBloc;

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ArticleBloc, ArticleState>(builder: (context, state) {
        if (state is ArticleInitial) {
          return buildInitialInput();
        } else if (state is ArticleLoading) {
          return buildLoadingInput();
        } else if (state is ArticleLoaded) {
          return buildLoadedInput(state.articles);
        } else {
          return buildErrorInput();
        }
      }),
    );
  }

  Widget buildInitialInput() {
    return Container(
      color: Colors.green,
    );
  }

  Widget buildLoadingInput() {
    return Center(
      child: Container(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          backgroundColor: Colors.cyan,
          strokeWidth: 5,
        ),
      ),
    );
  }

  Widget buildErrorInput() {
    return Container(
      color: Colors.red,
    );
  }

  Widget buildLoadedInput(List<Article> articles) {
    return ListView.builder(
      itemBuilder: (ctx, i) {
        return NewsWidget(
          article: articles[i],
          callback: () {
            Navigator.of(context).pushNamed(ArticleContentScreen.routeName,
                arguments: articles[i]);
          },
        );
      },
      itemCount: articles.length,
    );
  }
}
