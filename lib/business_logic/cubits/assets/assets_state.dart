part of 'assets_cubit.dart';

abstract class AssetsState extends Equatable {
  final AssetsClass assetsClass;
  const AssetsState({this.assetsClass});
}

//loading
class AssetsLoadInProgress extends AssetsState {
  @override
  List<Object> get props => [];
}

//initial
class AssetsInitial extends AssetsState {
  @override
  List<Object> get props => [];
}

//loading failed
class AssetsLoadFailure extends AssetsState {
  @override
  List<Object> get props => [];
}

//by rank
class AssetsSortedByRankAscending extends AssetsState {
  final AssetsClass assetsClass;

  AssetsSortedByRankAscending({@required this.assetsClass});

  @override
  List<Object> get props => [assetsClass];
}

class AssetsSortedByRankDescending extends AssetsState {
  final AssetsClass assetsClass;

  AssetsSortedByRankDescending({@required this.assetsClass});

  @override
  List<Object> get props => [assetsClass];
}

//by market cap
class AssetsSortedByMarketCapAscending extends AssetsState {
  final AssetsClass assetsClass;

  AssetsSortedByMarketCapAscending({@required this.assetsClass});

  @override
  List<Object> get props => [assetsClass];
}

class AssetsSortedByMarketCapDescending extends AssetsState {
  final AssetsClass assetsClass;

  AssetsSortedByMarketCapDescending({@required this.assetsClass});

  @override
  List<Object> get props => [assetsClass];
}

//by percentage change

class AssetsSortedByPercentageChangeAscending extends AssetsState {
  final AssetsClass assetsClass;

  AssetsSortedByPercentageChangeAscending({@required this.assetsClass});
  @override
  List<Object> get props => [assetsClass];
}

class AssetsSortedByPercentageChangeDescending extends AssetsState {
  final AssetsClass assetsClass;

  AssetsSortedByPercentageChangeDescending({@required this.assetsClass});
  @override
  List<Object> get props => [assetsClass];
}

//by name

class AssetsSortedByNameAscending extends AssetsState {
  final AssetsClass assetsClass;

  AssetsSortedByNameAscending({@required this.assetsClass});
  @override
  List<Object> get props => [assetsClass];
}

class AssetsSortedByNameDescending extends AssetsState {
  final AssetsClass assetsClass;

  AssetsSortedByNameDescending({@required this.assetsClass});
  @override
  List<Object> get props => [assetsClass];
}

//by max supply

class AssetsSortedByMaxSupplyAscending extends AssetsState {
  final AssetsClass assetsClass;

  AssetsSortedByMaxSupplyAscending({@required this.assetsClass});
  @override
  List<Object> get props => [assetsClass];
}

class AssetsSortedByMaxSupplyDescending extends AssetsState {
  final AssetsClass assetsClass;

  AssetsSortedByMaxSupplyDescending({@required this.assetsClass});
  @override
  List<Object> get props => [assetsClass];
}

//price

class AssetsSortedByPriceAscending extends AssetsState {
  final AssetsClass assetsClass;

  AssetsSortedByPriceAscending({@required this.assetsClass});
  @override
  List<Object> get props => [assetsClass];
}

class AssetsSortedByPriceDescending extends AssetsState {
  final AssetsClass assetsClass;

  AssetsSortedByPriceDescending({@required this.assetsClass});
  @override
  List<Object> get props => [assetsClass];
}

class AssetsSortedByVolume24hrAscending extends AssetsState {
  final AssetsClass assetsClass;

  AssetsSortedByVolume24hrAscending({@required this.assetsClass});
  @override
  List<Object> get props => [assetsClass];
}

class AssetsSortedByVolume24hrDescending extends AssetsState {
  final AssetsClass assetsClass;

  AssetsSortedByVolume24hrDescending({@required this.assetsClass});
  @override
  List<Object> get props => [assetsClass];
}
