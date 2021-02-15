import 'dart:math';

import 'package:cryptoboard/business_logic/blocs/network/network_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/chart/chart_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/data/models/chart/chart_model.dart';
import 'package:cryptoboard/presentation/screens/errors/internal_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CandlesticksChart extends StatelessWidget {
  final ChartCubit chartCubit;

  const CandlesticksChart({Key key, this.chartCubit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
      child: Container(
        height: 350.h,
        width: 1.sw,
        child: BlocBuilder<ChartCubit, ChartState>(
          cubit: chartCubit,
          builder: (context, state) {
            if (state is PastDayChartLoadSuccess) {
              return SfCartesianChart(
                selectionGesture: ActivationMode.longPress,
                enableAxisAnimation: true,
                backgroundColor: Colors.black,
                plotAreaBorderColor: Colors.black,
                trackballBehavior: TrackballBehavior(
                  lineType: TrackballLineType.vertical,
                  lineColor: Color(0xff23262D),
                  lineWidth: 0.5.w,
                  enable: true,
                  tooltipAlignment: ChartAlignment.near,
                  activationMode: ActivationMode.longPress,
                  tooltipSettings: InteractiveTooltip(
                    enable: true,
                    format: 'High: \$point.high\nLow: \$point.low',
                  ),
                ),
                crosshairBehavior: CrosshairBehavior(
                  lineType: CrosshairLineType.none,
                  enable: true,
                  activationMode: ActivationMode.longPress,
                  hideDelay: 300,
                ),
                primaryXAxis: DateTimeAxis(
                  opposedPosition: true,
                  majorGridLines: MajorGridLines(color: Colors.transparent),
                  isVisible: true,
                  placeLabelsNearAxisLine: true,
                  dateFormat: DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).add_j(),
                  rangePadding: ChartRangePadding.none,
                  labelStyle: TextStyle(
                    color: Colors.transparent,
                  ),
                  interactiveTooltip: InteractiveTooltip(
                    enable: true,
                    textStyle: initialsText.copyWith(
                      fontSize: 12.0.sp,
                    ),
                    borderColor: Colors.transparent,
                    color: Colors.transparent,
                    borderWidth: 0.0,
                    arrowLength: 0,
                    arrowWidth: 0,
                  ),
                  majorTickLines: MajorTickLines(
                    color: Colors.black,
                  ),
                  enableAutoIntervalOnZooming: true,
                  axisLine: AxisLine(
                    color: Colors.black,
                  ),
                  minorTickLines: MinorTickLines(
                    color: Colors.black,
                  ),
                ),
                primaryYAxis: NumericAxis(
                  majorGridLines: MajorGridLines(color: Color(0xff23262D)),
                  isVisible: true,
                  placeLabelsNearAxisLine: true,
                  labelStyle: TextStyle(
                    color: Color(0xff6B6E76),
                    fontSize: 10.0.sp,
                  ),
                  interactiveTooltip: InteractiveTooltip(
                    enable: false,
                  ),
                  majorTickLines: MajorTickLines(
                    color: Colors.black,
                  ),
                  enableAutoIntervalOnZooming: true,
                  axisLine: AxisLine(
                    color: Colors.black,
                  ),
                  minorTickLines: MinorTickLines(
                    color: Colors.black,
                  ),
                  minimum: state.chartModel.data.data != null && state.chartModel.data.data.isNotEmpty
                      ? state.chartModel.data.data.map<double>((e) => e.low).reduce(min)
                      : 0.toDouble(),
                ),
                series: <ChartSeries>[
                  CandleSeries<Datum, dynamic>(
                    bearColor: Color(0xffED376A),
                    bullColor: Color(0xff01D7A3),
                    animationDuration: 1800,
                    enableSolidCandles: true,
                    borderWidth: 1.w,
                    enableTooltip: true,
                    showIndicationForSameValues: true,
                    dataSource: state.chartModel.data.data,
                    xValueMapper: (Datum candlestickData, _) {
                      final timeStamp = candlestickData.time;
                      final chartTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000).toLocal();
                      return chartTime;
                    },
                    closeValueMapper: (Datum candlestickData, _) => candlestickData.close,
                    highValueMapper: (Datum candlestickData, _) => candlestickData.high,
                    openValueMapper: (Datum candlestickData, _) => candlestickData.open,
                    lowValueMapper: (Datum candlestickData, _) => candlestickData.low,
                  ),
                ],
              );
            }
            if (state is PastWeekChartLoadSuccess) {
              return SfCartesianChart(
                selectionGesture: ActivationMode.longPress,
                enableAxisAnimation: true,
                backgroundColor: Colors.black,
                trackballBehavior: TrackballBehavior(
                  lineType: TrackballLineType.vertical,
                  lineColor: Color(0xff23262D),
                  lineWidth: 0.5.w,
                  enable: true,
                  tooltipAlignment: ChartAlignment.near,
                  activationMode: ActivationMode.longPress,
                  tooltipSettings: InteractiveTooltip(
                    enable: true,
                    format: 'High: \$point.high\nLow: \$point.low',
                  ),
                ),
                crosshairBehavior: CrosshairBehavior(
                  lineType: CrosshairLineType.none,
                  enable: true,
                  activationMode: ActivationMode.longPress,
                  hideDelay: 300,
                ),
                plotAreaBorderColor: Colors.black,
                primaryXAxis: DateTimeAxis(
                  opposedPosition: true,
                  majorGridLines: MajorGridLines(color: Colors.transparent),
                  isVisible: true,
                  placeLabelsNearAxisLine: true,
                  dateFormat: DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).add_j(),
                  rangePadding: ChartRangePadding.none,
                  labelStyle: TextStyle(
                    color: Colors.transparent,
                  ),
                  interactiveTooltip: InteractiveTooltip(
                    enable: true,
                    textStyle: initialsText.copyWith(
                      fontSize: 12.0.sp,
                    ),
                    borderColor: Colors.transparent,
                    color: Colors.transparent,
                    borderWidth: 0.0,
                    arrowLength: 0,
                    arrowWidth: 0,
                  ),
                  majorTickLines: MajorTickLines(
                    color: Colors.black,
                  ),
                  enableAutoIntervalOnZooming: true,
                  axisLine: AxisLine(
                    color: Colors.black,
                  ),
                  minorTickLines: MinorTickLines(
                    color: Colors.black,
                  ),
                ),
                primaryYAxis: NumericAxis(
                  majorGridLines: MajorGridLines(color: Color(0xff23262D)),
                  isVisible: true,
                  placeLabelsNearAxisLine: true,
                  labelStyle: TextStyle(
                    color: Color(0xff6B6E76),
                    fontSize: 10.0.sp,
                  ),
                  interactiveTooltip: InteractiveTooltip(
                    enable: false,
                  ),
                  majorTickLines: MajorTickLines(
                    color: Colors.black,
                  ),
                  enableAutoIntervalOnZooming: true,
                  axisLine: AxisLine(
                    color: Colors.black,
                  ),
                  minorTickLines: MinorTickLines(
                    color: Colors.black,
                  ),
                  minimum: state.chartModel.data.data != null && state.chartModel.data.data.isNotEmpty
                      ? state.chartModel.data.data.map<double>((e) => e.low).reduce(min)
                      : 0.toDouble(),
                ),
                series: <ChartSeries>[
                  CandleSeries<Datum, dynamic>(
                    bearColor: Color(0xffED376A),
                    bullColor: Color(0xff01D7A3),
                    animationDuration: 1800,
                    enableSolidCandles: true,
                    borderWidth: 1.w,
                    enableTooltip: true,
                    showIndicationForSameValues: true,
                    dataSource: state.chartModel.data.data,
                    xValueMapper: (Datum candlestickData, _) {
                      final timeStamp = candlestickData.time;
                      final chartTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000).toLocal();

                      return chartTime;
                    },
                    closeValueMapper: (Datum candlestickData, _) => candlestickData.close,
                    highValueMapper: (Datum candlestickData, _) => candlestickData.high,
                    openValueMapper: (Datum candlestickData, _) => candlestickData.open,
                    lowValueMapper: (Datum candlestickData, _) => candlestickData.low,
                  ),
                ],
              );
            }
            if (state is PastOneMonthChartLoadSuccess) {
              return SfCartesianChart(
                selectionGesture: ActivationMode.longPress,
                enableAxisAnimation: true,
                backgroundColor: Colors.black,
                trackballBehavior: TrackballBehavior(
                  lineType: TrackballLineType.vertical,
                  lineColor: Color(0xff23262D),
                  lineWidth: 0.5.w,
                  enable: true,
                  tooltipAlignment: ChartAlignment.near,
                  activationMode: ActivationMode.longPress,
                  tooltipSettings: InteractiveTooltip(
                    enable: true,
                    format: 'High: \$point.high\nLow: \$point.low',
                  ),
                ),
                crosshairBehavior: CrosshairBehavior(
                  lineType: CrosshairLineType.none,
                  enable: true,
                  activationMode: ActivationMode.longPress,
                  hideDelay: 300,
                ),
                plotAreaBorderColor: Colors.black,
                plotAreaBorderWidth: 0.0,
                primaryXAxis: DateTimeAxis(
                  opposedPosition: true,
                  majorGridLines: MajorGridLines(color: Colors.transparent),
                  isVisible: true,
                  placeLabelsNearAxisLine: true,
                  dateFormat: DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).add_j(),
                  rangePadding: ChartRangePadding.none,
                  labelStyle: TextStyle(
                    color: Colors.transparent,
                  ),
                  interactiveTooltip: InteractiveTooltip(
                    enable: true,
                    textStyle: initialsText.copyWith(
                      fontSize: 12.0.sp,
                    ),
                    borderColor: Colors.transparent,
                    color: Colors.transparent,
                    borderWidth: 0.0,
                    arrowLength: 0,
                    arrowWidth: 0,
                  ),
                  majorTickLines: MajorTickLines(
                    color: Colors.black,
                  ),
                  enableAutoIntervalOnZooming: true,
                  axisLine: AxisLine(
                    color: Colors.black,
                  ),
                  minorTickLines: MinorTickLines(
                    color: Colors.black,
                  ),
                ),
                primaryYAxis: NumericAxis(
                  majorGridLines: MajorGridLines(color: Color(0xff23262D)),
                  isVisible: true,
                  placeLabelsNearAxisLine: true,
                  labelStyle: TextStyle(
                    color: Color(0xff6B6E76),
                    fontSize: 10.0.sp,
                  ),
                  interactiveTooltip: InteractiveTooltip(
                    enable: false,
                  ),
                  majorTickLines: MajorTickLines(
                    color: Colors.black,
                  ),
                  enableAutoIntervalOnZooming: true,
                  axisLine: AxisLine(
                    color: Colors.black,
                  ),
                  minorTickLines: MinorTickLines(
                    color: Colors.black,
                  ),
                  minimum: state.chartModel.data.data != null && state.chartModel.data.data.isNotEmpty
                      ? state.chartModel.data.data.map<double>((e) => e.low).reduce(min)
                      : 0.toDouble(),
                ),
                series: <ChartSeries>[
                  CandleSeries<Datum, dynamic>(
                    bearColor: Color(0xffED376A),
                    bullColor: Color(0xff01D7A3),
                    animationDuration: 1800,
                    enableSolidCandles: true,
                    borderWidth: 1.w,
                    enableTooltip: true,
                    showIndicationForSameValues: true,
                    dataSource: state.chartModel.data.data,
                    xValueMapper: (Datum candlestickData, _) {
                      final timeStamp = candlestickData.time;
                      final chartTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000).toLocal();

                      return chartTime;
                    },
                    closeValueMapper: (Datum candlestickData, _) => candlestickData.close,
                    highValueMapper: (Datum candlestickData, _) => candlestickData.high,
                    openValueMapper: (Datum candlestickData, _) => candlestickData.open,
                    lowValueMapper: (Datum candlestickData, _) => candlestickData.low,
                  ),
                ],
              );
            }
            if (state is PastTwoMonthChartLoadSuccess) {
              return SfCartesianChart(
                selectionGesture: ActivationMode.longPress,
                enableAxisAnimation: true,
                backgroundColor: Colors.black,
                trackballBehavior: TrackballBehavior(
                  lineType: TrackballLineType.vertical,
                  lineColor: Color(0xff23262D),
                  lineWidth: 0.5.w,
                  enable: true,
                  tooltipAlignment: ChartAlignment.near,
                  activationMode: ActivationMode.longPress,
                  tooltipSettings: InteractiveTooltip(
                    enable: true,
                    format: 'High: \$point.high\nLow: \$point.low',
                  ),
                ),
                crosshairBehavior: CrosshairBehavior(
                  lineType: CrosshairLineType.none,
                  enable: true,
                  activationMode: ActivationMode.longPress,
                  hideDelay: 300,
                ),
                plotAreaBorderColor: Colors.black,
                primaryXAxis: DateTimeAxis(
                  opposedPosition: true,
                  majorGridLines: MajorGridLines(color: Colors.transparent),
                  isVisible: true,
                  placeLabelsNearAxisLine: true,
                  dateFormat: DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).add_j(),
                  rangePadding: ChartRangePadding.none,
                  labelStyle: TextStyle(
                    color: Colors.transparent,
                  ),
                  interactiveTooltip: InteractiveTooltip(
                    enable: true,
                    textStyle: initialsText.copyWith(
                      fontSize: 12.0.sp,
                    ),
                    borderColor: Colors.transparent,
                    color: Colors.transparent,
                    borderWidth: 0.0,
                    arrowLength: 0,
                    arrowWidth: 0,
                  ),
                  majorTickLines: MajorTickLines(
                    color: Colors.black,
                  ),
                  enableAutoIntervalOnZooming: true,
                  axisLine: AxisLine(
                    color: Colors.black,
                  ),
                  minorTickLines: MinorTickLines(
                    color: Colors.black,
                  ),
                ),
                primaryYAxis: NumericAxis(
                  majorGridLines: MajorGridLines(color: Color(0xff23262D)),
                  isVisible: true,
                  placeLabelsNearAxisLine: true,
                  labelStyle: TextStyle(
                    color: Color(0xff6B6E76),
                    fontSize: 10.0.sp,
                  ),
                  interactiveTooltip: InteractiveTooltip(
                    enable: false,
                  ),
                  majorTickLines: MajorTickLines(
                    color: Colors.black,
                  ),
                  enableAutoIntervalOnZooming: true,
                  axisLine: AxisLine(
                    color: Colors.black,
                  ),
                  minorTickLines: MinorTickLines(
                    color: Colors.black,
                  ),
                  minimum: state.chartModel.data.data != null && state.chartModel.data.data.isNotEmpty
                      ? state.chartModel.data.data.map<double>((e) => e.low).reduce(min)
                      : 0.toDouble(),
                ),
                series: <ChartSeries>[
                  CandleSeries<Datum, dynamic>(
                    bearColor: Color(0xffED376A),
                    bullColor: Color(0xff01D7A3),
                    animationDuration: 1800,
                    enableSolidCandles: true,
                    borderWidth: 1.w,
                    enableTooltip: true,
                    showIndicationForSameValues: true,
                    dataSource: state.chartModel.data.data,
                    xValueMapper: (Datum candlestickData, _) {
                      final timeStamp = candlestickData.time;
                      final chartTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000).toLocal();
                      return chartTime;
                    },
                    closeValueMapper: (Datum candlestickData, _) => candlestickData.close,
                    highValueMapper: (Datum candlestickData, _) => candlestickData.high,
                    openValueMapper: (Datum candlestickData, _) => candlestickData.open,
                    lowValueMapper: (Datum candlestickData, _) => candlestickData.low,
                  ),
                ],
              );
            }
            if (state is PastYearChartLoadSuccess) {
              return SfCartesianChart(
                selectionGesture: ActivationMode.longPress,
                enableAxisAnimation: true,
                backgroundColor: Colors.black,
                trackballBehavior: TrackballBehavior(
                  lineType: TrackballLineType.vertical,
                  lineColor: Color(0xff23262D),
                  lineWidth: 0.5.w,
                  enable: true,
                  tooltipAlignment: ChartAlignment.near,
                  activationMode: ActivationMode.longPress,
                  tooltipSettings: InteractiveTooltip(
                    enable: true,
                    format: 'High: \$point.high\nLow: \$point.low',
                  ),
                ),
                crosshairBehavior: CrosshairBehavior(
                  lineType: CrosshairLineType.none,
                  enable: true,
                  activationMode: ActivationMode.longPress,
                  hideDelay: 300,
                ),
                plotAreaBorderColor: Colors.black,
                primaryXAxis: DateTimeAxis(
                  opposedPosition: true,
                  majorGridLines: MajorGridLines(color: Colors.transparent),
                  isVisible: true,
                  placeLabelsNearAxisLine: true,
                  dateFormat: DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).add_j(),
                  rangePadding: ChartRangePadding.none,
                  labelStyle: TextStyle(
                    color: Colors.transparent,
                  ),
                  interactiveTooltip: InteractiveTooltip(
                    enable: true,
                    textStyle: initialsText.copyWith(
                      fontSize: 12.0.sp,
                    ),
                    borderColor: Colors.transparent,
                    color: Colors.transparent,
                    borderWidth: 0.0,
                    arrowLength: 0,
                    arrowWidth: 0,
                  ),
                  majorTickLines: MajorTickLines(
                    color: Colors.black,
                  ),
                  enableAutoIntervalOnZooming: true,
                  axisLine: AxisLine(
                    color: Colors.black,
                  ),
                  minorTickLines: MinorTickLines(
                    color: Colors.black,
                  ),
                ),
                primaryYAxis: NumericAxis(
                  majorGridLines: MajorGridLines(color: Color(0xff23262D)),
                  isVisible: true,
                  placeLabelsNearAxisLine: true,
                  desiredIntervals: 6,
                  labelStyle: TextStyle(
                    color: Color(0xff6B6E76),
                    fontSize: 10.0.sp,
                  ),
                  interactiveTooltip: InteractiveTooltip(
                    enable: false,
                  ),
                  majorTickLines: MajorTickLines(
                    color: Colors.black,
                  ),
                  enableAutoIntervalOnZooming: true,
                  axisLine: AxisLine(
                    color: Colors.black,
                  ),
                  minorTickLines: MinorTickLines(
                    color: Colors.black,
                  ),
                  minimum: state.chartModel.data.data != null && state.chartModel.data.data.isNotEmpty
                      ? state.chartModel.data.data.map<double>((e) => e.low).reduce(min)
                      : 0.toDouble(),
                ),
                series: <ChartSeries>[
                  CandleSeries<Datum, dynamic>(
                    bearColor: Color(0xffED376A),
                    bullColor: Color(0xff01D7A3),
                    animationDuration: 1800,
                    enableSolidCandles: true,
                    borderWidth: 1.w,
                    enableTooltip: true,
                    showIndicationForSameValues: true,
                    dataSource: state.chartModel.data.data,
                    xValueMapper: (Datum candlestickData, _) {
                      final timeStamp = candlestickData.time;
                      final chartTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000).toLocal();

                      return chartTime;
                    },
                    closeValueMapper: (Datum candlestickData, _) => candlestickData.close,
                    highValueMapper: (Datum candlestickData, _) => candlestickData.high,
                    openValueMapper: (Datum candlestickData, _) => candlestickData.open,
                    lowValueMapper: (Datum candlestickData, _) => candlestickData.low,
                  ),
                ],
              );
            }
            if (state is ChartLoadFailure) {
              return BlocBuilder<NetworkBloc, NetworkState>(
                builder: (context, state) {
                  if (state is ConnectionFailure) {
                    return Container(
                      height: 400.h,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 80.0.w, right: 80.0.w, top: 20.0.h, bottom: 20.0.h),
                            child: Container(
                              width: 1.sw,
                              color: Colors.black,
                              child: Image.asset(
                                'assets/images/no-internet.png',
                                fit: BoxFit.fitWidth,
                                width: 1.sw,
                              ),
                            ),
                          ),
                          Text(
                            'Oops! An error occurred',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 19.0.sp,
                              color: Color(0xff3861FB),
                            ),
                          ),
                          SizedBox(height: 8.0.h),
                          Padding(
                            padding: EdgeInsets.only(left: 50.0.w, right: 50.0.w),
                            child: Text(
                              'Please check your internet connection and try again',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff82899E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else
                    return InternalError();
                },
              );
            }
            if (state is ChartLoadInProgress) {
              return Container(
                height: 400.h,
                width: 1.sw,
                color: Colors.black,
                child: SpinKitRipple(
                  color: Colors.white,
                ),
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
