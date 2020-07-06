import 'package:flutter/material.dart';
import 'package:trends/blocs/suggestArticle/suggestArticle_bloc.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/ui/widgets/article/article_content.dart';
import 'package:trends/ui/widgets/news_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/blocs/history/history_bloc.dart';
import 'package:trends/utils/utils_class.dart';

class ReadHistoryScreen extends StatefulWidget {
  static const routeName = '/read-history';

  @override
  _ReadHistoryScreenState createState() => _ReadHistoryScreenState();
}

class _ReadHistoryScreenState extends State<ReadHistoryScreen> {
  HistoryBloc historyBloc;

  @override
  void initState() {
    super.initState();
    historyBloc = BlocProvider.of<HistoryBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<HistoryBloc, HistoryState>(
          bloc: historyBloc,
          builder: (context, state) {
            if (state is HistoryInitial) {
              return Container();
            } else if (state is HistoryLoading) {
              return Center(child: Text("Đang tải"));
            } else if (state is HistoryLoaded) {
              return _buildLoadedHistory(state.articles, state.times);
            } else
              return Center(child: Text("Xảy ra lỗi"));
          },
        ),
      ),
    );
  }

  Widget _buildLoadedHistory(List<Article> articles, List<DateTime> times) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
          height: 25 * MediaQuery.of(context).size.height / 360,
          child: Center(child: Text("Tin đã xem")),
        ),
        Expanded(
          child: Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (ctx, i) {
                return Container(
                  padding: EdgeInsets.fromLTRB(4,0,4,0),
                  child: NewsWidget(
                    article: articles[i],
                    callback: () {
                      CategoryEnum catEnum = mapCategoryNames.keys.firstWhere(
                          (k) => mapCategoryNames[k] == articles[i].category,
                          orElse: () => CategoryEnum.TheGioi);
                      BlocProvider.of<SuggestArticleBloc>(context)
                          .add(FetchSuggestArticles(catEnum));
                      Navigator.of(context).pushNamed(
                          ArticleContentWidget.routeName,
                          arguments: {
                            'article': articles[i],
                            'catEnum': catEnum,
                          });
                    },
                  ),
                );
              },
              itemCount: articles.length,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          height: 25 * MediaQuery.of(context).size.height / 360,
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            color: Theme.of(context).backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            onPressed: () {
              setState(() {
                historyBloc.add(ClearAllHistory());
              });
            },
            child: Text("Xóa lịch sử"),
          ),
        ),
      ],
    ));
  }
}
