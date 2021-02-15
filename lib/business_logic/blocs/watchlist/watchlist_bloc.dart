import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cryptoboard/data/models/asset/asset_model.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchListBloc extends Bloc<WatchListEvent, List<Asset>> {
  WatchListBloc() : super(<Asset>[]);
  @override
  Stream<List<Asset>> mapEventToState(WatchListEvent event) async* {
    switch (event.watchlistAction) {
      case WatchlistAction.addToWatchlist:
        List<Asset> newState = List.from(state);
        if (event.asset != null) {
          newState.add(event.asset);
        }
        yield newState;
        break;
      case WatchlistAction.removeFromWatchlist:
        List<Asset> newState = List.from(state);
        newState.removeAt(event.assetIndex);
        yield newState;
        break;
    }

    // if (state.length == 0) {
    //   List<Asset> emptyState = List.from(state);
    //   yield emptyState;
    // }
  }
}
