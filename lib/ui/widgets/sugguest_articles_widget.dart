import 'package:flutter/material.dart';
import 'package:trends/blocs/suggestArticle/suggestArticle_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/ui/widgets/article_content.dart';
import 'package:trends/ui/widgets/news_widget.dart';
import 'package:trends/utils/utils_class.dart';
import 'package:trends/blocs/history/history_bloc.dart';

class SuggestArticlesWidget extends StatefulWidget {
  final CategoryEnum catEnum;

  SuggestArticlesWidget(this.catEnum);

  @override
  _SuggestArticlesWidgetState createState() => _SuggestArticlesWidgetState();
}

class _SuggestArticlesWidgetState extends State<SuggestArticlesWidget> {
  SuggestArticleBloc suggestBloc;

  @override
  void initState() {
    super.initState();
    suggestBloc = BlocProvider.of<SuggestArticleBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildSuggestContent(),
    );
  }

  Widget _buildSuggestContent() {
    if (suggestBloc.state is SuggestArticleInitial) {
      return Container();
    } else if (suggestBloc.state is SuggestArticleLoading) {
      return Container();
    } else if (suggestBloc.state is SuggestArticleLoaded) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0,0,0,10),
        height: 139 * MediaQuery.of(context).size.height / 780,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (ctx, i) {
            return Container(
              child: NewsWidget(
                article:
                    (suggestBloc.state as SuggestArticleLoaded).articles[i],
                callback: () {
                  //suggest news of the same category
                  suggestBloc.add(FetchSuggestArticles(widget.catEnum));
                  BlocProvider.of<HistoryBloc>(context).add(AddToHistory(
                      (suggestBloc.state as SuggestArticleLoaded)
                          .articles[i]
                          .id));
                  Navigator.of(context).pushReplacementNamed(
                      ArticleContentWidget.routeName,
                      arguments: {
                        'article': (suggestBloc.state as SuggestArticleLoaded)
                            .articles[i],
                        'catEnum': widget.catEnum,
                      });
                },
              ),
            );
          },
          itemCount:
              (suggestBloc.state as SuggestArticleLoaded).articles.length,
        ),
      );
    } else
      return Center(child: Text("Xảy ra lỗi"));
  }
}
