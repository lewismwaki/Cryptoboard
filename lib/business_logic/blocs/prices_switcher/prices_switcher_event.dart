part of 'prices_switcher_bloc.dart';

abstract class PricesSwitcherEvent extends Equatable {
  const PricesSwitcherEvent();
}

class LoadWatchList extends PricesSwitcherEvent {
  @override
  List<Object> get props => [];
}

class LoadAssetsList extends PricesSwitcherEvent {
  @override
  List<Object> get props => [];
}
