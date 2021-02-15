import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_bar_event.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  BottomNavBarBloc() : super(LoadedHomePage());

  @override
  Stream<BottomNavBarState> mapEventToState(BottomNavBarEvent event) async* {
    if (event is LoadHomePage) {
      yield LoadedHomePage();
    }
    if (event is LoadPricesPage) {
      yield LoadedPricesPage();
    }
    if (event is LoadDiscoverPage) {
      yield LoadedDiscoverPage();
    }
    if (event is LoadSettingsPage) {
      yield LoadedSettingsPage();
    }
  }
}
