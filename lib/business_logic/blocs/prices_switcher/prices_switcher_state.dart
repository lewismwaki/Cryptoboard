part of 'prices_switcher_bloc.dart';

abstract class PricesSwitcherState extends Equatable {
  const PricesSwitcherState();
}

class WatchListLoaded extends PricesSwitcherState {
  @override
  List<Object> get props => [];
}
class AssetsListLoaded extends PricesSwitcherState {
  @override
  List<Object> get props => [];
}
