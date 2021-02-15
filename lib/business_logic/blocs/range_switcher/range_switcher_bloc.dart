import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'range_switcher_event.dart';
part 'range_switcher_state.dart';

class RangeSwitcherBloc extends Bloc<RangeSwitcherEvent, RangeSwitcherState> {
  RangeSwitcherBloc() : super(PastDayLoaded());

  @override
  Stream<RangeSwitcherState> mapEventToState(RangeSwitcherEvent event) async* {
    if (event is LoadPastDay) {
      yield PastDayLoaded();
    }
    if (event is LoadPastWeek) {
      yield PastWeekLoaded();
    }
    if (event is LoadPastOneMonth) {
      yield PastOneMonthLoaded();
    }
    if (event is LoadPastTwoMonth) {
      yield PastTwoMonthLoaded();
    }
    if (event is LoadPastYear) {
      yield PastYearLoaded();
    }
    if (event is LoadAllTime) {
      yield AllTimeLoaded();
    }
  }
}
