part of 'home_content_cubit.dart';

abstract class HomeContentState extends Equatable {
  final AssetsClass assetsClass;
  final News news;
  const HomeContentState({this.news, this.assetsClass});
}

//loading
class HomeContentLoadInProgress extends HomeContentState {
  @override
  List<Object> get props => [];
}

//initial
class HomeContentInitial extends HomeContentState {
  @override
  List<Object> get props => [];
}

//loading failed
class HomeContentLoadFailure extends HomeContentState {
  @override
  List<Object> get props => [];
}

class HomeContentLoadSuccess extends HomeContentState {
  final AssetsClass assetsClass;
  final News trendingNews;
  // final int num;
  // final Asset data;

  HomeContentLoadSuccess({this.trendingNews, @required this.assetsClass});

  @override
  List<Object> get props => [assetsClass, trendingNews];
}

class SearchSuggestions extends HomeContentState {
  final AssetsClass assetsClass;
  final News trendingNews;
  SearchSuggestions({this.trendingNews, @required this.assetsClass});

  @override
  List<Object> get props => [assetsClass, trendingNews];
}

class SearchResults extends HomeContentState {
  final AssetsClass assetsClass;
  final News trendingNews;
  SearchResults({this.trendingNews, @required this.assetsClass});

  @override
  List<Object> get props => [assetsClass, trendingNews];
}
