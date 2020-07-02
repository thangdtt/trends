part of 'suggestArticle_bloc.dart';

abstract class SuggestArticleEvent extends Equatable {
  const SuggestArticleEvent();
}

class FetchSuggestArticles extends SuggestArticleEvent {
  final categoryEnum category;
  FetchSuggestArticles(this.category);

  @override
  List<Object> get props => [];
}