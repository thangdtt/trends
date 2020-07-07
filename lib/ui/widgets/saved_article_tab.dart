import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/blocs/savedArticle/savedArticle_bloc.dart';
import 'package:trends/blocs/suggestArticle/suggestArticle_bloc.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/ui/widgets/article/article_content.dart';
import 'package:trends/ui/widgets/news_widget.dart';
import 'package:trends/data/saveArticle_repository.dart';
import 'package:trends/utils/utils_class.dart';

class SavedArticleTab extends StatefulWidget {
  @override
  _SavedArticleTabState createState() => _SavedArticleTabState();
}

class _SavedArticleTabState extends State<SavedArticleTab> {
  SavedArticleBloc _savedArticleBloc;

  @override
  void initState() {
    super.initState();
    _savedArticleBloc = BlocProvider.of<SavedArticleBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<SavedArticleBloc, SavedArticleState>(
        bloc: _savedArticleBloc,
        builder: (context, state) {
          if (state is SavedArticleInitial) {
            return Container();
          } else if (state is SavedArticleLoading) {
            return Center(child: Text("Đang tải"));
          } else if (state is SavedArticleLoaded) {
            if (state.savedArticles.isEmpty)
              return Center(child: Text("Không có bài viết được lưu!"));
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
              _savedArticleBloc.add(DeleteSaveArticle(articles[i]));
            },
            background: Container(
              color: Colors.red[400],
              child: Container(
                  margin: const EdgeInsets.all(30), child: Icon(Icons.delete)),
              alignment: AlignmentDirectional.centerEnd,
            ),
            direction: DismissDirection.endToStart,
            child: Container(
              padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
              child: NewsWidget(
                article: articles[i],
                callback: () {
                  CategoryEnum catEnum = mapCategoryNames.keys.firstWhere(
                      (k) => mapCategoryNames[k] == articles[i].category,
                      orElse: () => CategoryEnum.TheGioi);

                  getArticleContent(articles[i].id).then((value) {
                    if (value != null) {
                      BlocProvider.of<SuggestArticleBloc>(context)
                          .add(FetchSuggestArticles(catEnum));
                      Navigator.of(context).pushNamed(
                          ArticleContentWidget.routeName,
                          arguments: {
                            'article': value,
                            'catEnum': catEnum,
                          });
                    } else
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Vui lòng kết nối internet'),
                        duration: Duration(seconds: 1),
                      ));
                  });
                },
              ),
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
