import 'package:cryptoboard/business_logic/blocs/range_switcher/range_switcher_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/chart/chart_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChartDateRange extends StatelessWidget {
  final ChartCubit chartCubit;
  final RangeSwitcherBloc rangeSwitcherBloc;
  final String symbol;
  const ChartDateRange({Key key, this.chartCubit, this.symbol, this.rangeSwitcherBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 16.0.w),
      child: BlocBuilder<RangeSwitcherBloc, RangeSwitcherState>(
        cubit: rangeSwitcherBloc,
        builder: (context, state) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //24h
              MaterialButton(
                height: 28.0.h,
                onPressed: () {
                  chartCubit.loadPastDayChart(symbol: symbol);
                  rangeSwitcherBloc..add(LoadPastDay());
                },
                minWidth: 0.0.w,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: state is PastDayLoaded ? Colors.white : Colors.transparent,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Text(
                  ' 24h ',
                  style: normalText.copyWith(
                    color: state is PastDayLoaded ? Colors.black : Colors.white,
                    fontSize: 11.sp,
                  ),
                ),
              ),

              //1w
              MaterialButton(
                height: 28.0.h,
                onPressed: () {
                  chartCubit.loadPastWeekChart(symbol: symbol);
                  rangeSwitcherBloc..add(LoadPastWeek());
                },
                minWidth: 0.0.w,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: state is PastWeekLoaded ? Colors.white : Colors.transparent,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Text(
                  ' 7d ',
                  style: normalText.copyWith(
                    color: state is PastWeekLoaded ? Colors.black : Colors.white,
                    fontSize: 11.sp,
                  ),
                ),
              ),

              //1m
              MaterialButton(
                height: 28.0.h,
                onPressed: () {
                  chartCubit.loadPastOneMonthChart(symbol: symbol);
                  rangeSwitcherBloc..add(LoadPastOneMonth());
                },
                minWidth: 0.0.w,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: state is PastOneMonthLoaded ? Colors.white : Colors.transparent,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Text(
                  ' 1m ',
                  style: normalText.copyWith(
                    color: state is PastOneMonthLoaded ? Colors.black : Colors.white,
                    fontSize: 11.sp,
                  ),
                ),
              ),

              //2m
              MaterialButton(
                height: 28.0.h,
                onPressed: () {
                  chartCubit.loadPastTwoMonthChart(symbol: symbol);
                  rangeSwitcherBloc..add(LoadPastTwoMonth());
                },
                minWidth: 0.0.w,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: state is PastTwoMonthLoaded ? Colors.white : Colors.transparent,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Text(
                  ' 2m ',
                  style: normalText.copyWith(
                    color: state is PastTwoMonthLoaded ? Colors.black : Colors.white,
                    fontSize: 11.sp,
                  ),
                ),
              ),

              //1y
              MaterialButton(
                height: 28.0.h,
                onPressed: () {
                  chartCubit.loadPastYearChart(symbol: symbol);
                  rangeSwitcherBloc..add(LoadPastYear());
                },
                minWidth: 0.0.w,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: state is PastYearLoaded ? Colors.white : Colors.transparent,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Text(
                  ' 1y ',
                  style: normalText.copyWith(
                    color: state is PastYearLoaded ? Colors.black : Colors.white,
                    fontSize: 11.sp,
                  ),
                ),
              ),

              //all time
              MaterialButton(
                height: 28.0.h,
                onPressed: () {},
                minWidth: 0.0.w,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: Colors.transparent,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Text(
                  ' All ',
                  style: normalText.copyWith(
                    color: Colors.white,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
