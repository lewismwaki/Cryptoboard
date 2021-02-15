part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  final News news;

  const NewsState({this.news});
}

class NewsInitial extends NewsState {
  final News bitcoinNews;

  NewsInitial({this.bitcoinNews});
  @override
  List<Object> get props => [bitcoinNews];
}

class NewsLoadInProgress extends NewsState {
  final News news;
  NewsLoadInProgress({this.news});
  @override
  List<Object> get props => [news];
}

class NewsLoadSuccess extends NewsState {
  final News trendingNews;
  final News bitcoinNews;
  final News ethereumNews;
  final News rippleNews;
  NewsLoadSuccess({this.trendingNews, this.bitcoinNews, this.ethereumNews, this.rippleNews});
  @override
  List<Object> get props => [trendingNews, bitcoinNews, ethereumNews, rippleNews];
}

class NewsLoadFailure extends NewsState {
  final News news;
  NewsLoadFailure({this.news});
  @override
  List<Object> get props => [news];
}
