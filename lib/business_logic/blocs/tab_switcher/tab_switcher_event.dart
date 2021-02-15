part of 'tab_switcher_bloc.dart';

abstract class TabSwitcherEvent extends Equatable {
  const TabSwitcherEvent();
}

class LoadTabSwitcherInitial extends TabSwitcherEvent {
  @override
  List<Object> get props => [];
}

class LoadLatestNews extends TabSwitcherEvent {
  @override
  List<Object> get props => [];
}

class LoadTopGainers extends TabSwitcherEvent {
  @override
  List<Object> get props => [];
}

class LoadTopLosers extends TabSwitcherEvent {
  @override
  List<Object> get props => [];
}

class LoadRecentlyAdded extends TabSwitcherEvent {
  @override
  List<Object> get props => [];
}
