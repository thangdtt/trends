import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:trends/blocs/article/article_bloc.dart';
import 'package:trends/blocs/suggestArticle/suggestArticle_bloc.dart';
import 'package:trends/blocs/history/history_bloc.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/ui/widgets/article/article_content.dart';
import 'package:trends/ui/widgets/news_widget.dart';

class NewsTab extends StatefulWidget {
  final catEnum;
  NewsTab({this.catEnum});
  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab>
    with AutomaticKeepAliveClientMixin<NewsTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Article> _currentArticles;
  @override
  void initState() {
    super.initState();
    _currentArticles = [];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: BlocConsumer<ArticleBloc, ArticleState>(
          listener: (context, state) {
            if (state is ArticleRefreshed) {
              _refreshController.refreshCompleted();
            }
            if (state is ArticleLoadMore) {
              _refreshController.loadComplete();
            }
          },
          builder: (context, state) {
            if (state is ArticleInitial) {
              return buildInitialInput();
            } else if (state is ArticleLoading) {
              if (_currentArticles.isEmpty)
                return buildLoadingInput();
              else
                return buildLoadedInput(_currentArticles);
            } else if (state is ArticleLoaded) {
              if (_currentArticles.isEmpty)
                _currentArticles = state.articles[widget.catEnum];
              return buildLoadedInput(_currentArticles);
            } else if (state is ArticleLoadingMore) {
              return buildLoadedInput(_currentArticles);
            } else if (state is ArticleLoadMore) {
              _currentArticles = state.articles[widget.catEnum];
              return buildLoadedInput(_currentArticles);
            } else if (state is ArticleRefreshing) {
              return buildLoadedInput(_currentArticles);
            } else if (state is ArticleRefreshed) {
              _currentArticles = state.articles[widget.catEnum];
              return buildLoadedInput(_currentArticles);
            } else {
              return buildErrorInput();
            }
          },
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Container(
      color: Theme.of(context).canvasColor,
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
      child: Center(
        child: Text(
          "ERROR !!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildLoadedInput(List<Article> articles) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: ClassicHeader(),
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = SizedBox();
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Tải thêm không thành công !");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("Buông để tải thêm");
          } else if (mode == LoadStatus.noMore) {
            body = Text("Không còn nội dụng để tải");
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Không còn nội dụng để tải'),
              duration: (Duration(seconds: 1)),
            ));
          } else {
            body = Text("");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
              itemBuilder: (ctx, i) {
                return Container(
                  padding: EdgeInsets.fromLTRB(4,0,4,0),
                  child: NewsWidget(
                    article: articles[i],
                    callback: () {
                      BlocProvider.of<SuggestArticleBloc>(context)
                          .add(FetchSuggestArticles(widget.catEnum));
                      BlocProvider.of<HistoryBloc>(context)
                          .add(AddToHistory(articles[i].id));
                      Navigator.of(context)
                          .pushNamed(ArticleContentWidget.routeName, arguments: {
                        'article': articles[i],
                        'catEnum': widget.catEnum,
                      });
                    },
                  ),
                );
              },
              itemCount: articles.length,
            ),
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    BlocProvider.of<ArticleBloc>(context).add(RefreshArticles(widget.catEnum));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
  }

  void _onLoading() async {
    // monitor network fetch
    BlocProvider.of<ArticleBloc>(context).add(LoadMoreArticles(widget.catEnum));

    // if failed,use loadFailed(),if no data return,use LoadNodata()
  }

  @override
  bool get wantKeepAlive => true;
}
