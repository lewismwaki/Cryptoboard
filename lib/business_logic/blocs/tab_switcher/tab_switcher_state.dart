part of 'tab_switcher_bloc.dart';

abstract class TabSwitcherState extends Equatable {
  const TabSwitcherState();
}

class TabSwitcherInitial extends TabSwitcherState {
  @override
  List<Object> get props => [];
}

class LatestNewsLoaded extends TabSwitcherState {
  @override
  List<Object> get props => [];
}

class TopGainersLoaded extends TabSwitcherState {
  @override
  List<Object> get props => [];
}

class TopLosersLoaded extends TabSwitcherState {
  @override
  List<Object> get props => [];
}

class RecentlyAddedLoaded extends TabSwitcherState {
  @override
  List<Object> get props => [];
}
