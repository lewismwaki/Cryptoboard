import 'package:cryptoboard/data/data_providers/chart_data_provider.dart';
import 'package:cryptoboard/data/models/chart/chart_model.dart';
import 'package:flutter/material.dart';

class ChartRepository {
  final ChartDataProvider chartDataProvider;
  ChartRepository({@required this.chartDataProvider}) : assert(chartDataProvider != null);

  Future<ChartModel> getChart({
    @required String symbol,
    @required String time,
    @required String limit,
    @required String aggregate,
  }) async {
    return chartDataProvider.fetchChart(symbol: symbol, time: time, aggregate: aggregate, limit: limit);
  }
}
