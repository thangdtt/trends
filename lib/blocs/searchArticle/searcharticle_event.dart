part of 'searcharticle_bloc.dart';

abstract class SearchArticleEvent extends Equatable {
  const SearchArticleEvent();
}

class StartToSearchArticle extends SearchArticleEvent {
  final String query;

  StartToSearchArticle(this.query);

  @override
  List<Object> get props => [];
}