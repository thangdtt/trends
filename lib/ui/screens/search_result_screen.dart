import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trends/blocs/searchArticle/searcharticle_bloc.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/ui/widgets/article_content.dart';
import 'package:trends/ui/widgets/news_widget.dart';

class SearchResultScreen extends StatefulWidget {
  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<SearcharticleBloc, SearchArticleState>(
        builder: (context, state) {
          if (state is SearcharticleInitial) {
          } else if (state is SearchArticleLoading) {
            return Center(child: Text("Đang tìm"));
          } else if (state is SearchArticleLoaded) {
            if (state.articles.isEmpty)
              return Center(child: Text("Không tìm thấy !"));
            else
              return buildLoadedInput(state.articles, context);
          }
          return Center(child: Text("Xảy ra lỗi"));
        },
      ),
    );
  }

  Widget buildLoadedInput(List<Article> articles, BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, i) {
        return NewsWidget(
          article: articles[i],
          callback: () {
            Navigator.of(context).pushNamed(ArticleContentWidget.routeName,
                arguments: articles[i]);
          },
        );
      },
      itemCount: articles.length,
    );
  }
}
