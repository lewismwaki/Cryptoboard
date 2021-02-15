part of 'set_price_cubit.dart';

abstract class SetPriceState extends Equatable {
  const SetPriceState();
}

class SetPriceInitial extends SetPriceState {
  final AssetsClass assetsClass;

  SetPriceInitial({this.assetsClass});

  @override
  List<Object> get props => [assetsClass];
}

class SetPriceOneInitial extends SetPriceState {
  final AssetsClass assetsClass;

  SetPriceOneInitial({this.assetsClass});

  @override
  List<Object> get props => [assetsClass];
}

class SetPriceTwoInitial extends SetPriceState {
  final AssetsClass assetsClass;

  SetPriceTwoInitial({this.assetsClass});

  @override
  List<Object> get props => [assetsClass];
}

class SetPriceOneSuccess extends SetPriceState {
  final AssetsClass assetsClass;

  SetPriceOneSuccess({this.assetsClass});
  @override
  List<Object> get props => [assetsClass];
}

class SetPriceTwoSuccess extends SetPriceState {
  final AssetsClass assetsClass;

  SetPriceTwoSuccess({this.assetsClass});
  @override
  List<Object> get props => [assetsClass];
}

class AllPricesLoadSuccess extends SetPriceState {
  final AssetsClass assetsClass;

  AllPricesLoadSuccess({this.assetsClass});

  @override
  List<Object> get props => [assetsClass];
}
