part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();
}

class WatchlistInitial extends WatchlistState {
  @override
  List<Object> get props => [];
}

class EmptyWatchListLoaded extends WatchlistState {
  @override
  List<Object> get props => [];
}
