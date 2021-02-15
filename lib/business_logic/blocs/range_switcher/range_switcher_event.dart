part of 'range_switcher_bloc.dart';

abstract class RangeSwitcherEvent extends Equatable {
  const RangeSwitcherEvent();
}

class LoadRangeSwitcherInitial extends RangeSwitcherEvent {
  @override
  List<Object> get props => [];
}

class LoadPastDay extends RangeSwitcherEvent {
  @override
  List<Object> get props => [];
}

class LoadPastWeek extends RangeSwitcherEvent {
  @override
  List<Object> get props => [];
}

class LoadPastOneMonth extends RangeSwitcherEvent {
  @override
  List<Object> get props => [];
}

class LoadPastTwoMonth extends RangeSwitcherEvent {
  @override
  List<Object> get props => [];
}

class LoadPastYear extends RangeSwitcherEvent {
  @override
  List<Object> get props => [];
}

class LoadAllTime extends RangeSwitcherEvent {
  @override
  List<Object> get props => [];
}
