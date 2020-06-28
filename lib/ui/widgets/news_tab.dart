import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:trends/blocs/article/article_bloc.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/ui/widgets/article_content.dart';
import 'package:trends/ui/widgets/news_widget.dart';

class NewsTab extends StatefulWidget {
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
            //await Future.delayed(Duration(milliseconds: 2000));
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
              return buildLoadingInput();
            } else if (state is ArticleLoaded) {
              _currentArticles = state.articles;
              return buildLoadedInput(_currentArticles);
            } else if (state is ArticleLoadingMore) {
              return buildLoadedInput(_currentArticles);
            } else if (state is ArticleLoadMore) {
              _currentArticles = state.articles;
              return buildLoadedInput(_currentArticles);
            } else if (state is ArticleRefreshing) {
              return buildLoadedInput(_currentArticles);
            } else if (state is ArticleRefreshed) {
              _currentArticles = state.articles;
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
          } else {
            body = Text("Không còn nội dụng để tải");
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
          return NewsWidget(
            article: articles[i],
            callback: () {
              Navigator.of(context).pushNamed(ArticleContentWidget.routeName,
                  arguments: articles[i]);
            },
          );
        },
        itemCount: articles.length,
      ),
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    BlocProvider.of<ArticleBloc>(context).add(RefreshArticles());
    //await Future.delayed(Duration(milliseconds: 2000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
  }

  void _onLoading() async {
    // monitor network fetch
    BlocProvider.of<ArticleBloc>(context).add(LoadMoreArticles());
    //await Future.delayed(Duration(milliseconds: 2000));

    // if failed,use loadFailed(),if no data return,use LoadNodata()
  }

  @override
  bool get wantKeepAlive => true;
}
