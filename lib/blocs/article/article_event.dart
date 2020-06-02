part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
}

class GetDailyArticle extends ArticleEvent {
  @override
  List<Object> get props => [];
}

class GetRealTimeArticle extends ArticleEvent {
  final String categoryId;
  const GetRealTimeArticle(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
