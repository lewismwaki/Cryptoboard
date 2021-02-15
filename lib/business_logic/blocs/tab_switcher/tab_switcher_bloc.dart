import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_switcher_event.dart';
part 'tab_switcher_state.dart';

class TabSwitcherBloc extends Bloc<TabSwitcherEvent, TabSwitcherState> {
  TabSwitcherBloc() : super(LatestNewsLoaded());

  @override
  Stream<TabSwitcherState> mapEventToState(TabSwitcherEvent event) async* {
    if (event is LoadLatestNews) {
      yield LatestNewsLoaded();
    }
    if (event is LoadTopGainers) {
      yield TopGainersLoaded();
    }
    if (event is LoadTopLosers) {
      yield TopLosersLoaded();
    }
    if (event is LoadRecentlyAdded) {
      yield RecentlyAddedLoaded();
    }
  }
}
