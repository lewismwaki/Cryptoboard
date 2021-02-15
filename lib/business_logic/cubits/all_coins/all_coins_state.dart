part of 'all_coins_cubit.dart';

abstract class AllCoinsState extends Equatable {
  final AllCoinsModel allCoinsModel;
  const AllCoinsState({this.allCoinsModel});
}

class AllCoinsInitial extends AllCoinsState {
  @override
  List<Object> get props => [];
}

class AllCoinsLoadSuccess extends AllCoinsState {
  final AllCoinsModel allCoinsModel;
  AllCoinsLoadSuccess({this.allCoinsModel});
  @override
  List<Object> get props => [];
}

class AllCoinsLoadInProgress extends AllCoinsState {
  final AllCoinsModel allCoinsModel;
  AllCoinsLoadInProgress({this.allCoinsModel});
  @override
  List<Object> get props => [];
}

class AllCoinsLoadFailure extends AllCoinsState {
  final AllCoinsModel allCoinsModel;
  AllCoinsLoadFailure({this.allCoinsModel});
  @override
  List<Object> get props => [];
}
