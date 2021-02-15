part of 'chart_cubit.dart';

abstract class ChartState extends Equatable {
  final ChartModel chartModel;
  const ChartState({this.chartModel});
}

class ChartInitial extends ChartState {
  @override
  List<Object> get props => [];
}

class ChartLoadInProgress extends ChartState {
  @override
  List<Object> get props => [];
}

class ChartLoadFailure extends ChartState {
  @override
  List<Object> get props => [];
}

class ChartLoadSuccess extends ChartState {
  final ChartModel chartModel;

  ChartLoadSuccess({this.chartModel});

  @override
  List<Object> get props => [chartModel];
}

class PastDayChartLoadSuccess extends ChartState {
  final ChartModel chartModel;

  PastDayChartLoadSuccess({this.chartModel});
  @override
  List<Object> get props => [chartModel];
}

class PastWeekChartLoadSuccess extends ChartState {
  final ChartModel chartModel;

  PastWeekChartLoadSuccess({this.chartModel});

  @override
  List<Object> get props => [chartModel];
}

class PastOneMonthChartLoadSuccess extends ChartState {
  final ChartModel chartModel;

  PastOneMonthChartLoadSuccess({this.chartModel});

  @override
  List<Object> get props => [chartModel];
}

class PastTwoMonthChartLoadSuccess extends ChartState {
  final ChartModel chartModel;

  PastTwoMonthChartLoadSuccess({this.chartModel});

  @override
  List<Object> get props => [chartModel];
}

class PastYearChartLoadSuccess extends ChartState {
  final ChartModel chartModel;

  PastYearChartLoadSuccess({this.chartModel});

  @override
  List<Object> get props => [chartModel];
}
//
// class AllTimeChartLoadSuccess extends ChartState {
//   final ChartModel chartModel;
//
//   AllTimeChartLoadSuccess({this.chartModel});
//
//   @override
//   List<Object> get props => [chartModel];
// }
