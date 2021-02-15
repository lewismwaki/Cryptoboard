part of 'chart24h_cubit.dart';

abstract class Chart24hState extends Equatable {
  final ChartModel chartModel;
  const Chart24hState({this.chartModel});
}

class Chart24hInitial extends Chart24hState {
  @override
  List<Object> get props => [];
}

class Chart24hLoadInProgress extends Chart24hState {
  @override
  List<Object> get props => [];
}

class Chart24hLoadSuccess extends Chart24hState {
  final ChartModel chartModel;
  Chart24hLoadSuccess({this.chartModel});
  @override
  List<Object> get props => [chartModel];
}

class Chart24hLoadFailure extends Chart24hState {
  @override
  List<Object> get props => [];
}
