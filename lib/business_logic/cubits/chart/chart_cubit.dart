import 'package:bloc/bloc.dart';
import 'package:cryptoboard/data/models/chart/chart_model.dart';
import 'package:cryptoboard/data/repositories/chart_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'chart_state.dart';

class ChartCubit extends Cubit<ChartState> {
  final ChartRepository chartRepository;

  ChartCubit({@required this.chartRepository}) : super(ChartInitial());

  // load past day chart
  // one candle stick represents 1 hour
  // 24 candlesticks
  // https://min-api.cryptocompare.com/data/v2/histohour?fsym=btc&tsym=USDT&aggregate=1&limit=24&e=binance
  Future<void> loadPastDayChart({@required String symbol}) async {
    try {
      emit(ChartLoadInProgress());


      final time = 'hour';
      final limit = '23';
      final aggregate = '1';
      final ChartModel pastDayChartModel = await chartRepository.getChart(symbol: symbol, time: time, limit: limit, aggregate: aggregate);
      print('cubit done');
      // chartModel: pastDayChartModel)
      emit(PastDayChartLoadSuccess(chartModel: pastDayChartModel));
    } catch (_) {
      emit(ChartLoadFailure());
    }
  }

  // load past week chart
  // every candlestick represents 6 hours
  // 29 candlesticks
  //https://min-api.cryptocompare.com/data/v2/histohour?fsym=btc&tsym=USDT&aggregate=6&limit=29&e=binance
  Future<void> loadPastWeekChart({@required String symbol}) async {
    try {
      emit(ChartLoadInProgress());
      final time = 'hour';
      final limit = '28';
      final aggregate = '6';
      final ChartModel pastWeekChartModel = await chartRepository.getChart(symbol: symbol, aggregate: aggregate, time: time, limit: limit);
      emit(PastWeekChartLoadSuccess(chartModel: pastWeekChartModel));
    } catch (_) {
      emit(ChartLoadFailure());
    }
  }

  // load past one month chart
  // every candlestick represents 1 day
  // 30 candlesticks
  //https://min-api.cryptocompare.com/data/v2/histoday?fsym=btc&tsym=USDT&aggregate=1&limit=30&e=binance
  Future<void> loadPastOneMonthChart({@required String symbol}) async {
    try {
      emit(ChartLoadInProgress());
      final time = 'day';
      final limit = '29';
      final aggregate = '1';
      final ChartModel pastOneMonthChartModel = await chartRepository.getChart(symbol: symbol, limit: limit, time: time, aggregate: aggregate);
      emit(PastOneMonthChartLoadSuccess(chartModel: pastOneMonthChartModel));
    } catch (_) {
      emit(ChartLoadFailure());
    }
  }

  // load past six months chart
  // every candlestick represents 2 days
  // 30 candlesticks
  // https://min-api.cryptocompare.com/data/v2/histoday?fsym=btc&tsym=USDT&aggregate=2&limit=30&e=binance
  Future<void> loadPastTwoMonthChart({@required String symbol}) async {
    try {
      emit(ChartLoadInProgress());
      final time = 'day';
      final limit = '29';
      final aggregate = '2';
      final ChartModel pastTwoMonthChartModel = await chartRepository.getChart(symbol: symbol, limit: limit, time: time, aggregate: aggregate);
      emit(PastTwoMonthChartLoadSuccess(chartModel: pastTwoMonthChartModel));
    } catch (_) {
      emit(ChartLoadFailure());
    }
  }

  // load annual chart
  // each candlestick represents 7 days
  // 52 candlesticks
  // https://min-api.cryptocompare.com/data/v2/histoday?fsym=btc&tsym=USDT&aggregate=7&limit=52&e=binance
  Future<void> loadPastYearChart({@required String symbol}) async {
    try {
      emit(ChartLoadInProgress());
      final time = 'day';
      final limit = '51';
      final aggregate = '7';
      final ChartModel pastYearChartModel = await chartRepository.getChart(symbol: symbol, limit: limit, time: time, aggregate: aggregate);
      emit(PastYearChartLoadSuccess(chartModel: pastYearChartModel));
    } catch (_) {
      emit(ChartLoadFailure());
    }
  }

// load all time chart
// each candlestick represents
//   //
//   Future<void> loadAllTimeChart({@required String symbol}) async {
//     try {
//       emit(ChartLoadInProgress());
//       final ChartModel allTimeChartModel = await chartRepository.getChart(symbol: symbol, limit: limit, time: time, aggregate: aggregate);
//       emit(AllTimeChartLoadSuccess(chartModel: allTimeChartModel));
//     } catch (_) {
//       emit(ChartLoadFailure());
//     }
//   }
// }
}
