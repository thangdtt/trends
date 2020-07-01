import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/blocs/database/database_bloc.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/ui/widgets/article_content.dart';
import 'package:trends/ui/widgets/news_widget.dart';
import 'package:trends/data/saveArticle_repository.dart';

class SavedArticleTab extends StatefulWidget {
  @override
  _SavedArticleTabState createState() => _SavedArticleTabState();
}

class _SavedArticleTabState extends State<SavedArticleTab> {
  DatabaseBloc dbBloc;

  @override
  void initState() {
    super.initState();
    dbBloc = BlocProvider.of<DatabaseBloc>(context);
    //dbBloc.add(GetAllSaveArticle());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<DatabaseBloc, DatabaseState>(
        bloc: dbBloc,
        builder: (context, state) {
          if (state is DatabaseInitial) {
            return Container();
          } else if (state is DatabaseLoading) {
            return Center(child: Text("Đang tải"));
          } else if (state is DatabaseLoaded) {
            if (state.savedArticles.isEmpty)
              return Center(child: Text("Không tìm thấy !"));
            else
              return buildLoadedInput(state.savedArticles, context);
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
              dbBloc.add(DeleteSaveArticle(articles[i]));
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
                getArticleContent(articles[i].id).then((value) =>
                    Navigator.of(context).pushNamed(
                        ArticleContentWidget.routeName,
                        arguments: value));
              },
            ),
          ),
        );
      },
      itemCount: articles.length,
    );
  }

  Future<Article> getArticleContent(int id) async {
    Article article = await SavedArticleRepository.getSavedArticle(id);
    return article;
  }
}
