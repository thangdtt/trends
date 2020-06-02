import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/blocs/article/article_bloc.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/ui/widgets/news_widget.dart';

class NewsTab extends StatefulWidget {
  final int tabIndex;
  NewsTab(this.tabIndex);

  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  void initState() {
    super.initState();
    fetchData(widget.tabIndex.toString());
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
    return Container(
      color: Colors.purple,
    );
  }

  Widget buildErrorInput() {
    return Container(
      color: Colors.red,
    );
  }

  Widget buildLoadedInput(List<Article> article) {
    return ListView.builder(
      itemBuilder: (ctx, i) {
        return NewsWidget(
          article: article[i],
          callback: () {
            Navigator.of(context).pushNamed('/article', arguments: article);
          },
        );
      },
      itemCount: article.length,
    );
  }

  void fetchData(String categoryId) {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(GetRealTimeArticle(categoryId));
  }
}
