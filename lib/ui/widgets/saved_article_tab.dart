import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/blocs/savedArticles/savedarticle_bloc.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/ui/widgets/article_content.dart';
import 'package:trends/ui/widgets/news_widget.dart';

class SavedArticleTab extends StatefulWidget {
  @override
  _SavedArticleTabState createState() => _SavedArticleTabState();
}

class _SavedArticleTabState extends State<SavedArticleTab> {
  SavedArticleBloc saveBloc;

  @override
  void initState() {
    super.initState();
    saveBloc = BlocProvider.of<SavedArticleBloc>(context);
    saveBloc.add(GetSavedArticles());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<SavedArticleBloc, SavedArticleState>(
        builder: (context, state) {
          if (state is SavedArticleInitial) {
            return Container();
          } else if (state is SavedArticleLoading) {
            Future.delayed(Duration(milliseconds: 200));
            return Center(child: Text("Đang tải"));
          } else if (state is SavedArticleLoaded) {
            if (state.articles.isEmpty)
              return Center(child: Text("Không tìm thấy !"));
            else
              return buildLoadedInput(state.articles, context);
          } else
            return Center(child: Text("Xảy ra lỗi"));
        },
      ),
    );
  }

  Widget buildLoadedInput(List<Article> articles, BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, i) {
        return Container(
          child: Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              saveBloc.add(DeleteSavedArticle(articles[i].id));
            },
            background: Container(
              color: Colors.red[400],
              child: Container(
                  margin: const EdgeInsets.all(30), child: Icon(Icons.delete)),
              alignment: AlignmentDirectional.centerEnd,
            ),
            direction: DismissDirection.endToStart,
            child: NewsWidget(
              article: articles[i],
              callback: () {
                Navigator.of(context).pushNamed(ArticleContentWidget.routeName,
                    arguments: articles[i]);
              },
            ),
          ),
        );
      },
      itemCount: articles.length,
    );
  }
}
