part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class NewsRequested extends NewsEvent {
  final News news;
  const NewsRequested({this.news});

  @override
  List<Object> get props => [news];
}

class NewsLoadInitial extends NewsEvent {
  final News news;
  const NewsLoadInitial({this.news});

  @override
  List<Object> get props => [news];
}

class BitcoinNewsRequested extends NewsEvent {
  final News news;
  const BitcoinNewsRequested({this.news});

  @override
  List<Object> get props => [news];
}

class EthereumNewsRequested extends NewsEvent {
  final News news;
  const EthereumNewsRequested({this.news});

  @override
  List<Object> get props => [news];
}

class RippleNewsRequested extends NewsEvent {
  final News news;
  const RippleNewsRequested({this.news});

  @override
  List<Object> get props => [news];
}
