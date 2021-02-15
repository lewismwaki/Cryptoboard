import 'package:bloc/bloc.dart';
import 'package:cryptoboard/data/models/chart/chart_model.dart';
import 'package:cryptoboard/data/repositories/chart_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'chart24h_state.dart';

class Chart24hCubit extends Cubit<Chart24hState> {
  final ChartRepository chartRepository;
  Chart24hCubit({@required this.chartRepository}) : super(Chart24hInitial());

  // load past day chart
  // one candle stick represents 1 hour
  // 24 candlesticks
  // https://min-api.cryptocompare.com/data/v2/histohour?fsym=btc&tsym=USDT&aggregate=1&limit=24&e=binance
  Future<void> loadPastDayChart({@required String symbol}) async {
    try {
      emit(Chart24hLoadInProgress());
      final time = 'hour';
      final limit = '23';
      final aggregate = '1';
      final ChartModel pastDayChartModel = await chartRepository.getChart(symbol: symbol, time: time, limit: limit, aggregate: aggregate);
      print('cubit done');
      // chartModel: pastDayChartModel)
      emit(Chart24hLoadSuccess(chartModel: pastDayChartModel));
    } catch (_) {
      emit(Chart24hLoadFailure());
    }
  }
}
