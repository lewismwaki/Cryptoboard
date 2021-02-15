part of 'watchlist_bloc.dart';

enum WatchlistAction { addToWatchlist, removeFromWatchlist }

// ignore: must_be_immutable
class WatchListEvent extends Equatable {
  Asset asset;
  int assetIndex;
  bool isWatchlisted;
  WatchlistAction watchlistAction;

  WatchListEvent.add({Asset addedAsset, bool isWatchlisted}) {
    this.watchlistAction = WatchlistAction.addToWatchlist;
    this.isWatchlisted = true;
    this.asset = addedAsset;
  }
  WatchListEvent.delete({int deletedIndex, bool isWatchlisted}) {
    this.watchlistAction = WatchlistAction.removeFromWatchlist;
    this.isWatchlisted = false;
    this.assetIndex = deletedIndex;
  }

  @override
  List<Object> get props => [];
}
