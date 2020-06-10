import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trends/blocs/article/article_bloc.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/ui/screens/article_content_screen.dart';
import 'package:trends/ui/widgets/news_widget.dart';
import 'package:trends/utils/utils_class.dart';

class NewsTab extends StatefulWidget {
  final int tabIndex;
  NewsTab({Key key, this.tabIndex}) : super(key: key);
  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab>
    with AutomaticKeepAliveClientMixin<NewsTab> {
  ArticleBloc articleBloc;
  final _debouncer = Debouncer(milliseconds: 500);
  List<Article> cachedArticles;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    cachedArticles = new List();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleInitial) {
            return buildInitialInput();
          } else if (state is ArticleLoading) {
            if (cachedArticles != null && cachedArticles.isNotEmpty)
              return buildLoadedInput(cachedArticles);
            else
              return buildLoadingInput();
          } else if (state is ArticleLoaded) {
            if (widget.tabIndex == state.tabIndex) {
              cachedArticles = state.articles[widget.tabIndex];
              return buildLoadedInput(state.articles[widget.tabIndex]);
            } else if (cachedArticles.isEmpty)
              //while switching tabs
              return buildLoadingInput();
            else
              return buildLoadedInput(cachedArticles);
          } else if (state is ArticleLoadMore) {
            cachedArticles = state.articles[widget.tabIndex];
            return buildLoadedInput(state.articles[widget.tabIndex]);
          } else if (state is ArticleRefreshed) {
            cachedArticles = state.articles[widget.tabIndex];
            return buildLoadedInput(state.articles[widget.tabIndex]);
          } else {
            return buildErrorInput();
          }
        },
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
              Navigator.of(context).pushNamed(ArticleContentScreen.routeName,
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
    await Future.delayed(Duration(milliseconds: 2000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _debouncer.run(() => _onLoading);
    //(context as Element).reassemble();
    // monitor network fetch
    articleBloc.add(LoadMoreArticles(widget.tabIndex));
    await Future.delayed(Duration(milliseconds: 2500));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    _refreshController.loadComplete();
  }

  @override
  bool get wantKeepAlive => true;
}
