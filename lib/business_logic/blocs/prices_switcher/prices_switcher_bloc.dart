import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'prices_switcher_event.dart';
part 'prices_switcher_state.dart';

class PricesSwitcherBloc extends Bloc<PricesSwitcherEvent, PricesSwitcherState> {
  PricesSwitcherBloc() : super(AssetsListLoaded());

  @override
  Stream<PricesSwitcherState> mapEventToState(PricesSwitcherEvent event) async* {
    if (event is LoadWatchList) {
      yield WatchListLoaded();
    }
    if (event is LoadAssetsList) {
      yield AssetsListLoaded();
    }
  }
}
