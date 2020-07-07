import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trends/blocs/searchArticle/searcharticle_bloc.dart';
import 'package:trends/blocs/suggestArticle/suggestArticle_bloc.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/ui/widgets/article/article_content.dart';
import 'package:trends/ui/widgets/news_widget.dart';
import 'package:trends/utils/utils_class.dart';

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
              Navigator.of(context)
                  .pushNamed(ArticleContentWidget.routeName, arguments: {
                'article': articles[i],
                'catEnum': catEnum,
              });
            },
          ),
        );
      },
      itemCount: articles.length,
    );
  }
}
